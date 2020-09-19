

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderConformationViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate>

@property (nonatomic, assign) NSString *order_id;


@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutlet UITextView *detailsTxt;

@property (strong, nonatomic) IBOutlet UIButton *conformOrderOutlet;

@property (strong, nonatomic) IBOutlet UIButton *modifyOutlet;

@property (strong, nonatomic) IBOutlet UIButton *paynowOutlet;


- (IBAction)conformOrderBtn:(id)sender;

- (IBAction)modifyOrderBtn:(id)sender;

- (IBAction)payNowBtn:(id)sender;

- (IBAction)back:(UIBarButtonItem *)sender;


@property (strong, nonatomic) IBOutlet UILabel *grossTotalLabel;
@property (strong, nonatomic) IBOutlet UILabel *discountLabel;
@property (strong, nonatomic) IBOutlet UILabel *taxesLabel;
@property (strong, nonatomic) IBOutlet UILabel *grandTotalLabel;





@end

NS_ASSUME_NONNULL_END
