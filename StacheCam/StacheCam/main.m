/*
 <codex>
 <abstract>Standard main file.</abstract>
 </codex>
 */

#ifndef __CODEX__
/*
 $Log$
 6jun2011 bford
 ___CODEX__ -> __CODEX__.  Be careful whom you copy/paste from.
 
 6jun2011 bford
 first time.
 */ 
#endif

#import <UIKit/UIKit.h>

#import "StacheCamAppDelegate.h"

int main(int argc, char *argv[])
{
	int retVal = 0;
	@autoreleasepool {
	    retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([StacheCamAppDelegate class]));
	}
	return retVal;
}
