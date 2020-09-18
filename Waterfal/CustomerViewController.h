//
//  CustomerViewController.h
//  Waterfal
//
//  Created by MAC on 11/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *locateDealerView;
@property (weak, nonatomic) IBOutlet UIView *searchProductVIew;
-(IBAction)backAction:(id)sender;
-(IBAction)LocateDealerAction:(id)sender;
-(IBAction)searvhProductAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
