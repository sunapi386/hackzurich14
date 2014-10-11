
/*
 <codex>
 <abstract>View controller for camera, preview, and face detection</abstract>
 </codex>
 */

#ifndef __CODEX__
/*
 $Log$
 12jun2012 etirathompson
 Updates for AVCaptureMetadataOutput-based face detection
 
 6jun2011 bford
 ___CODEX__ -> __CODEX__.  Be careful whom you copy/paste from.
 
 6jun2011 bford
 first time.
 */ 
#endif

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class CIDetector;

extern const CGFloat FACE_RECT_BORDER_WIDTH;
CGFloat DegreesToRadians(CGFloat degrees);
void displayErrorOnMainQueue(NSError *error, NSString *message);

@interface StacheCamViewController : UIViewController <UIGestureRecognizerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@property (strong, nonatomic, readonly) AVCaptureSession* session;
@property (strong, nonatomic, readonly) AVCaptureVideoPreviewLayer* previewLayer;
@property (assign, nonatomic, readonly) CGFloat effectiveScale; // pinch-to-zoom maintained by controller

@property (strong, nonatomic) NSArray* funnyFaces; // assigned by Graphics for use in AVFFaceDetection (array of dictionary of per-yaw UIImage)
@property (strong, nonatomic) NSArray* lastMetadata; // assigned by AVFFaceDetection for use in Graphics still image capture (array of AVMetadataFaceObject)
@property (strong, nonatomic) NSArray* facesForMetadata; // assigned by AVFFaceDetection for use in Graphics still image capture (array of CGImage corresponding to entries in lastMetadata)

@property (weak, nonatomic) IBOutlet UIView* previewView;
@property (weak, nonatomic) IBOutlet UIView* facePicker;
@property (weak, nonatomic) IBOutlet UIView* fpsView;
@property (weak, nonatomic) IBOutlet UILabel* avfFPSLabel;
@property (weak, nonatomic) IBOutlet UILabel* ciFPSLabel;

@property (weak, nonatomic) IBOutlet UISwitch* mustacheSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* avfRectSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* ciRectSwitch;
@property (weak, nonatomic) IBOutlet UISwitch* animationSwitch;

// Graphics code will call this when still image capture processing is complete
- (void) unfreezePreview;

- (IBAction)switchCameras:(id)sender;
- (IBAction)handlePinchGesture:(UIGestureRecognizer *)sender;
- (IBAction)updateUsingAnimations:(UISwitch *)sender;
- (IBAction)toggleFacePicker:(UISwitch*)sender;

@end
