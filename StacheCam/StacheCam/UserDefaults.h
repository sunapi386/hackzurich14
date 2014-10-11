
/*
 <codex>
 <abstract>Utility class for managing persistent user settings</abstract>
 </codex>
 */

#ifndef __CODEX__
/*
 $Log$
 12jun2012 etirathompson
 Updates for AVCaptureMetadataOutput-based face detection
 */ 
#endif

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject

+ (BOOL) usingFrontCamera;
+ (void) setUsingFrontCamera:(BOOL)x;

+ (BOOL) displayAVFMustaches;
+ (void) setDisplayAVFMustaches:(BOOL)x;

+ (BOOL) displayAVFRects;
+ (void) setDisplayAVFRects:(BOOL)x;

+ (BOOL) displayCIRects;
+ (void) setDisplayCIRects:(BOOL)x;

+ (BOOL) usingAnimation;
+ (void) setUsingAnimation:(BOOL)x;

@end
