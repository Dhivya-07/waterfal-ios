
#import "HistoryViewController.h"
#import "OrderInformationViewController.h"
#import "AppDelegate.h"
#import "CartViewController.h"
#import "UIViewController+EQViewController.h"
#import "ProductsViewController.h"
#import "HistoryViewController.h"
#import "HistorySetlementViewController.h"
#import "FavouritesViewController.h"
#import "DealerDashboardViewController.h"
#import "UIViewController+EQViewController.h"
@interface HistoryViewController () {
    
    NSString * user_id;
}



@property (nonatomic, strong) NSArray *IDArray;
@property (nonatomic, strong) NSArray *OrderIdArray;
@property (nonatomic, strong) NSArray *OrderValueArray;
@property (nonatomic, strong) NSArray *ModeOfPayArray;
@property (nonatomic, strong) NSArray *OrderStatusArray;



@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
      [self closeMenu];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
             [self.view addGestureRecognizer:tap];
           
           
           
           UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeleft:)];
           swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
           [_viewSideBack addGestureRecognizer:swipeLeft];

    
    user_id = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];
    
    
    [self getData];
    [self getReloadedData];
    
}




-(void)getData {
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
          dispatch_async(queue, ^{
          
    [self showLoading:true];

       
       NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, PURCHASEHISTORY];
       NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
       
       
      NSString *params =[NSString stringWithFormat:@"user_id=%@", self->user_id];
       
       [Request setHTTPMethod:@"POST"];
       NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
       [Request setHTTPBody:data];
       NSURLSession *session = [NSURLSession sharedSession];
       
       
       NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:Request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
       {
           [self showLoading:false];

           if(error) {
              // [self closePresentView];
              NSLog(@"dataTaskWithRequest error: %@", error);
              return;
           }
           
           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
           if(httpResponse.statusCode == 200)
           {
               
               //[self closePresentView];
               
               NSError *parseError = nil;
                   NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                   
                   NSLog(@"Details==>%@", responseDictionary);
                   
                   long status = [[responseDictionary objectForKey:@"status"] integerValue];
               
                      if(status == 1 ) {
                          
                          

    NSDictionary *data = [responseDictionary objectForKey:@"data"];
                            
    NSMutableArray *arrayID = [[NSMutableArray alloc] init];
    NSMutableArray *arrayName = [[NSMutableArray alloc] init];
      NSMutableArray *arrayOrderAmount = [[NSMutableArray alloc] init];
                          
                          
                          
         for (NSDictionary *dat in data){
             
              [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
             [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"product_name"]]];
             [arrayOrderAmount addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"order_amount"]]];
             
         }

        
        self.IDArray = arrayID;
       

          dispatch_async(dispatch_get_main_queue(), ^{
        
              
              [self.collectionView reloadData];
              
               
              
          });
        
                          
                          
                       
                   }else {
                       
                       NSString *msg = [responseDictionary objectForKey:@"message"];
                      [self salert:@"Alert" second:msg];
                      
                   }
               
               

           }else {
               
          // [self closePresentView];
               [self salert:@"Alert" second:@"Internal Server Error"];

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
-(void)getReloadedData
{
    
    [self showLoading:true];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{

           NSString *Url = [NSString stringWithFormat:@"%@%@?order_id=%@", BASEURL, REORDER, self->user_id];
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
                       

                       NSString *msg = [responseDictionary objectForKey:@"message"];
                        [self salert:@"Alert" second:msg];
    
                         dispatch_async(dispatch_get_main_queue(), ^{

                             //[self hidePageLoader];
                             //[self.collectionView reloadData];
                              
                             
                         });
                       
                       
                    
                }else {
                    
                    NSString *msg = [responseDictionary objectForKey:@"message"];
                    [self salert:@"Alert" second:msg];
                   
                }
            
            

        }else {
            
            
            NSLog(@"%@",@"ERROR");
            
        }
        
    
    }];
    
    [dataTask resume];
           
           
    });
    
  
    
}
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

- (IBAction)cart:(UIBarButtonItem *)sender {
    
    
    CartViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"cartView"];
       [self presentViewController:go animated:true completion:nil];
       
    
    
}

- (IBAction)closeNav:(id)sender {
       
       [self closeMenu];
       
   }

- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section{
    
    return self.IDArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
     UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, 1)];
       bottomBorder.backgroundColor = [UIColor redColor];


    
    
    UIButton *viewBtn = (UIButton *)[cell viewWithTag:10];
           viewBtn.tag = (int) indexPath.row;
           [viewBtn addTarget:self
                                     action:@selector(aMethod:)
                           forControlEvents:UIControlEventTouchDown];
    
    
    
    UIButton *viewBtn2 = (UIButton *)[cell viewWithTag:11];
              viewBtn2.tag = (int) indexPath.row;
              [viewBtn2 addTarget:self
                                        action:@selector(aMethod:)
                              forControlEvents:UIControlEventTouchDown];
    
    
    
    return cell;
    
    
}


-(void)aMethod:(UIButton*)sender{
    
  OrderInformationViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"orderinfView"];

  
      [self presentViewController:go animated:true completion:nil];


}


@end
