//
//  CustumerProductsViewController.m
//  Waterfal
//
//  Created by MAC on 11/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import "CustumerProductsViewController.h"
#import "SearchViewController.h"
#import "CartViewController.h"
#import "CustumerListViewController.h"
#import "Mycart2ViewController.h"
#import "CustumerSearchViewController.h"
#import "AppDelegate.h"
#import "UIViewController+EQViewController.h"
#import "CatogoryAndSeriesViewController.h"
@interface CustumerProductsViewController (){
NSString * Code_id;
    NSString * user_id;
    NSString * p_id;


}

@property (nonatomic, strong) NSArray *IDArray;
@property (nonatomic, strong) NSArray *NameArray;
@property (nonatomic, strong) NSArray *DescArray;

@property (nonatomic, strong) NSArray *IDSeriesArray;
@property (nonatomic, strong) NSArray *NameSeriesArray;
@property (nonatomic, strong) NSArray *DescSeriesArray;
@end

@implementation CustumerProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    user_id = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];

   
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.productView.bounds];
       self.productView.layer.masksToBounds = NO;
       self.productView.layer.shadowColor = [UIColor blackColor].CGColor;
       self.productView.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
       self.productView.layer.shadowOpacity = 0.3f;
       self.productView.layer.shadowPath = shadowPath.CGPath;
       
       
       
       UIBezierPath *shadowPath2 = [UIBezierPath bezierPathWithRect:self.seriesView.bounds];
          self.seriesView.layer.masksToBounds = NO;
          self.seriesView.layer.shadowColor = [UIColor blackColor].CGColor;
          self.seriesView.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
          self.seriesView.layer.shadowOpacity = 0.3f;
          self.seriesView.layer.shadowPath = shadowPath2.CGPath;
       
       
       
       
       
       _searchTxtView.layer.borderColor = [UIColor whiteColor].CGColor;
       _searchTxtView.layer.borderWidth = 2.0;
       _searchTxtView.layer.cornerRadius = 6.0;
       

       
       UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
       _searchTxtView.leftView = paddingView;
       _searchTxtView.leftViewMode = UITextFieldViewModeAlways;
       

       
       [self.searchTxtView setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"Search products by name, type" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}]];
       
       
       
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
         [self.view addGestureRecognizer:tap];
       
       
       }
-(void)dismissKeyboard { [self.view endEditing:YES]; }

-(IBAction)backButtonAction:(id)sender{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)nav:(UIBarButtonItem *)sender {
    
            _viewSideBack.hidden = NO;
            _viewSideMenu.hidden = NO;
           
           
           CATransition *transition = [CATransition animation];
             transition.duration = 0.5;
             transition.type = kCATransitionPush;
             transition.subtype = kCATransitionFromLeft;
             [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
             [_viewSideMenu.layer addAnimation:transition forKey:nil];
        

    }

-(void)salert:(NSString *)title second:(NSString *)message{
    
        dispatch_async(dispatch_get_main_queue(), ^{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
            
    });
    
}


- (IBAction)cart:(UIBarButtonItem *)sender {
    
    
    Mycart2ViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"Mycart2ViewController"];
    go.dealer_id = user_id;
    [self presentViewController:go animated:true completion:nil];
    
}

- (IBAction)searchHiddenBtn:(id)sender {
    
    CustumerSearchViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CustumerSearchViewController"];
    [self presentViewController:go animated:true completion:nil];
    
    
}

- (IBAction)proTypeBtn:(UIBarButtonItem *)sender {
    
    CatogoryAndSeriesViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CatogoryAndSeriesViewController"];
    go.cid = @"1";
          go.searchType = @"categories";
          go.userType = @"customer";
        [self presentViewController:go animated:true completion:nil];

//    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Action Sheet" message:@"Using the alert controller" preferredStyle:UIAlertControllerStyleActionSheet];
//
//      [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//
//          // Cancel button tappped.
//          [self dismissViewControllerAnimated:YES completion:^{
//          }];
//      }]];
//
//
//    for(int i=0;i<[_NameArray count];i++)
//
//      {
//
////    [actionSheet addAction:[UIAlertAction actionWithTitle:[_NameArray objectAtIndex:i] style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//
//          CustumerListViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CustumerListViewController"];
//            go.cid = self->_IDArray[i];
//        go.searchType = @"categories";
//        go.userType = @"customer";
//
//            go.cname = @"Product type";
//            [self presentViewController:go animated:true completion:nil];
//
//             }]];
//
//
//      }


      // Present action sheet.
      //[self presentViewController:actionSheet animated:YES completion:nil];
//    CustumerListViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CustumerListViewController"];
//    go.cid = @"1";
//    go.cname = @"Product type";
//       [self presentViewController:go animated:true completion:nil];
    
}


- (IBAction)seriesTypeBtn:(UIBarButtonItem *)sender {
    CatogoryAndSeriesViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CatogoryAndSeriesViewController"];
    go.cid = @"2";
             go.searchType = @"categories";
             go.userType = @"customer";
           [self presentViewController:go animated:true completion:nil];
    
    
    
//    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Action Sheet" message:@"Using the alert controller" preferredStyle:UIAlertControllerStyleActionSheet];
//
//      [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//
//          
//          
//          // Cancel button tappped.
//          [self dismissViewControllerAnimated:YES completion:^{
//          }];
//      }]];
//
//    
//    for(int i=0;i<[_NameSeriesArray count];i++)
//
//      {
//
//    [actionSheet addAction:[UIAlertAction actionWithTitle:[_NameSeriesArray objectAtIndex:i] style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//         CustumerListViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CustumerListViewController"];
//        go.cid = self->_IDSeriesArray[i];
//        go.searchType = @"series";
//        go.userType = @"customer";
//            go.cname = @"Series type";
//           [self presentViewController:go animated:true completion:nil];
//     
//        // Distructive button tapped.
////                 [self dismissViewControllerAnimated:YES completion:^{
////                 }];
//             }]];
//
//          
//      //[actionSheet addButtonWithTitle:[_IDArray objectAtIndex:i]];
//
//      }
//
//
//      // Present action sheet.
//      [self presentViewController:actionSheet animated:YES completion:nil];
//    CustumerListViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CustumerListViewController"];
//    go.cid = @"2";
//    go.cname = @"Series type";
//    [self presentViewController:go animated:true completion:nil];
    
    
}

@end
