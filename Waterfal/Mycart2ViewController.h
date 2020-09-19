


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Mycart2ViewController : UIViewController
@property (nonatomic, assign) NSString *dealer_id;
@property (strong, nonatomic) IBOutlet UILabel *grossTotalLabel;
@property (strong, nonatomic) IBOutlet UILabel *taxTotalLabel;
@property (strong, nonatomic) IBOutlet UILabel *grandTotalLabel;
@property (weak, nonatomic) IBOutlet UIView *cartEmptyView;
@property (weak, nonatomic) IBOutlet UIView *proceedView;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)back:(UIBarButtonItem *)sender;
- (IBAction)downloadAction:(id)sender;
-(IBAction)shareAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
