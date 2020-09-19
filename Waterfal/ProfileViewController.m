

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "ProductsViewController.h"
#import "HistoryViewController.h"
#import "HistorySetlementViewController.h"
#import "FavouritesViewController.h"
#import "DealerDashboardViewController.h"
#import "UIViewController+EQViewController.h"
@interface ProfileViewController () {
    
    NSString * user_id;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self closeMenu];
      

           UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
             [self.view addGestureRecognizer:tap];
           
           
           
           UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeleft:)];
           swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
           [_viewSideBack addGestureRecognizer:swipeLeft];
    
    user_id = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];
           

}



- (void)viewWillAppear:(BOOL)animated{
    
    [self getProfile];
    
    
    
}



-(void)getProfile {
    
    
    [self pleaseWait];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
       
           
    
    NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, USERPROFILE];
    NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
    
    
    NSString *params =[NSString stringWithFormat:@"id=%@", self->user_id];
    
    [Request setHTTPMethod:@"POST"];
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    [Request setHTTPBody:data];
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:Request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        
        if(error) {
            [self closePresentView];
           NSLog(@"dataTaskWithRequest error: %@", error);
           return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            
            [self closePresentView];
            
            NSError *parseError = nil;
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                
                NSLog(@"Login Details==>%@", responseDictionary);
                
                long status = [[responseDictionary objectForKey:@"status"] integerValue];
            
                   if(status == 1 ) {
                    
                       
                       NSDictionary *data = [responseDictionary objectForKey:@"data"];

                         dispatch_async(dispatch_get_main_queue(), ^{
                       
                             
                             
                             self.dealer_name.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"name"]];
                             
                             self.address.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"address"]];
                             
                             
                             self.cityandstate.text = [NSString stringWithFormat:@"%@,%@", [data objectForKey:@"city"], [data objectForKey:@"state"]];
                             
                             self.pincode.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"pincode"]];
                             
                             
                             self.email.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"website"]];
                             
                             
                             self.shoparea.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"area"]];
                             
                             
                             self.shopcitystate.text = [NSString stringWithFormat:@"%@,%@", [data objectForKey:@"city"], [data objectForKey:@"state"]];
            
                             
                         });
                       
                    
                }else {
                    
                    NSString *msg = [responseDictionary objectForKey:@"message"];
                    [self salert:@"Alert" second:msg];
                   
                }
            
            

        }else {
            
        [self closePresentView];
            
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

- (IBAction)closeNav:(id)sender {
   
   [self closeMenu];
   
}




-(void)salert:(NSString *)title second:(NSString *)message{
    
        dispatch_async(dispatch_get_main_queue(), ^{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
            
    });
    
}



-(void)pleaseWait {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                       message:@"Please wait...\n\n\n"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        spinner.center = CGPointMake(130.5, 65.5);
        spinner.color = [UIColor blackColor];
        [spinner startAnimating];
        [alert.view addSubview:spinner];
        [self presentViewController:alert animated:NO completion:nil];
    });
}


-(void)closePresentView{

    dispatch_async(dispatch_get_main_queue(), ^{

        [self dismissViewControllerAnimated:YES completion:nil];
           
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
@end
