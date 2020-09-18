//
//  ShareViewController.m
//  Waterfal
//
//  Created by MAC on 13/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import "ShareViewController.h"
#import "AppDelegate.h"
#import "CustomerHomeViewController.h"
#import "UIViewController+EQViewController.h"
@interface ShareViewController ()<UITextFieldDelegate>{
    NSString * name_str, * mobile_str, * email_str, * location_str, * CustumerId_str,*dealerId_str;;
    NSString * user_id;

}

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
      [self.view addGestureRecognizer:tap];

    
    //self.dealer_id = dealerId_str;
    if(dealerId_str == nil){
        dealerId_str = @"";
    }else{
        self.dealer_id = dealerId_str;

    }
    
    user_id = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];

    self.nameTextField.delegate =self;
    self.mobileNumberTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.locationTextField.delegate = self;
    
   
    
}

-(void)dismissKeyboard { [self.view endEditing:YES]; }

-(IBAction)backButtonAction:(id)sender{
       [self dismissViewControllerAnimated:YES completion:nil];

}
-(IBAction)ShareButtonAction:(id)sender{
    [self shareAction];
    
}
-(void)shareAction
{

    
       name_str = [self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
       mobile_str = [self.mobileNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
       email_str = [self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    location_str = [self.locationTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];


    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{

           [self showLoading:true];

    NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, SHARE];
    NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
           
           NSString *params =[NSString stringWithFormat:@"customer_id=%@&name=%@&mobile=%@&email=%@&location=%@&dealer_id=%@", self->user_id,self->name_str,self->mobile_str,self->email_str,self->location_str,self->dealerId_str];

    [Request setHTTPMethod:@"POST"];

           NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
              [Request setHTTPBody:data];
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
                    [self salert:@"Success" second:msg];

                }else {

                    NSString *msg = [responseDictionary objectForKey:@"message"];
                   [self salert:@"Error" second:msg];

                }



            dispatch_async(dispatch_get_main_queue(), ^{

                [self showLoading:false];
                     });



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


@end
