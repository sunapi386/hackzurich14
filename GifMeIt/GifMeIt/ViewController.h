#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// @property (strong, nonatomic) IBOutlet UIImageView *dataImageView;
@property (strong, nonatomic) IBOutlet UIImageView *urlImageView;
// @property (strong, nonatomic) IBOutlet UIImageView *variableDurationImageView;
@property (strong, nonatomic) IBOutlet UIButton *clicky;

- (IBAction)makeGif:(id)sender;

@end