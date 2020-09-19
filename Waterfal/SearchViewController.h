

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;


@property (strong, nonatomic) IBOutlet UITextField *searchTxt;




- (IBAction)back:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UILabel *searchNotify;



@end

NS_ASSUME_NONNULL_END
