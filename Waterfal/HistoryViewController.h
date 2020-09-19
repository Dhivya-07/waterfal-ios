

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@property (strong, nonatomic) IBOutlet UIView *viewSideBack;

@property (strong, nonatomic) IBOutlet UIView *viewSideMenu;

- (IBAction)nav:(UIBarButtonItem *)sender;

- (IBAction)closeNav:(id)sender;

- (IBAction)cart:(UIBarButtonItem *)sender;

-(IBAction)DashboardButtonAction:(id)sender;
-(IBAction)ProductsButtonAction:(id)sender;

-(IBAction)OrderHistoryButtonAction:(id)sender;
-(IBAction)FavouritesButtonAction:(id)sender;
-(IBAction)StatementButtonAction:(id)sender;
-(IBAction)LogoutButtonAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
