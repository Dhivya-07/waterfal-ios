


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate>


@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@property (strong, nonatomic) IBOutlet UILabel *grossTotalLabel;
@property (strong, nonatomic) IBOutlet UILabel *taxTotalLabel;
@property (strong, nonatomic) IBOutlet UILabel *grandTotalLabel;

@property (strong, nonatomic) IBOutlet UILabel *taxPercentLabel;

@property (strong, nonatomic) IBOutlet UIView *cartEmptyView;

@property (strong, nonatomic) IBOutlet UIView *proceedView;


- (IBAction)back:(UIBarButtonItem *)sender;

- (IBAction)procedToPayBtn:(id)sender;







@end

NS_ASSUME_NONNULL_END
