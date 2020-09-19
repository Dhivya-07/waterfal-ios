

#import "Reg1ViewController.h"
#import "Reg2ViewController.h"
#import "HHDropDownList.h"
#import "AppDelegate.h"


@interface Reg1ViewController ()<UITextFieldDelegate> {
    
        UIActivityIndicatorView *spinner;
    NSString * company_name_str, * address_line1_str, * area_str, * city_str, * state_str, * pincode_str, * landmark_str, * website_str, *states_str, *shiparea_str,*shipaddress_str, *shipcity_str,*shipstate_str,*shiplandmark_str,*shippincode_str;
    NSDictionary *ApproversData, *resData, *usersData;
    NSString * cat_id, * c_name;

        NSArray *rows;
    
}
@property (nonatomic, copy) NSArray *dataArray;
@property (strong, nonatomic) HHDropDownList *dropDownList_1;
@property (assign, nonatomic) BOOL swayBool;
@property (strong, nonatomic) UIButton *button_3;
@property (nonatomic, strong) NSArray *pickerNames;

@property (nonatomic, strong) NSArray *IDArray;
@property (nonatomic, strong) NSArray *StateArray;
@property (nonatomic, strong) NSArray *CodeArray;
@property (nonatomic, strong) NSArray *StatusArray;
@property (assign, nonatomic) BOOL setValue;
@property(nonatomic,getter=Selected) BOOL selected;

@end

@implementation Reg1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
      [self.view addGestureRecognizer:tap];
    
    self.company_name.delegate = self;
    self.address_line1.delegate = self;
    self.area.delegate = self;
    self.city.delegate = self;
    self.state.delegate = self;
    self.pincode.delegate = self;
    self.landmark.delegate = self;
    self.website.delegate = self;
    self.shippingAddressTextField.delegate = self;
    self.shippingAreaTextField.delegate = self;
    self.shippingStateTextField.delegate = self;
    self.shippingLandMarkTextField.delegate = self;
    self.shippingPincodeTextField.delegate = self;
    _setValue = true;
    
    _statesPickerView.hidden = YES;
    [self getStatesList];

    UIImage *btnImage1 = [UIImage imageNamed:@"unSelectTick"];
    [_sameAsTextButton setImage:btnImage1 forState:UIControlStateNormal];
    
    }
-(IBAction)statesDone:(id)sender{
    
    _statesPickerView.hidden = YES;


    
}

-(void)ShowpageLoader
{
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];

    spinner.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);

    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    
}


-(void)hidePageLoader
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    [self->spinner removeFromSuperview];
        
    });
}



- (IBAction)btnAction:(id)sender {
    
//self.statesTextField.text = _pickerView;
   _statesPickerView.hidden = NO;

   
   _statePicker.delegate = self;
     _statePicker.dataSource = self;
  _statePicker.showsSelectionIndicator=YES;

   
   [self.view bringSubviewToFront:_statesPickerView];

    self.pickerNames = self.StateArray;
    
}
    

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerNames.count;

    
}
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
          return 1;
      
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerNames[row];

}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
        self.statesTextField.text = self.pickerNames[row];
    NSLog(@"%@id",_IDArray[row]);
    self->states_str = _IDArray[row];
}


-(void)getStatesList
{
    
    [self ShowpageLoader];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
       
    
           NSString *Url = [NSString stringWithFormat:@"%@%@?states_id=%@", BASEURL, STATES, self->cat_id];
    NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
    
    
         
    [Request setHTTPMethod:@"GET"];
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
                
                NSLog(@"states==> %@", responseDictionary);
                
                long status = [[responseDictionary objectForKey:@"status"] integerValue];
            
                   if(status == 1 ) {
                       
                       
                       NSDictionary *data = [responseDictionary objectForKey:@"data"];
                       
                       NSMutableArray *arrayID = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayState = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayCode = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayStatus = [[NSMutableArray alloc] init];
                       
                       
                        for (NSDictionary *dat in data){
                            
                            [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
                            
                            [arrayState addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"state"]]];
                            
                            [arrayCode addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"code"]]];
                            
                            [arrayStatus addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"status"]]];
                                                        
                        }
                       
                    
                       self.IDArray = arrayID;
                       self.StateArray = arrayState;
                       self.CodeArray = arrayCode;
                       self.StatusArray = arrayStatus;
                       self.CodeArray = arrayCode;
                       

                       
                       
    
                         dispatch_async(dispatch_get_main_queue(), ^{

                             [self hidePageLoader];
                            // [self.collectionView reloadData];
                              
                             
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


-(void)setData:(NSDictionary *)data{
    
    
    NSMutableArray *MyData = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *myRow = [[NSMutableDictionary alloc] init];
           
           [myRow setObject:@"- Leave Type -" forKey:@"value"];
           
           [myRow setObject:@"0" forKey:@"key"];
    
            [myRow setObject:@"0" forKey:@"info2"];
          
           [MyData addObject:myRow];
    


        for (NSDictionary *row in data){

            NSMutableDictionary *myRow = [[NSMutableDictionary alloc] init];

            [myRow setObject:[row objectForKey:@"value"] forKey:@"value"];

            [myRow setObject:[row objectForKey:@"key"] forKey:@"key"];
            
            [myRow setObject:[row objectForKey:@"info2"] forKey:@"info2"];
            

            [MyData addObject:myRow];
        }

    
    
    rows = MyData;
    
    [_pickerView reloadAllComponents];

    
}

- (IBAction)sameAsAddressButton:(id)sender {
    
    if (_sameAsTextButton.isSelected){
        [sender setSelected:NO];
        UIImage *btnImage1 = [UIImage imageNamed:@"unSelectTick"];
        [_sameAsTextButton setImage:btnImage1 forState:UIControlStateNormal];
         _shippingAddressTextField.text = @"";
        _shippingAreaTextField.text = @"";
        _shippingCityTextField.text = @"";
        _shippingStateTextField.text = @"";
        _shippingLandMarkTextField.text = @"";
        _shippingPincodeTextField.text = @"";
    } else{

        [sender setSelected:YES];
         UIImage *btnImage = [UIImage imageNamed:@"SelectedTick"];
        [_sameAsTextButton setImage:btnImage forState:UIControlStateNormal];
        _shippingAddressTextField.text = _address_line1.text;
        _shippingAreaTextField.text = _area.text;
        _shippingCityTextField.text = _city.text;
        _shippingStateTextField.text = _statesTextField.text;
        _shippingLandMarkTextField.text = _landmark.text;
        _shippingPincodeTextField.text = _pincode.text;
        
    }
    
    
}
- (IBAction)nextBtn:(id)sender {
    
    company_name_str = [self.company_name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    address_line1_str = [self.address_line1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    area_str = [self.area.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    city_str = [self.city.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    state_str = [self.state.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    pincode_str = [self.pincode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    landmark_str = [self.landmark.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    website_str = [self.website.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    shipaddress_str = [self.shippingAddressTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      shiparea_str = [self.shippingAreaTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      shipcity_str = [self.shippingCityTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      shipstate_str = [self.shippingStateTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      shiplandmark_str = [self.shippingLandMarkTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    shippincode_str = [self.shippingPincodeTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    
    if([company_name_str isEqualToString:@""]) {
        [self salert:@"Company Name" second:@"Please enter company name"];
    }else if([address_line1_str isEqualToString:@""]) {
        [self salert:@"Address Line1" second:@"Please enter address line1"];
    }else if([area_str isEqualToString:@""]) {
        [self salert:@"Area" second:@"Please enter area"];
    }else if([city_str isEqualToString:@""]) {
        [self salert:@"City" second:@"Please enter city"];
    }else if([state_str isEqualToString:@""]) {
        [self salert:@"State" second:@"Please enter state"];
    }else if([pincode_str isEqualToString:@""]) {
        [self salert:@"Pincode" second:@"Please enter pincode"];
    }else if([landmark_str isEqualToString:@""]) {
        [self salert:@"Landmark" second:@"Please enter landmark"];
    }else if([website_str isEqualToString:@""]) {
        [self salert:@"Website" second:@"Please enter website"];
    }else {
        

        
        Reg2ViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"register2View"];
        go.company_name = company_name_str;
        go.address = address_line1_str;
        go.area = area_str;
        go.city = city_str;
        go.state = state_str;
        go.pincode = pincode_str;
        go.landmark = landmark_str;
        go.website = website_str;
        go.state = states_str;
        
        go.ship_area = shiparea_str;
        go.ship_address = shipaddress_str;
        go.ship_city = shipcity_str;
        go.ship_state = shipstate_str;
        go.ship_landMark = shiplandmark_str;
        go.ship_pincode = shippincode_str;

        [self presentViewController:go animated:true completion:nil];
        
        
        
    }
    
    
    
}

- (IBAction)back:(id)sender { [self dismissViewControllerAnimated:YES completion:nil]; }


-(void)dismissKeyboard { [self.view endEditing:YES]; }

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
@end
