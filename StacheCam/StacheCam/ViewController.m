//
//  ViewController.m
//  StacheCam
//
//  Created by Jade Deng on 2014-10-12.
//
//

#import "ViewController.h"
#import "Social/Social.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ImageView.image = self.image;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)postFB:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *postController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [postController addImage:self.image];
        [postController setInitialText:@"Check out this GIFMeIt, from #hackZurich"];
        [self presentViewController:postController animated:YES completion:nil];
        NSLog(@"Post to Facebook");

    } else {
        // error otherwise, NSLog
        NSLog(@"Error posting");
    }


}

- (IBAction)postTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *postController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [postController addImage:self.image];
        [postController setInitialText:@"Check out this GIFMeIt, from #hackZurich"];
        [self presentViewController:postController animated:YES completion:nil];
        NSLog(@"Post to Twitter");
    } else {
        // error otherwise, NSLog
        NSLog(@"Error posting");
    }

}

@end