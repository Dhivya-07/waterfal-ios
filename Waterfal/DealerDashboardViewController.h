
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DealerDashboardViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UIView *v1;
@property (strong, nonatomic) IBOutlet UIView *v2;
@property (strong, nonatomic) IBOutlet UIView *v3;
@property (strong, nonatomic) IBOutlet UIView *v4;
@property (strong, nonatomic) IBOutlet UIView *v5;


@property (strong, nonatomic) IBOutlet UIPickerView *pick1;
@property (strong, nonatomic) IBOutlet UIPickerView *pick2;
@property (strong, nonatomic) IBOutlet UIPickerView *pick3;
@property (strong, nonatomic) IBOutlet UIPickerView *pick4;


@property (strong, nonatomic) IBOutlet UIImageView *barChart;
@property (strong, nonatomic) IBOutlet UIImageView *pieChart;

@property (strong, nonatomic) IBOutlet UIImageView *overDueDounutChart;
@property (strong, nonatomic) IBOutlet UIImageView *dueTodayDounutChart;
@property (strong, nonatomic) IBOutlet UIImageView *notYetDueDounutChat;


@property (strong, nonatomic) IBOutlet UIImageView *primaryPersonDounutChart;

@property (strong, nonatomic) IBOutlet UIImageView *secondaryPersonDounutChart;




@property (strong, nonatomic) IBOutlet UIView *viewSideBack;

@property (strong, nonatomic) IBOutlet UIView *viewSideMenu;

- (IBAction)nav:(UIBarButtonItem *)sender;

- (IBAction)closeNav:(id)sender;

- (IBAction)cart:(UIBarButtonItem *)sender;

-(IBAction)LogoutAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *over_due_value;
@property (strong, nonatomic) IBOutlet UILabel *due_today_value;
@property (strong, nonatomic) IBOutlet UILabel *notyet_due_value;
@property (strong, nonatomic) IBOutlet UILabel *primary_person_value;
@property (strong, nonatomic) IBOutlet UILabel *secondary_person_value;

-(IBAction)DashboardButtonAction:(id)sender;
-(IBAction)ProductsButtonAction:(id)sender;

-(IBAction)OrderHistoryButtonAction:(id)sender;
-(IBAction)FavouritesButtonAction:(id)sender;
-(IBAction)StatementButtonAction:(id)sender;
-(IBAction)LogoutButtonAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
