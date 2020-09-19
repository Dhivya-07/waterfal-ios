


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Reg2ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, assign) NSString *company_name;
@property (nonatomic, assign) NSString *address;
@property (nonatomic, assign) NSString *area;
@property (nonatomic, assign) NSString *city;
@property (nonatomic, assign) NSString *state;
@property (nonatomic, assign) NSString *pincode;
@property (nonatomic, assign) NSString *landmark;
@property (nonatomic, assign) NSString *website;
@property (nonatomic, assign) NSString *statesID;
@property (weak, nonatomic) IBOutlet UIButton *flimButton;
@property (weak, nonatomic) IBOutlet UIButton *employeeButton;
@property (weak, nonatomic) IBOutlet UIButton *anualTurnButton;

@property (nonatomic, assign) NSString *ship_address;
@property (nonatomic, assign) NSString *ship_area;
@property (nonatomic, assign) NSString *ship_city;
@property (nonatomic, assign) NSString *ship_state;
@property (nonatomic, assign) NSString *ship_landMark;
@property (nonatomic, assign) NSString *ship_pincode;
@property (strong, nonatomic) IBOutlet UITextField *nameTextView;
@property (strong, nonatomic) IBOutlet UITextField *mobileTextView;

@property (weak, nonatomic) IBOutlet UITextField *emailIDTextField;

@property (strong, nonatomic) IBOutlet UITextField *firmTextView;
@property (strong, nonatomic) IBOutlet UITextField *gstinTextView;
@property (strong, nonatomic) IBOutlet UITextField *panTextView;
@property (strong, nonatomic) IBOutlet UITextField *yearTextView;
@property (strong, nonatomic) IBOutlet UITextField *shopMeterTextView;
@property (strong, nonatomic) IBOutlet UITextField *wareHouseTextView;
@property (strong, nonatomic) IBOutlet UITextField *employeesTextView;
@property (strong, nonatomic) IBOutlet UITextField *anualturnoverTextView;
@property (strong, nonatomic) IBOutlet UITextField *prominentBrandsTextView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIView *FlimpickerView;

@property (strong, nonatomic) IBOutlet UILabel *gstLabel;



- (IBAction)FilmsType:(id)sender;
-(IBAction)NoOfEmployeeButton:(id)sender;
-(IBAction)TurnOverAction:(id)sender;
- (IBAction)doneButton:(id)sender;
- (IBAction)nextBtn:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)gstUploadBtn:(id)sender;

- (IBAction)uploadBtn:(id)sender;






@end

NS_ASSUME_NONNULL_END
