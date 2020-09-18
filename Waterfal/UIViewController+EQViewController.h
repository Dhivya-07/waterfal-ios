//
//  UIViewController+EQViewController.h
//  Waterfal
//
//  Created by MAC on 15/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#ifndef UIViewController_EQViewController_h
#define UIViewController_EQViewController_h
#import <UIKit/UIKit.h>

@interface UIViewController(EQViewController)
-(void)logOut:(BOOL)show;
- (void)showLoading:(BOOL)shouldShow;
+ (UIColor *)colorFromHexString:(NSString *)hexString;

@end

#endif /* UIViewController_EQViewController_h */
