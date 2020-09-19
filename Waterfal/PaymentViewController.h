

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaymentViewController : UIViewController

@property (nonatomic, assign) NSString *order_id;

- (IBAction)back:(UIBarButtonItem *)sender;

- (IBAction)payBtn:(id)sender;

@end

NS_ASSUME_NONNULL_END
