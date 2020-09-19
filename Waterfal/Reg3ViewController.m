

#import "Reg3ViewController.h"
#import "AppDelegate.h"

@interface Reg3ViewController ()<UITextFieldDelegate> {
    

    
    NSString * company_name_str, * address_line1_str, * area_str, * city_str, * state_str, * pincode_str, * landmark_str, * website_str, * states_str, *shiparea_str,*shipaddress_str, *shipcity_str,*shipstate_str, *shiplandmark_str, *shippincode_str;
    
    NSString * name_str, * mobile_str, * emailID_str, * firm_str, * gst_str, * pan_str, * year_str, * shopMeter_str, * wareHouse_str, * employees_str, * anualturnover_str, * prominentBrand_str;
    
    
    UIImage * uplodGSTImage;
    UIImage * uplodPANImage;
    
    
    
    int agree;
    
    
}

@end

@implementation Reg3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    agree = 0;
    
    
    company_name_str = self.company_name;
    address_line1_str = self.address;
    area_str = self.area;
    city_str = self.city;
    state_str = self.state;
    pincode_str = self.pincode;
    landmark_str = self.landmark;
    website_str = self.website;
    states_str = self.statesID;
    shipaddress_str = self.ship_address;
    shiparea_str = self.ship_area;
    shipcity_str = self.ship_city;
    shipstate_str = self.ship_state;
    shiplandmark_str = self.ship_landMark;
    shippincode_str = self.ship_pincode;
    
    
    name_str = self.name;
    mobile_str = self.mobile;
    emailID_str = self.emailID;
    firm_str = self.firm;
    gst_str = self.gst;
    pan_str = self.pan;
    year_str = self.year;
    shopMeter_str = self.shopMeter;
    wareHouse_str = self.wareHouse;
    employees_str = self.employees;
    anualturnover_str = self.anualturnover;
    prominentBrand_str = self.prominentBrand;
    
    
    
    uplodGSTImage = self.gstImage;
    uplodPANImage = self.panImage;
    
    
    
    self.company_name_label.text = company_name_str;
    self.addressLine1Label.text = address_line1_str;
    self.areaLabel.text = area_str;
    self.cityLabel.text = city_str;
    self.stateLabel.text = state_str;
    self.mobileLabel.text = mobile_str;
    
    
    self.emailLabel.hidden = YES;
    
    


}



- (IBAction)back:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerBtn:(id)sender {
    
    
    if (agree == 0) {
        
        [self salert:@"Terms and Conditions" second:@"Please agree the terms and conditions"];
        
    }else {
    
    [self register];
    
    }
}


-(void)register {
    
    
    NSString * company_name = self->company_name_str;
    NSString * address = self->address_line1_str;
    NSString * area = self->area_str;
    NSString * city = self->city_str;
    NSString * state = self->state_str;
    NSString * pincode = self->pan_str;
    NSString * landmark = self->landmark_str;
    NSString * website = self->website_str;
    NSString * statesID = self->states_str;
    
    NSString * ship_address = self->shipaddress_str;
    NSString * ship_area = self->shiparea_str;
    NSString * ship_city = self->shipcity_str;
    NSString * ship_state = self->shipstate_str;
    NSString * ship_landmark = self->shiplandmark_str;
    NSString * ship_pincode = self->shippincode_str;

    NSString * name = self->name_str;
    NSString * mobile = self->mobile_str;
    NSString * emailID = self->emailID_str;
    NSString * firm = self->firm_str;
    NSString * gst = self->gst_str;
    NSString * pan = self->pan_str;
    NSString * year = self->year_str;
    NSString * shopMeter = self->shopMeter_str;
    NSString * wareHouse = self->wareHouse_str;
    NSString * employees = self->employees_str;
    NSString * anualturnover = self->anualturnover_str;
    NSString * prominentBrand = self->prominentBrand_str;
    
    
    
    
    UIImage * gstimg = self->uplodGSTImage;
    UIImage * panimg = self->uplodPANImage;
    
    
    
    
           UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                               message:@"Please wait..\n\n\n"
                        preferredStyle:UIAlertControllerStyleAlert];

//        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
//           spinner.center = CGPointMake(130.5, 65.5);
//           spinner.color = [UIColor blackColor];
//           [spinner startAnimating];
//           [alert.view addSubview:spinner];
//           [self presentViewController:alert animated:NO completion:nil];

           
           
           dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
                dispatch_async(queue, ^{
           
           // COnvert Image to NSData
            NSData *gstdataImage = UIImageJPEGRepresentation(gstimg, 1.0f);
            NSData *pandataImage = UIImageJPEGRepresentation(panimg, 1.0f);
           
           // set your URL Where to Upload Image
           NSString *urlString = [NSString stringWithFormat:@"%@%@", BASEURL, REGISTER];
           
           
           NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
           // NSTimeInterval is defined as double
           NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
           
           NSString *new_randomstr = [timeStampObj.stringValue stringByReplacingOccurrencesOfString: @"." withString:@"_"];
           
           // set your Image Name
           NSString *filename = [NSString stringWithFormat:@"user_%@", new_randomstr];
           
           // Create 'POST' MutableRequest with Data and Other Image Attachment.
           NSMutableURLRequest* request= [[NSMutableURLRequest alloc] init];
           [request setURL:[NSURL URLWithString:urlString]];
           [request setHTTPMethod:@"POST"];
           NSString *boundary = @"---------------------------14737809831466499882746641449";
           NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
           [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
           NSMutableData *postbody = [NSMutableData data];
                    
                    
           [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
           [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"gst_file\"; filename=\"%@.jpg\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
           [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
           [postbody appendData:[NSData dataWithData:gstdataImage]];
           [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
            
            [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"pan_file\"; filename=\"%@.jpg\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[NSData dataWithData:pandataImage]];
            [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
                    
       
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"company_name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[company_name dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                            
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"address\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[address dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
       
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"area\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[area dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
 
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"city\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[city dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

         [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
       [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"pincode\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[pincode dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"state\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[state dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ship_address\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[ship_address dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ship_area\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[ship_area dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ship_city\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                    [postbody appendData:[ship_city dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

          [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
         [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ship_state\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
         [postbody appendData:[ship_state dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
        [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ship_city\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[ship_city dataUsingEncoding:NSUTF8StringEncoding]];
        [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ship_landmark\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[ship_landmark dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ship_pincode\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[ship_pincode dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"pincode\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[pincode dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
           

            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"landmark\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[landmark dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"website\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[website dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

                    
            //[postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            //[postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"ID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            //[postbody appendData:[statesID dataUsingEncoding:NSUTF8StringEncoding]];
            //[postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
           [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
           [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
           [postbody appendData:[name dataUsingEncoding:NSUTF8StringEncoding]];
           [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
         
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"mobile\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[mobile dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"email\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[emailID dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"firm_type\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[firm dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                           
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"gstin_number\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[gst dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"pan_number\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[pan dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    

            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"year_of_incorporation\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[year dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
  
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"shop_area\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[shopMeter dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"warehouse_area\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[wareHouse dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

               
             //   =%@&=%@&=%@&=%@&=%@
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"no_employee\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[employees dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"annual_turnover\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[anualturnover dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                    
   
                    
            [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"dealing_brands\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[prominentBrand dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            

           
           [request setHTTPBody:postbody];
                    
           // Get Response of Your zRequest
           NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
           NSString *responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
           NSLog(@"Response  %@",responseString);
                    
          NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    
          NSString *message = [json objectForKey:@"message"];
                             
          int status = (int) [[json objectForKey:@"status"] integerValue];
                    
    
             dispatch_async(dispatch_get_main_queue(), ^{
        

                 [self dismissViewControllerAnimated:YES completion:nil];
                 
                 
                 
                 if(status == 1) {
                     
                     

                      UIAlertController* alert2 = [UIAlertController alertControllerWithTitle:@"Registration"
                      message:message
                      preferredStyle:UIAlertControllerStyleAlert];
                      UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                      handler:^(UIAlertAction * action) {



                      [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];

                          //[self dismissViewControllerAnimated:YES completion:nil];


                      }];
                      [alert2 addAction:defaultAction];
                      [self presentViewController:alert2 animated:YES completion:nil];
                     
                     
                     
                     
                 }else {
                     
                     [self salert:@"Alert" second:message];
                     
                 }
                 
                

                 
             });
          

           
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

- (IBAction)agree_switch:(id)sender {
    
    UISwitch *switchObject = (UISwitch *)sender;
    if(switchObject.isOn){
        NSLog(@"Agree %@", @"ON...");
        
        agree = 1;
        
      
    }else{
        
        NSLog(@"Agree %@", @"OFF...");
        
        agree = 0;
        
        
    }
    
}


@end
