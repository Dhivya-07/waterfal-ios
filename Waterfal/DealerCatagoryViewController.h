//
//  DealerCatagoryViewController.h
//  Waterfal
//
//  Created by MAC on 18/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DealerCatagoryViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, assign) NSString *cid;
@property (nonatomic, assign) NSString *cname;
@property (nonatomic, assign) NSString *searchType;
@property (nonatomic, assign) NSString *userType;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)back:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UILabel *cnameLabel;

@end

NS_ASSUME_NONNULL_END
