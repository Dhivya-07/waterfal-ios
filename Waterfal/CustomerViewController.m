//
//  CustomerViewController.m
//  Waterfal
//
//  Created by MAC on 11/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import "CustomerViewController.h"
#import "CustomerHomeViewController.h"
#import "ProductsViewController.h"
#import "CustumerProductsViewController.h"

@interface CustomerViewController ()

@end

@implementation CustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.locateDealerView.bounds];
    self.locateDealerView.layer.masksToBounds = NO;
    self.locateDealerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.locateDealerView.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    self.locateDealerView.layer.shadowOpacity = 0.3f;
    self.locateDealerView.layer.shadowPath = shadowPath.CGPath;
    
    
    
    UIBezierPath *shadowPath2 = [UIBezierPath bezierPathWithRect:self.searchProductVIew.bounds];
       self.searchProductVIew.layer.masksToBounds = NO;
       self.searchProductVIew.layer.shadowColor = [UIColor blackColor].CGColor;
       self.searchProductVIew.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
       self.searchProductVIew.layer.shadowOpacity = 0.3f;
       self.searchProductVIew.layer.shadowPath = shadowPath2.CGPath;
    
}

-(IBAction)backAction:(id)sender{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(IBAction)LocateDealerAction:(id)sender{
    CustomerHomeViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"customerHome"];
                 [self presentViewController:go animated:true completion:nil];
    
}
-(IBAction)searvhProductAction:(id)sender{
    CustumerProductsViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CustumerProductsViewController"];
    go.Code = @"1";
    [self presentViewController:go animated:true completion:nil];
       
}
@end
