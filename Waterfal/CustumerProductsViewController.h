//
//  CustumerProductsViewController.h
//  Waterfal
//
//  Created by MAC on 11/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustumerProductsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *productView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cardItemsButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideButton;

@property (strong, nonatomic) IBOutlet UIView *seriesView;

@property (strong, nonatomic) IBOutlet UITextField *searchTxtView;

@property (strong, nonatomic) IBOutlet UIView *viewSideBack;
@property (nonatomic, assign) NSString *pid;

@property (strong, nonatomic) IBOutlet UIView *viewSideMenu;
@property (nonatomic, assign) NSString *Code;

- (IBAction)nav:(UIBarButtonItem *)sender;

- (IBAction)searchHiddenBtn:(id)sender;

- (IBAction)cart:(UIBarButtonItem *)sender;

- (IBAction)proTypeBtn:(id)sender;
-(IBAction)backButtonAction:(id)sender;

- (IBAction)seriesTypeBtn:(id)sender;

@end

NS_ASSUME_NONNULL_END
