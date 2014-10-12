//
//  ViewController.h
//  GIFMeIt
//
//  Created by Jade Deng on 2014-10-11.
//  Copyright (c) 2014 Jade Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "TumblrUploadr.h"

@interface ViewController : UIViewController // <TumblrUploadrDelegate>

// @property (strong, nonatomic) IBOutlet UIImageView *dataImageView;
@property (strong, nonatomic) IBOutlet UIImageView *urlImageView;
// @property (strong, nonatomic) IBOutlet UIImageView *variableDurationImageView;
@property (strong, nonatomic) IBOutlet UIButton *clicky;
@property (strong, nonatomic) IBOutlet UIButton *exclicky;

//- (IBAction)uploadImage;
//
//- (void) uploadFiles;

- (IBAction)makeGif:(id)sender;

- (IBAction)exportGif:(id)sender;

@end