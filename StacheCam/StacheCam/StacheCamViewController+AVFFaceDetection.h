
/*
 <codex>
 <abstract>Category for methods related to AVFoundation-based face detection</abstract>
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

// State needed for AVFoundation metadata based face processing, stats, and display
@interface StacheCamViewController()
@property (strong,nonatomic) AVCaptureMetadataOutput *metadataOutput;
@property (strong,nonatomic) NSDate* avfLastFrameTime;
@property (assign,nonatomic) float avfProcessingInterval;
@property (strong,nonatomic) NSMutableDictionary* avfFaceLayers;
@property (strong,nonatomic) NSMutableDictionary* indexForFaceID;
@end

// Methods for controlling the AVFoundation metadata based face processing
@interface StacheCamViewController (AVFFaceDetection) <AVCaptureMetadataOutputObjectsDelegate>

- (void) setupAVFoundationFaceDetection; // builds session pipeline

- (void) teardownAVFoundationFaceDetection; // removes session pipeline

// enables or disables the metadataOutput based on the state of the avfRectSwitch or mustacheSwitch UI
- (IBAction)updateAVFoundationDetection:(UISwitch*)sender;

// switch the graphic being displayed for a tapped face
- (IBAction)handleTapGesture:(UITapGestureRecognizer *)sender;

@end
