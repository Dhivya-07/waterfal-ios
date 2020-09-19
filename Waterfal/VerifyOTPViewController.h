

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VerifyOTPViewController : UIViewController



@property (nonatomic, assign) NSString *OTP;
@property (nonatomic, assign) NSString *mobile;


@property (strong, nonatomic) IBOutlet UITextField *textView1;
@property (strong, nonatomic) IBOutlet UITextField *textView2;
@property (strong, nonatomic) IBOutlet UITextField *textView3;
@property (strong, nonatomic) IBOutlet UITextField *textView4;

- (IBAction)verifyBtn:(id)sender;
- (IBAction)back:(id)sender;

@end

NS_ASSUME_NONNULL_END
