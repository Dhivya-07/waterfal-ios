

#import "FavouritesViewController.h"
#import "AppDelegate.h"
#import "CartViewController.h"
#import "ProductsViewController.h"
#import "HistoryViewController.h"
#import "HistorySetlementViewController.h"
#import "FavouritesViewController.h"
#import "DealerDashboardViewController.h"
#import "UIViewController+EQViewController.h"
@interface FavouritesViewController () {
    
    NSString * user_id;
}


@property (nonatomic, strong) NSArray *IDArray;

@end

@implementation FavouritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self closeMenu];
   

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
          [self.view addGestureRecognizer:tap];
        
        
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeleft:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [_viewSideBack addGestureRecognizer:swipeLeft];
    
    
    user_id = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];
    
    
    self.nodata.hidden = YES;
        

}

- (void)viewWillAppear:(BOOL)animated {
    
    
    
    [self getdata];
    //[self removeData];
    
    
    
}


-(void)removeData {
    
   
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
          dispatch_async(queue, ^{
          
              
       
       NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, REMOVEFAVOURITE];
       NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
       
       
              NSString *params =[NSString stringWithFormat:@"id=%@", @"1"];
       
       [Request setHTTPMethod:@"POST"];
       NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
       [Request setHTTPBody:data];
       NSURLSession *session = [NSURLSession sharedSession];
       
       
       NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:Request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
       {
           
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
                       
                       
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                               
                        
                            });
                          
                          
                       
                   }else {
                       
                       NSString *msg = [responseDictionary objectForKey:@"message"];
                      // [self salert:@"Alert" second:msg];
                       
                       
                       
                      
                   }
               
               

           }else {
               
          // [self closePresentView];
               
               NSLog(@"%@",@"ERROR");
               
           }
           
       
       }];
       
       [dataTask resume];
              
              
       });
       
       
    
}

-(void)getdata{
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
       
    
    NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, FAVOURITELIST];
    NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
    
    
        NSString *params =[NSString stringWithFormat:@"user_id=%@", self->user_id];
         
        [Request setHTTPMethod:@"POST"];
        NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
        [Request setHTTPBody:data];
        NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:Request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        
        if(error) {
        
           NSLog(@"dataTaskWithRequest error: %@", error);
           return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
          
            
            NSError *parseError = nil;
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                
                NSLog(@"OFFER==> %@", responseDictionary);
                
                long status = [[responseDictionary objectForKey:@"status"] integerValue];
            
                   if(status == 1 ) {
                    
                       
                       NSDictionary *data = [responseDictionary objectForKey:@"data"];
                                           
                                           NSMutableArray *arrayID = [[NSMutableArray alloc] init];
                       
                       
                        for (NSDictionary *dat in data){
                            
                             [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
                            
                        }
    
                       
                        self.IDArray = arrayID;
                    
                         dispatch_async(dispatch_get_main_queue(), ^{
                       
                             
                             [self.collectionView reloadData];
                             self.nodata.hidden = YES;
                             
                              
                             
                         });
                       
                       
                    
                }else {
                    
                    NSString *msg = [responseDictionary objectForKey:@"message"];
                    //[self salert:@"Alert" second:msg];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                                                  
                                                  self.nodata.hidden = NO;
                                            
                                          
                                              });
                                         
                   
                }
            
            

        }else {
            
            
            NSLog(@"%@",@"ERROR");
            
        }
        
    
    }];
    
    [dataTask resume];
           
           
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

    
    
    
    
    return cell;
    
    
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

@end
