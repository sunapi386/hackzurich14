#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

static NSURL* exportAnimatedGif(NSArray* imagePaths) {
//    UIImage *shacho = [UIImage imageNamed:@"Exclamation_red_small.png"];
//    UIImage *bucho = [UIImage imageNamed:@"Fangoria_Skull_Small.png"];
    
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"animated.gif"];
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:@"animated.gif"];
    
    NSDictionary *frameProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:2] forKey:(NSString *)kCGImagePropertyGIFDelayTime]
                                                                forKey:(NSString *)kCGImagePropertyGIFDictionary];
    NSDictionary *gifProperties = [NSDictionary dictionaryWithObject:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount]
                                                              forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((__bridge CFURLRef)fileURL,
                                                                        kUTTypeGIF,
                                                                        2,
                                                                        NULL);
    CGImageDestinationSetProperties(destination, (CFDictionaryRef)gifProperties);

    for ( NSString *imagePath in imagePaths )
    {
//        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        UIImage *image = [UIImage imageNamed:imagePath];
        CGImageDestinationAddImage(destination, image.CGImage, (CFDictionaryRef)frameProperties);
    }
//    CGImageDestinationAddImage(destination, bucho.CGImage, (CFDictionaryRef)frameProperties);
    
    if (!CGImageDestinationFinalize(destination)) {
        NSLog(@"failed to finalize image destination");
    }
    
    CFRelease(destination);
    
    NSLog(@"animated GIF file created at %@", fileURL);
    return fileURL;
    
//    
//    NSArray *testArray = @[ @"1", @"2"];
//    NSMutableArray *array = [NSMutableArray array];
//    
//    [array addObject:@"1"];
//    [array addObject:@"2"];
}