

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductListsViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate>


@property (nonatomic, assign) NSString *cid;
@property (nonatomic, assign) NSString *cname;
@property (nonatomic, assign) NSString *searchType;
@property (nonatomic, assign) NSString *userType;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)back:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UILabel *cnameLabel;

@end

NS_ASSUME_NONNULL_END
