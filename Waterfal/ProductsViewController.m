

#import "ProductsViewController.h"
#import "SearchViewController.h"
#import "CartViewController.h"
#import "ProductListsViewController.h"
#import "AppDelegate.h"
#import "UIViewController+EQViewController.h"
#import "ProfileViewController.h"
#import "HistoryViewController.h"
#import "HistorySetlementViewController.h"
#import "FavouritesViewController.h"
#import "DealerDashboardViewController.h"
#import "DealerCatagoryViewController.h"
@interface ProductsViewController (){
    NSString * Code_id;
}

@property (nonatomic, strong) NSArray *IDArray;
@property (nonatomic, strong) NSArray *NameArray;
@property (nonatomic, strong) NSArray *DescArray;

@property (nonatomic, strong) NSArray *IDSeriesArray;
@property (nonatomic, strong) NSArray *NameSeriesArray;
@property (nonatomic, strong) NSArray *DescSeriesArray;
@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self closeMenu];
    [self getSeriesList];
    [self getProductList];
    
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
    
    
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeleft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_viewSideBack addGestureRecognizer:swipeLeft];
    
    
    
    
    

}
-(void)getProductList
{
    
    [self showLoading:true];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
       
    
           NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, CATAGORYLIST];
    NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
    
    
         
    [Request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:Request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        [self showLoading:false];

        if(error) {
        
           NSLog(@"dataTaskWithRequest error: %@", error);
           return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
          
            
            NSError *parseError = nil;
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                
                NSLog(@"Dashboard==> %@", responseDictionary);
                
                long status = [[responseDictionary objectForKey:@"status"] integerValue];
            
                   if(status == 1 ) {
                       
                       
                       NSDictionary *data = [responseDictionary objectForKey:@"data"];
                       
                       NSMutableArray *arrayID = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayName = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayDesc = [[NSMutableArray alloc] init];
                      
                       
                        for (NSDictionary *dat in data){
                            
                            [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
                            
                            [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"name"]]];
                            
                            [arrayDesc addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"description"]]];
                        }
                       
                    
                       self.IDArray = arrayID;
                       self.NameArray = arrayName;
                       self.DescArray = arrayDesc;
                
                    dispatch_async(dispatch_get_main_queue(), ^{

                           //  [self hidePageLoader];
                            // [self.collectionView reloadData];
                              
                             
                         });
                       
                       
                    
                }else {
                    
                    NSString *msg = [responseDictionary objectForKey:@"message"];
                    [self salert:@"Error" second:msg];
                   
                }
            
            

        }else {
            
            
            NSLog(@"%@",@"ERROR");
            
        }
        
    
    }];
    
    [dataTask resume];
           
           
    });
    
  
    
}


-(void)getSeriesList
{
    
    [self showLoading:true];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
       
    
           NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, SERIESLIST];
    NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
    
    
         
    [Request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:Request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        [self showLoading:false];

        if(error) {
        
           NSLog(@"dataTaskWithRequest error: %@", error);
           return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
          
            
            NSError *parseError = nil;
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                
                NSLog(@"Dashboard==> %@", responseDictionary);
                
                long status = [[responseDictionary objectForKey:@"status"] integerValue];
            
                   if(status == 1 ) {
                       
                       
                       NSDictionary *data = [responseDictionary objectForKey:@"data"];
                       
                       NSMutableArray *arrayID = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayName = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayDesc = [[NSMutableArray alloc] init];
                      
                       
                        for (NSDictionary *dat in data){
                            
                            [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
                            
                            [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"name"]]];
                            
                            [arrayDesc addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"description"]]];
                        }
                       
                    
                       self.IDSeriesArray = arrayID;
                       self.NameSeriesArray = arrayName;
                       self.DescSeriesArray = arrayDesc;
                
                    dispatch_async(dispatch_get_main_queue(), ^{

                           //  [self hidePageLoader];
                            // [self.collectionView reloadData];
                              
                             
                         });
                       
                       
                    
                }else {
                    
                    NSString *msg = [responseDictionary objectForKey:@"message"];
                    [self salert:@"Error" second:msg];
                   
                }
            
            

        }else {
            
            
            NSLog(@"%@",@"ERROR");
            
        }
        
    
    }];
    
    [dataTask resume];
           
           
    });
    
  
    
}
-(void)salert:(NSString *)title second:(NSString *)message{
    
        dispatch_async(dispatch_get_main_queue(), ^{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
            
    });
    
}
- (void)handleSwipeleft:(UISwipeGestureRecognizer *)gesture
{
    _viewSideMenu.hidden = YES;
    _viewSideBack.hidden = YES;
    
}

-(void)closeMenu {
    
    _viewSideMenu.hidden = YES;
    _viewSideBack.hidden = YES;
    
}

-(void)dismissKeyboard {
    
    [self.view endEditing:YES];
    
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

- (IBAction)closeNav:(id)sender {
    
    [self closeMenu];
    
}

- (IBAction)cart:(UIBarButtonItem *)sender {
    
    
    CartViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"cartView"];
    [self presentViewController:go animated:true completion:nil];
    
}

- (IBAction)searchHiddenBtn:(id)sender {
    
    SearchViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"searchView"];
    [self presentViewController:go animated:true completion:nil];
    
    
}

- (IBAction)proTypeBtn:(UIBarButtonItem *)sender {
    
    
    DealerCatagoryViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"DealerCatagoryViewController"];
    go.cid = @"1";
    [self presentViewController:go animated:true completion:nil];
//    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Action Sheet" message:@"Using the alert controller" preferredStyle:UIAlertControllerStyleActionSheet];
//
//         [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//
//             // Cancel button tappped.
//             [self dismissViewControllerAnimated:YES completion:^{
//             }];
//         }]];
//
//
//       for(int i=0;i<[_NameArray count];i++)
//
//         {
//
//       [actionSheet addAction:[UIAlertAction actionWithTitle:[_NameArray objectAtIndex:i] style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//
//             ProductListsViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"productListView"];
//               go.cid = self->_IDArray[i];
//           go.searchType = @"categories";
//           go.userType = @"dealer";
//
//               go.cname = @"Product type";
//               [self presentViewController:go animated:true completion:nil];
//
//                }]];
//
//
//         }
//
//
//         // Present action sheet.
//         [self presentViewController:actionSheet animated:YES completion:nil];
}
    
//    ProductListsViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"productListView"];
//    go.cid = @"1";
//    go.cname = @"Product type";
//       [self presentViewController:go animated:true completion:nil];
//
//}


- (IBAction)seriesTypeBtn:(UIBarButtonItem *)sender {
    
    DealerCatagoryViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"DealerCatagoryViewController"];
    go.cid = @"2";
                      [self presentViewController:go animated:true completion:nil];
//
//     UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Action Sheet" message:@"Using the alert controller" preferredStyle:UIAlertControllerStyleActionSheet];
//
//          [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//
//
//
//              // Cancel button tappped.
//              [self dismissViewControllerAnimated:YES completion:^{
//              }];
//          }]];
//
//
//        for(int i=0;i<[_NameSeriesArray count];i++)
//
//          {
//
//        [actionSheet addAction:[UIAlertAction actionWithTitle:[_NameSeriesArray objectAtIndex:i] style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//             ProductListsViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"productListView"];
//            go.cid = self->_IDSeriesArray[i];
//            go.searchType = @"series";
//            go.userType = @"dealer";
//                go.cname = @"Series type";
//               [self presentViewController:go animated:true completion:nil];
//
//            // Distructive button tapped.
//    //                 [self dismissViewControllerAnimated:YES completion:^{
//    //                 }];
//                 }]];
//
//
//          //[actionSheet addButtonWithTitle:[_IDArray objectAtIndex:i]];
//
//          }
//
//
//          // Present action sheet.
//          [self presentViewController:actionSheet animated:YES completion:nil];
}
    
//    ProductListsViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"productListView"];
//    go.cid = @"2";
//    go.cname = @"Series type";
//    [self presentViewController:go animated:true completion:nil];
//
//
//}
-(IBAction)DashboardButtonAction:(id)sender{
    DealerDashboardViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"dealerDash"];

    
        [self presentViewController:go animated:true completion:nil];
}
-(IBAction)ProductsButtonAction:(id)sender{
     ProductsViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"productView"];

    
        [self presentViewController:go animated:true completion:nil];
    
}
-(IBAction)FavouritesButtonAction:(id)sender{
    FavouritesViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"favouritesView"];

       
           [self presentViewController:go animated:true completion:nil];
    
}
-(IBAction)OrderHistoryButtonAction:(id)sender{
    HistoryViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"historyView"];

          
    [self presentViewController:go animated:true completion:nil];
    
}
-(IBAction)StatementButtonAction:(id)sender{
    HistorySetlementViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"HistorySetlementViewController"];

            
      [self presentViewController:go animated:true completion:nil];
      
    
}
-(IBAction)LogoutButtonAction:(id)sender{
    [self logOut:true];
}
@end
