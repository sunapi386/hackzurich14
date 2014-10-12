//
//  ViewController.m
//  GifMeIt
//
//  Created by Jade Deng on 2014-10-11.
//  Copyright (c) 2014 Jade Deng. All rights reserved.
//

#import "ViewController.h"
#import "makeAnimatedGif.h"
#import "UIImage+animatedGIF.h"
#import "exportAnimatedGif.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (IBAction)makeGif:(id)sender {
    NSURL *url1 = makeAnimatedGif();
    self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url1];
}


- (IBAction)exportGif:(id)sender {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"IMG_0580.JPG"];
    [array addObject:@"IMG_0581.JPG"];
    [array addObject:@"IMG_0582.JPG"];
    [array addObject:@"IMG_0583.JPG"];
    [array addObject:@"IMG_0584.JPG"];
    [array addObject:@"IMG_0585.JPG"];
    [array addObject:@"IMG_0586.JPG"];
    [array addObject:@"IMG_0587.JPG"];
    [array addObject:@"IMG_0588.JPG"];
    [array addObject:@"IMG_0589.JPG"];
    NSURL *exurl = exportAnimatedGif(array);
    self.urlImageView.image = [UIImage animatedImageWithAnimatedGIFURL:exurl];
}

//- (IBAction)uploadImage {
//    
//    [self uploadFiles];
//    
//}
//
//
//- (void)uploadFiles {
//    
//    AppDelegate *delegate = (AppDelegate*)[[[UIApplication sharedApplication]delegate]];
//    
//    NSString *str = [NSString stringWithFormat:@"oauth_token = %@ \n oauth_verifier = %@", delegate.OAuthKeyValue, delegate.OAuthSecretValue];
//    
//    NSLog(@"%@",str);
//    
//    NSData *data1 = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IMG_0581" ofType:@"JPG"]];
//    
//    NSArray *array = [NSArray arrayWithObjects:data1, nil];
//    
//    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        TumblrUploadr *tu = [[TumblrUploadr alloc] initWithNSDataForPhotos:array andBlogName:@"<YOUR BLOG NAME>.tumblr.com" andDelegate:self andCaption:@"Great Photos!"];
//        
//        dispatch_async( dispatch_get_main_queue(), ^{
//            
//            [tu signAndSendWithTokenKey:delegate.OAuthKeyValue andSecret:delegate.OAuthSecretValue];
//            
//        });
//    });
//}
//
//- (void) tumblrUploadr:(TumblrUploadr *)tu didFailWithError:(NSError *)error {
//    
//    NSLog(@"connection failed with error %@",[error localizedDescription]);
//    
//    [tu release];
//    
//}
//
//- (void) tumblrUploadrDidSucceed:(TumblrUploadr *)tu withResponse:(NSString *)response {
//    
//    NSLog(@"connection succeeded with response: %@", response);
//    
//    [tu release];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
