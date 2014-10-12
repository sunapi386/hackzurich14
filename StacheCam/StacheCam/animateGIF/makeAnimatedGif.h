#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

static UIImage *frameImage(CGSize size, CGFloat radians) {
    UIGraphicsBeginImageContextWithOptions(size, YES, 1); {
        [[UIColor whiteColor] setFill];
        UIRectFill(CGRectInfinite);
        CGContextRef gc = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(gc, size.width / 2, size.height / 2);
        CGContextRotateCTM(gc, radians);
        CGContextTranslateCTM(gc, size.width / 4, 0);
        [[UIColor redColor] setFill];
        CGFloat w = size.width / 10;
        CGContextFillEllipseInRect(gc, CGRectMake(-w / 2, -w / 2, w, w));
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

static NSURL* makeAnimatedGif(void) {
    static NSUInteger kFrameCount = 16;
    
    NSDictionary *fileProperties = @{
                                     (__bridge id)kCGImagePropertyGIFDictionary: @{
                                             (__bridge id)kCGImagePropertyGIFLoopCount: @0, // 0 means loop forever
                                             }
                                     };
    
    NSDictionary *frameProperties = @{
                                      (__bridge id)kCGImagePropertyGIFDictionary: @{
                                              (__bridge id)kCGImagePropertyGIFDelayTime: @0.02f, // a float (not double!) in seconds, rounded to centiseconds in the GIF data
                                              }
                                      };
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:@"animated.gif"];
    
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((__bridge CFURLRef)fileURL, kUTTypeGIF, kFrameCount, NULL);
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)fileProperties);
    
    for (NSUInteger i = 0; i < kFrameCount; i++) {
        @autoreleasepool {
            UIImage *image = frameImage(CGSizeMake(300, 300), M_PI * 2 * i / kFrameCount);
            CGImageDestinationAddImage(destination, image.CGImage, (__bridge CFDictionaryRef)frameProperties);
        }
    }
    
    if (!CGImageDestinationFinalize(destination)) {
        NSLog(@"failed to finalize image destination");
    }
    CFRelease(destination);
    
    NSLog(@"url=%@", fileURL);
    return fileURL;
}