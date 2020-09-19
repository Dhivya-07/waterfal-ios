

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetaislViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate>


@property (strong, nonatomic) IBOutlet UILabel *titleTxt;
@property (strong, nonatomic) IBOutlet UILabel *nameTxt;
@property (strong, nonatomic) IBOutlet UILabel *descTxt;
@property (strong, nonatomic) IBOutlet UILabel *priceTxt;
@property (strong, nonatomic) IBOutlet UITextField *quantity;


@property (nonatomic, assign) NSString *pid;
@property (nonatomic, assign) NSString *searchType;

@property (nonatomic, assign) NSString *cat_type;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)back:(UIBarButtonItem *)sender;


@property (strong, nonatomic) IBOutlet UILabel *cat_typeLabel;


- (IBAction)addCart:(id)sender;


@end

NS_ASSUME_NONNULL_END
