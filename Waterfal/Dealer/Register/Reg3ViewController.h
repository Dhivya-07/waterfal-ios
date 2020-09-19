
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Reg3ViewController : UIViewController





@property (nonatomic, assign) NSString *company_name;
@property (nonatomic, assign) NSString *address;
@property (nonatomic, assign) NSString *emailID;
@property (nonatomic, assign) NSString *area;
@property (nonatomic, assign) NSString *city;
@property (nonatomic, assign) NSString *state;
@property (nonatomic, assign) NSString *pincode;
@property (nonatomic, assign) NSString *landmark;
@property (nonatomic, assign) NSString *website;
@property (nonatomic, assign) NSString *statesID;

@property (nonatomic, assign) NSString *ship_address;
@property (nonatomic, assign) NSString *ship_area;
@property (nonatomic, assign) NSString *ship_city;
@property (nonatomic, assign) NSString *ship_state;
@property (nonatomic, assign) NSString *ship_landMark;
@property (nonatomic, assign) NSString *ship_pincode;


@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSString *mobile;
@property (nonatomic, assign) NSString *firm;
@property (nonatomic, assign) NSString *gst;
@property (nonatomic, assign) NSString *pan;
@property (nonatomic, assign) NSString *year;
@property (nonatomic, assign) NSString *shopMeter;
@property (nonatomic, assign) NSString *wareHouse;
@property (nonatomic, assign) NSString *employees;
@property (nonatomic, assign) NSString *anualturnover;
@property (nonatomic, assign) NSString *prominentBrand;


@property (nonatomic, assign) UIImage *gstImage;
@property (nonatomic, assign) UIImage *panImage;



- (IBAction)agree_switch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *agree_outlet;


- (IBAction)registerBtn:(id)sender;



- (IBAction)back:(id)sender;



@property (strong, nonatomic) IBOutlet UILabel *company_name_label;
@property (strong, nonatomic) IBOutlet UILabel *addressLine1Label;
@property (strong, nonatomic) IBOutlet UILabel *areaLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *mobileLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;






@end

NS_ASSUME_NONNULL_END
