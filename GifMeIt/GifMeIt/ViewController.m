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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
