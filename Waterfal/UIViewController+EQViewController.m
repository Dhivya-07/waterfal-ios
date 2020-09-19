//
//  UIViewController+EQViewController.m
//  Waterfal
//
//  Created by MAC on 15/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import "UIViewController+EQViewController.h"
#import "MainHomeViewController.h"
@implementation UIViewController(EQViewController)



- (void)logOut:(BOOL)show {
    if(show){
        
        
         UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                            message:@"Are you sure want to logout?"
                                                                     preferredStyle:UIAlertControllerStyleAlert];

                   UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {

        
                [[NSUserDefaults standardUserDefaults] setObject:@""
                             forKey:@"user_id"];
        
        
              
                       
                MainHomeViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"mainHome"];
                       
                [self presentViewController:go animated:true completion:nil];


                                                                   }];

                   UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
                   [alert addAction:cancel];
                   [alert addAction:defaultAction];

                   [self presentViewController:alert animated:YES completion:nil];

        
    } else{
        
    }
}


- (void)showLoading:(BOOL)shouldShow {
    
    if (shouldShow) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"Please wait"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
            UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        spinner.center = CGPointMake(30, 30);
        spinner.color = [UIColor blackColor];
        [spinner startAnimating];
        [alert.view addSubview:spinner];
        [self presentViewController:alert animated:NO completion:nil];
            
        });
        
        
    } else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([self.presentedViewController isKindOfClass:[UIAlertController class]]) {
            [self.presentedViewController dismissViewControllerAnimated:true completion:nil];
        }
        
        });
        
    }
    
}

// Assumes input like "#00FF00" (#RRGGBB).
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


@end

