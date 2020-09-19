

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderInformationViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate>

@property (nonatomic, assign) NSString *order_id;


@property (strong, nonatomic) IBOutlet UILabel *orderUidLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
@property (strong, nonatomic) IBOutlet UILabel *payTypelabel;


@property (strong, nonatomic) IBOutlet UILabel *grossTotalLabel;


@property (strong, nonatomic) IBOutlet UILabel *discountLabel;
@property (strong, nonatomic) IBOutlet UILabel *taxesLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UILabel *grantTotalLabel;




- (IBAction)back:(UIBarButtonItem *)sender;


- (IBAction)procedToPayBtn:(id)sender;






@end

NS_ASSUME_NONNULL_END
