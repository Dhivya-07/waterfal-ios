
#import <Foundation/Foundation.h>
#import "PaymentViewController.h"
#import <Razorpay/Razorpay-Swift.h>
#import "AppDelegate.h"



@interface PaymentViewController ()<RazorpayPaymentCompletionProtocol, UITextFieldDelegate> {
    
    RazorpayCheckout *razorpay;
    NSString * orderId;
    NSString * payment_id;
    NSString * razorPayOrderId;
    NSString * razorPayPaymentId;
    
    NSString * mobile;
}

@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
     razorpay = [RazorpayCheckout initWithKey:@"rzp_test_o3qYAFWWz9fhiP" andDelegate:self];
    
    orderId = self.order_id;
    
    mobile = [[NSUserDefaults standardUserDefaults] stringForKey:@"mobile"];
    
    
    
}



- (void)onPaymentSuccess:(nonnull NSString*)rp_payment_id {
    
    
    self->razorPayPaymentId = rp_payment_id;
    
    
    
    // Please wait dialog...
    NSLog(@"Payment %@", rp_payment_id);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"Please wait...\n\n\n"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    if (@available(iOS 13.0, *)) {
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        spinner.center = CGPointMake(130.5, 65.5);
        spinner.color = [UIColor blackColor];
        [spinner startAnimating];
        [alert.view addSubview:spinner];
    } else {
        // Fallback on earlier versions
    }
    [self presentViewController:alert animated:NO completion:nil];
    
    
    NSString *url;
    NSMutableURLRequest *urlRequest;
    NSString *userReg;
    
    
    url = [NSString stringWithFormat:@"%@%@", BASEURL, PAYMENTSUCCESS];
    
    urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    userReg =[NSString stringWithFormat:@"user_id=%@&payment_id=%@&rp_payment_id=%@&order_id=%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"], self->payment_id, self->razorPayPaymentId, self->orderId];
        
    [urlRequest setHTTPMethod:@"POST"];
    
    //Convert the String to Data
    NSData *data1 = [userReg dataUsingEncoding:NSUTF8StringEncoding];
    
    //Apply the data to the body
    [urlRequest setHTTPBody:data1];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
                       dispatch_async(queue, ^{
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        
        
        
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
            //NSInteger success = [[responseDictionary objectForKey:@"success"] integerValue];
            long status = [[responseDictionary objectForKey:@"status"] integerValue];
            
            NSLog(@"%ld", status);
            if(status == 1)
            {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Payment"
                message:@"payment successful"
                preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                handler:^(UIAlertAction * action) {
                    
                    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
                    
                    
                }];
                
                [self dismissViewControllerAnimated:YES completion:nil];
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                    
                });
                
            }
        }else {
            
             dispatch_async(dispatch_get_main_queue(), ^{
             [self dismissViewControllerAnimated:YES completion:nil];
                 
             });
            
            NSLog(@"%@", @"ERROR..");
        }
        
    }];
    [dataTask resume];
                           
    });

    
    
    
}



- (void)onPaymentError:(int32_t)code description:(NSString * _Nonnull)str {
    
        NSLog(@"Payment %@" , str);
    
    

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Payment Failed"
                                                                   message:@"Please try again"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {

                                                          }];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
    
    NSString *url;
    NSMutableURLRequest *urlRequest;
    NSString *userReg;
    
    
    url = [NSString stringWithFormat:@"%@%@", BASEURL, PAYMENTFAILURE];
    
    urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];

    userReg =[NSString stringWithFormat:@"user_id=%@&payment_id=%@&message=%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"], self->payment_id, str];
        
    [urlRequest setHTTPMethod:@"POST"];
    
    //Convert the String to Data
    NSData *data1 = [userReg dataUsingEncoding:NSUTF8StringEncoding];
    
    //Apply the data to the body
    [urlRequest setHTTPBody:data1];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
                       dispatch_async(queue, ^{
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        
        
        
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            NSLog(@"The response is - %@",responseDictionary);
            //NSInteger success = [[responseDictionary objectForKey:@"success"] integerValue];
            long status = [[responseDictionary objectForKey:@"status"] integerValue];
            
            NSLog(@"%ld", status);
            if(status == 1)
            {
                
                
            }
        }else {
            
             dispatch_async(dispatch_get_main_queue(), ^{
            
                 
             });
            
            NSLog(@"%@", @"ERROR..");
        }
        
    }];
    [dataTask resume];
                           
    });

    
    
    
    
    
    
    
    
    
    
 
    
}

- (IBAction)payBtn:(id)sender {
    
    [self getRazorPayOrderId];
    
}




-(void)getRazorPayOrderId {
    
    [self pleaseWait];
    
       
       dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
             dispatch_async(queue, ^{
             
                 
          
          NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, CREATEPAYMENT];
          NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
          
          
          NSString *params =[NSString stringWithFormat:@"user_id=%@&order_id=%@", [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"], self->orderId];
          
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
                      
                      NSLog(@"Details==>%@", responseDictionary);
                      
                      long status = [[responseDictionary objectForKey:@"status"] integerValue];
                      NSString * razorpay_orderid = [NSString stringWithFormat:@"%@", [responseDictionary objectForKey:@"razorpay_orderid"]];
                      NSString * paymentId = [NSString stringWithFormat:@"%@", [responseDictionary objectForKey:@"payment_id"]];
                      float amount = [[responseDictionary objectForKey:@"order_amount"] floatValue];
                  
              
                        self->razorPayOrderId = razorpay_orderid;
                        self->payment_id = paymentId;


                  
                         if(status == 1 ) {
                             
                             
                             UIImage *logo = [UIImage imageNamed:@"waterfal"];
                             
                             NSDictionary *options = @{

                                     @"amount": [NSString stringWithFormat:@"%1.0f", amount*100],  //This is in currency subunits. 1000 = 1000 paise= INR 10.
                                     // all optional other than amount.
                                     @"currency": @"INR",  //We support more that 92 international currencies.
                                     @"image":logo,
                                     @"name": @"Waterfal",
                                     @"description": razorpay_orderid,
                                     @"order_id": razorpay_orderid,
                                     @"prefill" : @{
                                            @"email": @"",
                                            @"contact": self->mobile
                                            },
                                       @"theme": @{
                                       @"color": @"#C41230"
                                      }
                             };

                         dispatch_async(dispatch_get_main_queue(), ^{
 
                           [self->razorpay open:options displayController:self];
                             
                             
                         });
   
                          
                      }else {
                          
                           [self closePresentView];
                          
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





-(void)salert:(NSString *)title second:(NSString *)message{
    
        dispatch_async(dispatch_get_main_queue(), ^{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
            
    });
    
}

- (IBAction)back:(UIBarButtonItem *)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
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


@end
