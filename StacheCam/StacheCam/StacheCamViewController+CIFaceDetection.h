
/*
 <codex>
 <abstract>Category for methods related to CoreImage-based face detection</abstract>
 </codex>
 */

#ifndef __CODEX__
/*
 $Log$
 12jun2012 etirathompson
 Updates for AVCaptureMetadataOutput-based face detection
 */ 
#endif

#import "StacheCamViewController.h"

// State needed for CoreImage based face processing, stats, and display
@interface StacheCamViewController()
//@property (strong,nonatomic) AVCaptureVideoDataOutput *videoDataOutput;
@property (strong,nonatomic) CIDetector *faceDetector;
@property (strong,nonatomic) NSDate* ciLastFrameTime;
@property (assign,nonatomic) float ciProcessingInterval;
@property (strong,nonatomic) NSMutableArray *ciFaceLayers;
@end

// Methods for controlling the CoreImage based face processing
@interface StacheCamViewController (CIFaceDetection) <AVCaptureVideoDataOutputSampleBufferDelegate>

- (void) setupCoreImageFaceDetection; // builds session pipeline

- (void) teardownCoreImageFaceDetection; // removes session pipeline

// enables or disables the videoDataOutput based on the state of the ciRectSwitch UI
- (IBAction) updateCoreImageDetection:(UISwitch *)sender;

@end
