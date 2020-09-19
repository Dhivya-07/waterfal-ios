

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Reg1ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *statesPickerView;
@property (weak, nonatomic) IBOutlet UIButton *statesDoneAction;
@property (weak, nonatomic) IBOutlet UIButton *sameAsTextButton;
@property (weak, nonatomic) IBOutlet UITextField *shippingPincodeTextField;

@property (weak, nonatomic) IBOutlet UIPickerView *statePicker;

@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UITextField *statesTextField;
@property (weak, nonatomic) IBOutlet UITableView *listViewTableView;
@property(strong , nonatomic) NSArray *data;
@property (weak, nonatomic) IBOutlet UIButton *buttonTitle;

@property (strong, nonatomic) IBOutlet UITextField *company_name;
@property (strong, nonatomic) IBOutlet UITextField *address_line1;
@property (strong, nonatomic) IBOutlet UITextField *area;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *state;
@property (strong, nonatomic) IBOutlet UITextField *pincode;
@property (strong, nonatomic) IBOutlet UITextField *landmark;
@property (strong, nonatomic) IBOutlet UITextField *website;


@property (weak, nonatomic) IBOutlet UITextField *shippingLandMarkTextField;
@property (weak, nonatomic) IBOutlet UITextField *shippingAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *shippingAreaTextField;
@property (weak, nonatomic) IBOutlet UITextField *shippingCityTextField;
@property (weak, nonatomic) IBOutlet UITextField *shippingStateTextField;




- (IBAction)sameAsAddressButton:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)statesDone:(id)sender;
- (IBAction)nextBtn:(id)sender;
- (IBAction)btnAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
