//
//  ShareViewController.h
//  Waterfal
//
//  Created by MAC on 13/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareViewController : UIViewController
@property (nonatomic, assign) NSString *dealer_id;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
-(IBAction)backButtonAction:(id)sender;
-(IBAction)ShareButtonAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
