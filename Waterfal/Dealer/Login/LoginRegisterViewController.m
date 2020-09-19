

#import "LoginRegisterViewController.h"
#import "AppDelegate.h"
#import "VerifyOTPViewController.h"
#import "Reg1ViewController.h"

@interface LoginRegisterViewController ()<UITextFieldDelegate> {
    
    NSString *mobileStr;
}

@end

@implementation LoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
         [self.view addGestureRecognizer:tap];
       
       self.mobileTextView.delegate = self;

}




- (IBAction)registerBtn:(id)sender {
    

     Reg1ViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"register1View"];
    [self presentViewController:go animated:true completion:nil];
    
    
}

- (IBAction)loginBtn:(id)sender {
    
    
     mobileStr = [self.mobileTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if([mobileStr isEqualToString:@""]){
        
        [self salert:@"Mobile" second:@"Please enter mobile number"];
        
        
    }else if(mobileStr.length != 10){
        
        [self salert:@"Mobile" second:@"Please enter 10 digit mobile number"];
        
    }else {
        
    
        [self verifyOTP];
        

    }

}



-(void)nextPage
{
    
        VerifyOTPViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"verifyOtp"];
        [self presentViewController:go animated:true completion:nil];
    
}







-(void)verifyOTP {
    
    
    [self.view endEditing:true];
    
    [self pleaseWait];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
       
           
    
    NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, VERIFYMOBILE];
    NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
    
    
           NSString *params =[NSString stringWithFormat:@"mobile=%@", self->mobileStr];
    
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
                    

                       NSLog(@"OTP=> %@", [NSString stringWithFormat:@"%@", [responseDictionary objectForKey:@"otp"]]);
                    
                         dispatch_async(dispatch_get_main_queue(), ^{
                       
                             
                        VerifyOTPViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"verifyOtp"];
                        go.OTP = [NSString stringWithFormat:@"%@", [responseDictionary objectForKey:@"otp"]];
                        go.mobile = self->mobileStr;
                        [self presentViewController:go animated:true completion:nil];

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


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }

    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 10;
}







-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)dismissKeyboard { [self.view endEditing:YES]; }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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


- (IBAction)back:(id)sender {
    
      [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
