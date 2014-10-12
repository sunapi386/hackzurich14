//
//  ViewController.m
//  StacheCam
//
//  Created by Jade Deng on 2014-10-12.
//
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ImageView.image = self.image;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end