
/*
 <codex>
 <abstract>Category for methods related to loading and displaying graphical overlays, and capturing still images to the assets library</abstract>
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

// Takes a JPEG stored in the NSData and associated metadata, writes it to the camera roll
void writeJPEGDataToCameraRoll(NSData* data, NSDictionary* metadata);

// Scaling factor to tune the size of the face graphics overlayed on the camera image
extern const CGFloat SCALE_FUNNY_FACE;

@interface StacheCamViewController()
@property (strong,nonatomic) AVCaptureStillImageOutput *stillImageOutput;
//@property (strong,nonatomic) AVCaptureVideoDataOutput *videoDataOutput;

@property (atomic) int framesPassed;
@end

// Methods for generic graphics operations such as loading the face overlay graphics
@interface StacheCamViewController (Graphics)

- (void) setupGraphics; // Loads face graphics

- (void) teardownGraphics; // Releases face graphics

- (IBAction)takePicture:(id)sender; // grabs a still image and applies the most recent metadata

@end
