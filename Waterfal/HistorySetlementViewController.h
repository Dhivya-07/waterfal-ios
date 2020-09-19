


#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistorySetlementViewController : UIViewController<WKNavigationDelegate>

@property (strong, nonatomic) IBOutlet UIView *wView;
@property (weak, nonatomic) IBOutlet UITextField *fromTextField;
@property (weak, nonatomic) IBOutlet UITextField *toTextField;
-(IBAction)getProducts:(id)sender;

- (IBAction)back:(id)sender;
-(IBAction)fromTextAction:(id)sender;
-(IBAction)TotextAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *DVIew;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerview;

-(IBAction)doneButtonAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
