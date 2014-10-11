//
//  ViewController.m
//  fuuuuuuuck
//
//  Created by Ruoping Xu on 2014-10-11.
//  Copyright (c) 2014 Ruoping Xu. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+animatedGIF.h"
#import "ViewController.h"
#import "setupCaptureSession.h"
#import "makeAnimatedGif.h"


@interface ViewController ()

@end

@implementation ViewController

- (IBAction)gifbutton:(id)sender {
    NSURL* swirlyURL = makeAnimatedGif();
    //NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"kalgMrZXXHaxy" withExtension:@"gif"];
    self.mygif.image = [UIImage animatedImageWithAnimatedGIFURL:swirlyURL];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   /* NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"kalgMrZXXHaxy" withExtension:@"gif"];
    self.mygif.image = [UIImage animatedImageWithAnimatedGIFURL:url1];
    */
        // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
