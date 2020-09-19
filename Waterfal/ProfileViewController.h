


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController



@property (strong, nonatomic) IBOutlet UILabel *dealer_name;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *cityandstate;
@property (strong, nonatomic) IBOutlet UILabel *pincode;
@property (strong, nonatomic) IBOutlet UILabel *email;
@property (strong, nonatomic) IBOutlet UILabel *firm;
@property (strong, nonatomic) IBOutlet UILabel *gst;
@property (strong, nonatomic) IBOutlet UILabel *shoparea;
@property (strong, nonatomic) IBOutlet UILabel *shopcitystate;
@property (strong, nonatomic) IBOutlet UILabel *shoppincode;


@property (strong, nonatomic) IBOutlet UIView *viewSideBack;
@property (strong, nonatomic) IBOutlet UIView *viewSideMenu;
- (IBAction)nav:(UIBarButtonItem *)sender;
- (IBAction)closeNav:(id)sender;
-(IBAction)DashboardButtonAction:(id)sender;
-(IBAction)ProductsButtonAction:(id)sender;

-(IBAction)OrderHistoryButtonAction:(id)sender;
-(IBAction)FavouritesButtonAction:(id)sender;
-(IBAction)StatementButtonAction:(id)sender;
-(IBAction)LogoutButtonAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
