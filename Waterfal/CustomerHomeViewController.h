

#import <UIKit/UIKit.h>
#import "ProductsCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomerHomeViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *viewSideBack;

@property (strong, nonatomic) IBOutlet UIView *viewSideMenu;
@property (weak, nonatomic) IBOutlet UILabel *neareststalLabel;

- (IBAction)nav:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *productsButton;


-(IBAction)ProductsBuutonAction:(id)sender;
- (IBAction)closeNav:(id)sender;
- (IBAction)searchButtonAction:(id)sender;
-(IBAction)cartButtonAction:(id)sender;
-(IBAction)callbuttonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textfield;






@end

NS_ASSUME_NONNULL_END
