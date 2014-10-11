#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// @property (strong, nonatomic) IBOutlet UIImageView *dataImageView;
@property (strong, nonatomic) IBOutlet UIImageView *urlImageView;
// @property (strong, nonatomic) IBOutlet UIImageView *variableDurationImageView;
@property (strong, nonatomic) IBOutlet UIButton *clicky;
@property (strong, nonatomic) IBOutlet UIButton *exclicky;

- (IBAction)makeGif:(id)sender;

- (IBAction)exportGif:(id)sender;

@end