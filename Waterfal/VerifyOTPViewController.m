

#import "VerifyOTPViewController.h"
#import "AppDelegate.h"

@interface VerifyOTPViewController ()<UITextFieldDelegate>{
    
    NSString *OTP_Str, * mobile_str;

    
    NSString *str1,*str2,*str3,*str4;
    
    
}

@end

@implementation VerifyOTPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
       [self.view addGestureRecognizer:tap];
    
    
    OTP_Str = self.OTP;
    mobile_str = self.mobile;
    
    
    self.textView1.delegate = self;
    self.textView2.delegate = self;
    self.textView3.delegate = self;
    self.textView4.delegate = self;
    
    
    
    str1 = self.textView1.text;
    str2 = self.textView2.text;
    str3 = self.textView3.text;
    str4 = self.textView4.text;

    [self.textView1 setTag:100];
       [self.textView2 setTag:200];
       [self.textView3 setTag:300];
       [self.textView4 setTag:400];


    
    [self.textView1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.textView2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.textView3 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.textView4 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
}

-(void)textFieldDidChange :(UITextField *) textField{
    

    
    //NSLog(@"TEXT TAG %ld", (long)textField.tag);

    long tag = (long)textField.tag;
    
    
    NSString *set1 = @"", *set2 = @"", *set3 = @"", *set4 = @"";
    NSString *setPinStr;


    if(tag == 100){
        
        if(textField.text.length ==1){
           // NSLog(@"NEXT %@", @"NEXT");
            set1 = textField.text;
            [self.textView2 becomeFirstResponder];
            
        }
        
        
    }else if(tag ==200){
      
        
        if(textField.text.length ==1){
          //  NSLog(@"NEXT %@", @"NEXT");
            set2 = textField.text;
            [self.textView3 becomeFirstResponder];
        }else {
            [self.textView1 becomeFirstResponder];
        }
        
        
    }else if(tag ==300){
      
        
        if(textField.text.length ==1){
            set3 = textField.text;
           // NSLog(@"NEXT %@", @"NEXT");
            [self.textView4 becomeFirstResponder];
        }else {
            [self.textView2 becomeFirstResponder];
        }
    }else if(tag ==400){
       
        
        if(textField.text.length ==1){
           // NSLog(@"Finish %@", @"Finish");
            set4 = textField.text;
             [self.view endEditing:YES];
        }else {
            [self.textView3 becomeFirstResponder];
        }
    }
    
    
    if(textField.text.length ==1){
        
        textField.layer.borderColor=[[UIColor colorWithRed:170.0f/255.0f green:5.0f/255.0f blue:53.0f/255.0f alpha:1.0] CGColor];
        
        
        textField.backgroundColor = [UIColor whiteColor];
        
    }else {
        
        textField.layer.borderColor=[[UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0] CGColor];
        
        
         textField.backgroundColor = [UIColor colorWithRed:(244.0 / 255.0) green:(244.0 / 255.0) blue:(244.0 / 255.0) alpha: 1];

    }

    
    set1 = [NSString stringWithFormat:@"%@", self.textView1.text];
    set2 = [NSString stringWithFormat:@"%@", self.textView2.text];
    set3 = [NSString stringWithFormat:@"%@", self.textView3.text];
    set4 = [NSString stringWithFormat:@"%@", self.textView4.text];
    
    
    
    setPinStr = [NSString stringWithFormat:@"%@%@%@%@", set1, set2, set3, set4];
    
    NSLog(@"SETPIN %@", setPinStr);
    

    
}

-(void)dismissKeyboard {
    
    [self.view endEditing:YES];
    
}

- (IBAction)back:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)verifyBtn:(id)sender {
    
    [self verify];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


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


- (void) ShowAlert2:(NSString *)Message {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil
                                                                  message:@""
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIView *firstSubview = alert.view.subviews.firstObject;
    UIView *alertContentView = firstSubview.subviews.firstObject;
    for (UIView *subSubView in alertContentView.subviews) {
        subSubView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    }
    NSMutableAttributedString *AS = [[NSMutableAttributedString alloc] initWithString:Message];
    [AS addAttribute: NSForegroundColorAttributeName value: [UIColor whiteColor] range: NSMakeRange(0,AS.length)];
    [alert setValue:AS forKey:@"attributedTitle"];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:^{
           
            [self nextpage];

        }];
    });
}


- (void) ShowAlert:(NSString *)Message {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil
                                                                  message:@""
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIView *firstSubview = alert.view.subviews.firstObject;
    UIView *alertContentView = firstSubview.subviews.firstObject;
    for (UIView *subSubView in alertContentView.subviews) {
        subSubView.backgroundColor = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:1.0f];
    }
    NSMutableAttributedString *AS = [[NSMutableAttributedString alloc] initWithString:Message];
    [AS addAttribute: NSForegroundColorAttributeName value: [UIColor whiteColor] range: NSMakeRange(0,AS.length)];
    [alert setValue:AS forKey:@"attributedTitle"];
    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:^{
            
           

        }];
    });
}



-(void)nextpage {
    
    UITabBarController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"homeView"];
    [self presentViewController:go animated:true completion:nil];
    
}


-(void)verify {
    
      
      str1 = [self.textView1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      str2 = [self.textView2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      str3 = [self.textView3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      str4 = [self.textView4.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
      
      
      
      NSString *otpStr = [NSString stringWithFormat:@"%@%@%@%@", str1, str2, str3, str4];
      
    
    
    if([str1 isEqualToString:@""]) {
        
         [self ShowAlert:@"Enter OTP"];
        
    }else if([str2 isEqualToString:@""]) {
        
        [self ShowAlert:@"Enter OTP"];
    }else if([str3 isEqualToString:@""]) {
        [self ShowAlert:@"Enter OTP"];
        
    }else if([str4 isEqualToString:@""]) {
        
        [self ShowAlert:@"Enter OTP"];
    }else {
        
        
        
        
        
           [self.view endEditing:true];
           
           [self pleaseWait];

           dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
              dispatch_async(queue, ^{
              
                  
           
           NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, VERIFYOTP];
           NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
           
           
                  NSString *params =[NSString stringWithFormat:@"mobile=%@&otp=%@", self->mobile_str, otpStr];
           
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
                               
                               
                               NSString * mobile = [data objectForKey:@"mobile"];
                               NSString * user_id = [data objectForKey:@"user_id"];


                              [[NSUserDefaults standardUserDefaults] setObject:user_id
                              forKey:@"user_id"];

                              [[NSUserDefaults standardUserDefaults] setObject:mobile
                              forKey:@"mobile"];
                              
                              
                           
                                NSString *msg = [responseDictionary objectForKey:@"message"];
                           
                                dispatch_async(dispatch_get_main_queue(), ^{
                              
                                    [self ShowAlert2:msg];
                                    
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
    

}

@end
