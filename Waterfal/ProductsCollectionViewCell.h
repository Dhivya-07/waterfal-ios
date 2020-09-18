//
//  ProductsCollectionViewCell.h
//  Waterfal
//
//  Created by MAC on 10/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerHomeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *productsButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *pincodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *callImageView;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;

-(IBAction)ProductButtonAction:(id)sender;

@end


NS_ASSUME_NONNULL_END
