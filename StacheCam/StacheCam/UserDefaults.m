
/*
 <codex/>
 */

#ifndef __CODEX__
/*
 $Log$
 12jun2012 etirathompson
 Updates for AVCaptureMetadataOutput-based face detection
 */ 
#endif

#import "UserDefaults.h"

static NSString* USING_FRONT_CAMERA_DEFAULTS_KEY = @"usingFrontCamera";
static NSString* DISPLAY_AVF_MUSTACHES_DEFAULTS_KEY = @"displayAVFMustaches";
static NSString* DISPLAY_AVF_RECTS_DEFAULTS_KEY = @"displayAVFRects";
static NSString* DISPLAY_CI_RECTS_DEFAULTS_KEY = @"displayCIRects";
static NSString* USING_ANIMATION_DEFAULTS_KEY = @"usingAnimation";

@implementation UserDefaults

+ (void) initialize {
	[[NSUserDefaults standardUserDefaults] registerDefaults: @{
		USING_FRONT_CAMERA_DEFAULTS_KEY : [NSNumber numberWithBool:YES],
		DISPLAY_AVF_MUSTACHES_DEFAULTS_KEY : [NSNumber numberWithBool:YES],
		DISPLAY_AVF_RECTS_DEFAULTS_KEY : [NSNumber numberWithBool:NO],
		DISPLAY_CI_RECTS_DEFAULTS_KEY : [NSNumber numberWithBool:NO],
		USING_ANIMATION_DEFAULTS_KEY : [NSNumber numberWithBool:NO],
	 }];
}

+ (BOOL) usingFrontCamera { return [[NSUserDefaults standardUserDefaults] boolForKey:USING_FRONT_CAMERA_DEFAULTS_KEY]; }
+ (void) setUsingFrontCamera:(BOOL)x { [[NSUserDefaults standardUserDefaults] setBool:x forKey:USING_FRONT_CAMERA_DEFAULTS_KEY]; }

+ (BOOL) displayAVFMustaches { return [[NSUserDefaults standardUserDefaults] boolForKey:DISPLAY_AVF_MUSTACHES_DEFAULTS_KEY]; }
+ (void) setDisplayAVFMustaches:(BOOL)x { [[NSUserDefaults standardUserDefaults] setBool:x forKey:DISPLAY_AVF_MUSTACHES_DEFAULTS_KEY]; }

+ (BOOL) displayAVFRects { return [[NSUserDefaults standardUserDefaults] boolForKey:DISPLAY_AVF_RECTS_DEFAULTS_KEY]; }
+ (void) setDisplayAVFRects:(BOOL)x { [[NSUserDefaults standardUserDefaults] setBool:x forKey:DISPLAY_AVF_RECTS_DEFAULTS_KEY]; }

+ (BOOL) displayCIRects { return [[NSUserDefaults standardUserDefaults] boolForKey:DISPLAY_CI_RECTS_DEFAULTS_KEY]; }
+ (void) setDisplayCIRects:(BOOL)x { [[NSUserDefaults standardUserDefaults] setBool:x forKey:DISPLAY_CI_RECTS_DEFAULTS_KEY]; }

+ (BOOL) usingAnimation { return [[NSUserDefaults standardUserDefaults] boolForKey:USING_ANIMATION_DEFAULTS_KEY]; }
+ (void) setUsingAnimation:(BOOL)x { [[NSUserDefaults standardUserDefaults] setBool:x forKey:USING_ANIMATION_DEFAULTS_KEY]; }

@end