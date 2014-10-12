
/*
 <codex/>
 */

#ifndef __CODEX__
/*
 $Log$
 12jun2012 etirathompson
 Updates for AVCaptureMetadataOutput-based face detection
 
 14jun2011 bford
 Now that the fix for <rdar://problem/9556918> is checked in, allow mustache insertion in scale and
 cropped pictures (use BGRA and do the compositing).
 
 07jun2011 bford
 Renamed _ prefixed methods.
 
 6jun2011 bford
 ___CODEX__ -> __CODEX__.  Be careful whom you copy/paste from.
 
 6jun2011 bford
 first time.
 */ 
#endif

#import "StacheCamViewController.h"
#import <AssertMacros.h>
#import "StacheCamViewController+CIFaceDetection.h"
#import "StacheCamViewController+AVFFaceDetection.h"
#import "StacheCamViewController+Graphics.h"
#import "UserDefaults.h"
#import "animateGIF/exportAnimatedGif.h"
#import "animateGIF/UIImage+animatedGIF.h"

#import "ViewController.h"

static char * const AVCaptureStillImageIsCapturingStillImageContext = "AVCaptureStillImageIsCapturingStillImageContext";
const CGFloat FACE_RECT_BORDER_WIDTH = 3;

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;}

@interface StacheCamViewController() {
	UIView *flashView;
	CGFloat beginGestureScale;
}
@property (strong, nonatomic) AVCaptureSession* session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (assign, nonatomic) CGFloat effectiveScale;
@end

@implementation StacheCamViewController

- (void)setupAVCapture
{
	self.session = [AVCaptureSession new];
	[self.session setSessionPreset:AVCaptureSessionPresetPhoto]; // high-res stills, screen-size video
	
	[self updateCameraSelection];
	
	// For displaying live feed to screen
	CALayer *rootLayer = self.previewView.layer;
	[rootLayer setMasksToBounds:YES];
	self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
	[self.previewLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
	[self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
	[self.previewLayer setFrame:[rootLayer bounds]];
	[rootLayer addSublayer:self.previewLayer];
	
	// For saving still images and loads graphics for AVF-based overlays
	[self setupGraphics];
	
	// For receiving AV Foundation face detection
	[self setupAVFoundationFaceDetection];

	// For comparing to the CoreImage face detection
	[self setupCoreImageFaceDetection];
	
	// this will allow us to sync freezing the preview when the image is being captured
	[self.stillImageOutput addObserver:self forKeyPath:@"capturingStillImage" options:NSKeyValueObservingOptionNew context:AVCaptureStillImageIsCapturingStillImageContext];

	[self.session startRunning];
}
					
- (void)teardownAVCapture
{
	[self.session stopRunning];
	
	[self.stillImageOutput removeObserver:self forKeyPath:@"capturingStillImage"];
	
	[self teardownCoreImageFaceDetection];
	[self teardownAVFoundationFaceDetection];
	[self teardownGraphics];
	
	[self.previewLayer removeFromSuperlayer];
	self.previewLayer = nil;
	
	self.session = nil;
}

- (AVCaptureDeviceInput*) pickCamera
{
	AVCaptureDevicePosition desiredPosition = (UserDefaults.usingFrontCamera) ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack;
	BOOL hadError = NO;
	for (AVCaptureDevice *d in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
		if ([d position] == desiredPosition) {
			NSError *error = nil;
			AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:d error:&error];
			if (error) {
				hadError = YES;
				displayErrorOnMainQueue(error, @"Could not initialize for AVMediaTypeVideo");
			} else if ( [self.session canAddInput:input] ) {
				return input;
			}
		}
	}
	if ( ! hadError ) {
		// no errors, simply couldn't find a matching camera
		displayErrorOnMainQueue(nil, @"No camera found for requested orientation");
	}
	return nil;
}

- (void) updateCameraSelection
{
	// Changing the camera device will reset connection state, so we call the
	// update*Detection functions to resync them.  When making multiple
	// session changes, wrap in a beginConfiguration / commitConfiguration.
	// This will avoid consecutive session restarts for each configuration
	// change (noticeable delay and camera flickering)
	
	[self.session beginConfiguration];
	
	// have to remove old inputs before we test if we can add a new input
	NSArray* oldInputs = [self.session inputs];
	for (AVCaptureInput *oldInput in oldInputs)
		[self.session removeInput:oldInput];
	
	AVCaptureDeviceInput* input = [self pickCamera];
	if ( ! input ) {
		// failed, restore old inputs
		for (AVCaptureInput *oldInput in oldInputs)
			[self.session addInput:oldInput];
	} else {
		// succeeded, set input and update connection states
		[self.session addInput:input];
		[self updateAVFoundationDetection:nil];
		[self updateCoreImageDetection:nil];
	}
	[self.session commitConfiguration];
}

// this will freeze the preview when a still image is captured, we will unfreeze it when the graphics code is finished processing the image
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ( context == AVCaptureStillImageIsCapturingStillImageContext ) {
		BOOL isCapturingStillImage = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
		
		if ( isCapturingStillImage ) {
			[self.previewView.superview addSubview:flashView];
			[UIView animateWithDuration:.4f
				animations:^{ flashView.alpha=0.65f; }
			 ];
			self.previewLayer.connection.enabled = NO;
		}
	}
}

// Graphics code will call this when still image capture processing is complete
- (void) unfreezePreview
{
	self.previewLayer.connection.enabled = YES;
	[UIView animateWithDuration:.4f
					 animations:^{ flashView.alpha=0; }
					 completion:^(BOOL finished){ [flashView removeFromSuperview]; }
	 ];
}


#pragma mark - Interface Builder actions

- (IBAction)switchCameras:(id)sender
{
	UserDefaults.usingFrontCamera = !UserDefaults.usingFrontCamera;
	[self updateCameraSelection];
}

- (IBAction)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer
{
	BOOL allTouchesAreOnThePreviewLayer = YES;
	NSUInteger numTouches = [recognizer numberOfTouches], i;
	for ( i = 0; i < numTouches; ++i ) {
		CGPoint location = [recognizer locationOfTouch:i inView:self.previewView];
		CGPoint convertedLocation = [self.previewLayer convertPoint:location fromLayer:self.previewLayer.superlayer];
		if ( ! [self.previewLayer containsPoint:convertedLocation] ) {
			allTouchesAreOnThePreviewLayer = NO;
			break;
		}
	}
	
	if ( allTouchesAreOnThePreviewLayer ) {
		self.effectiveScale = beginGestureScale * recognizer.scale;
		if (self.effectiveScale < 1.0)
			self.effectiveScale = 1.0;
		if ( self.stillImageOutput ) {
			CGFloat maxScaleAndCropFactor = [[self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo] videoMaxScaleAndCropFactor];
			if (self.effectiveScale > maxScaleAndCropFactor)
				self.effectiveScale = maxScaleAndCropFactor;
		}
		[CATransaction begin];
		[CATransaction setAnimationDuration:.025];
		[self.previewLayer setAffineTransform:CGAffineTransformMakeScale(self.effectiveScale, self.effectiveScale)];
		[CATransaction commit];
	}
}

- (IBAction)updateUsingAnimations:(UISwitch *)sender {
	UserDefaults.usingAnimation = self.animationSwitch.on;
}

- (IBAction)toggleFacePicker:(UISwitch*)sender {
	self.facePicker.hidden = !self.facePicker.hidden;
}

#pragma mark - View lifecycle

- (IBAction)sliderChange:(id)sender {
    int sliderValue = (int)lroundf(self.fpsSlider.value);
    [self.fpsSlider setValue:sliderValue animated:YES];
    self.fpsLabel.text = [NSString stringWithFormat:@"Every %d Frames", sliderValue];
}

-(IBAction)buttonTouchDown:(id)sender
{
     NSLog(@"Button touch down");
    self.isButtonDown = true;
    self.fpsSliderValue = (int)lroundf(self.fpsSlider.value);
}

-(IBAction)buttonTouchUp:(id)sender
{
    NSLog(@"Button touch up");
    self.isButtonDown = false;
    NSURL* exportUrl = exportAnimatedGif(self.bunchOfURL);
    self.transURL = exportUrl;
}


- (void)dealloc
{
	[self teardownAVCapture];
	flashView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.effectiveScale = 1.0;
	
	self.facePicker.layer.borderWidth=1;
	self.facePicker.layer.cornerRadius=10;
	
	self.fpsView.layer.borderWidth=1;
	self.fpsView.layer.cornerRadius=10;
	
	flashView = [[UIView alloc] initWithFrame:self.previewView.frame];
	flashView.backgroundColor = [UIColor whiteColor];
	flashView.alpha = 0;
	
	self.mustacheSwitch.on = UserDefaults.displayAVFMustaches;
	self.avfRectSwitch.on = UserDefaults.displayAVFRects;
	self.ciRectSwitch.on = UserDefaults.displayCIRects;
	self.animationSwitch.on = UserDefaults.usingAnimation;
    self.bunchOfURL = [NSMutableArray array];
    

	[self setupAVCapture];
}

- (void)viewDidUnload
{
	[self teardownAVCapture];
	[self teardownGraphics];
	flashView = nil;
	self.previewView=nil;
	self.facePicker=nil;
	self.fpsView=nil;
	self.avfFPSLabel=nil;
	self.ciFPSLabel=nil;
	self.mustacheSwitch=nil;
	self.animationSwitch=nil;
	self.avfRectSwitch=nil;
	self.ciRectSwitch=nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
		beginGestureScale = self.effectiveScale;
	}
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog( @"transitioning from %@ to %@ with %@", segue.sourceViewController, segue.destinationViewController, self.transURL );
    
    ViewController *destinationViewController = segue.destinationViewController;
    destinationViewController.image = [UIImage animatedImageWithAnimatedGIFURL:self.transURL];
}

@end

void displayErrorOnMainQueue(NSError *error, NSString *message)
{
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		UIAlertView* alert = [UIAlertView new];
		if(error) {
			alert.title = [NSString stringWithFormat:@"%@ (%zd)", message, error.code];
			alert.message = [error localizedDescription];
		} else {
			alert.title = message;
		}
		[alert addButtonWithTitle:@"Dismiss"];
		[alert show];
	});
}

