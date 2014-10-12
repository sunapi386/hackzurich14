
/*
 <codex/>
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

#import "StacheCamAppDelegate.h"

@implementation StacheCamAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	[[NSUserDefaults standardUserDefaults] registerDefaults: @{
	 @"frontCamera" : [NSNumber numberWithBool:YES],
	 @"avfMustache" : [NSNumber numberWithBool:YES],
	 @"avfRect" : [NSNumber numberWithBool:NO],
	 @"ciRect" : [NSNumber numberWithBool:NO],
	 @"animation" : [NSNumber numberWithBool:NO],
	 }];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
