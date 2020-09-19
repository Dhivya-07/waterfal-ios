
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *productView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cardItemsButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideButton;

@property (strong, nonatomic) IBOutlet UIView *seriesView;

@property (strong, nonatomic) IBOutlet UITextField *searchTxtView;

@property (strong, nonatomic) IBOutlet UIView *viewSideBack;

@property (strong, nonatomic) IBOutlet UIView *viewSideMenu;
@property (nonatomic, assign) NSString *Code;

- (IBAction)nav:(UIBarButtonItem *)sender;

- (IBAction)searchHiddenBtn:(id)sender;

- (IBAction)cart:(UIBarButtonItem *)sender;

- (IBAction)closeNav:(id)sender;

- (IBAction)proTypeBtn:(id)sender;

- (IBAction)seriesTypeBtn:(id)sender;




-(IBAction)DashboardButtonAction:(id)sender;
-(IBAction)ProductsButtonAction:(id)sender;

-(IBAction)OrderHistoryButtonAction:(id)sender;
-(IBAction)FavouritesButtonAction:(id)sender;
-(IBAction)StatementButtonAction:(id)sender;
-(IBAction)LogoutButtonAction:(id)sender;









@end

NS_ASSUME_NONNULL_END
