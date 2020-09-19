
#import "Reg2ViewController.h"
#import "Reg3ViewController.h"

@interface Reg2ViewController ()<UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    
    NSString *currentPick;
    
    
    int imageGSTSelFlag;
    int imagePANSelFlag;
    
    
     NSString * company_name_str, * address_line1_str, * area_str, * city_str, * state_str, * pincode_str, * landmark_str, * website_str, * states_str, *shiparea_str,*shipaddress_str, *shipcity_str,*shipstate_str,*shiplandmark_str,*shippincode_str;
    
    NSString * name_str, * mobile_str, * emailID_str, * firm_str, * gst_str, * pan_str, * year_str, * shopMeter_str, * wareHouse_str, * employees_str, * anualturnover_str, * prominentBrand_str;
    
    
    UIImage * uplodGSTImage;
    UIImage * uplodPANImage;
    
    
}
@property (nonatomic, strong) NSArray *pickerNames;
@property (nonatomic, strong) NSArray *NoOfEmployeeArray;
@property (nonatomic, strong) NSArray *TurnOverArray;

@property (nonatomic, strong) NSArray *StateArray;

@end

@implementation Reg2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    imageGSTSelFlag = 0;
    imagePANSelFlag = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
         [self.view addGestureRecognizer:tap];
       
    _FlimpickerView.hidden = YES;

    
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
    
    
    
    self.nameTextView.delegate = self;
    self.mobileTextView.delegate = self;
    self.emailIDTextField.delegate = self;
    self.firmTextView.delegate = self;
    self.gstinTextView.delegate = self;
    self.panTextView.delegate = self;
    self.yearTextView.delegate = self;
    self.shopMeterTextView.delegate = self;
    self.wareHouseTextView.delegate = self;
    self.employeesTextView.delegate = self;
    self.anualturnoverTextView.delegate = self;
    self.prominentBrandsTextView.delegate = self;
    
    
    
    
    self.gstLabel.hidden = YES;
    
    

    
}


-(NSString*) trim : (NSString *) string{

    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
}
- (IBAction)nextBtn:(id)sender {
    
    
    name_str = [self trim:self.nameTextView.text];
    mobile_str = [self trim:self.mobileTextView.text];
    emailID_str = [self trim:self.emailIDTextField.text];
    firm_str = [self trim:self.firmTextView.text];
    gst_str = [self trim:self.gstinTextView.text];
    pan_str = [self trim:self.panTextView.text];
    year_str = [self trim:self.yearTextView.text];
    shopMeter_str = [self trim:self.shopMeterTextView.text];
    wareHouse_str = [self trim:self.wareHouseTextView.text];
    employees_str = [self trim:self.employeesTextView.text];
    anualturnover_str = [self trim:self.anualturnoverTextView.text];
    prominentBrand_str = [self trim:self.prominentBrandsTextView.text];
    
    
    
    if([name_str isEqualToString:@""]) {
        [self salert:@"Name" second:@"Please enter name"];
    }
    else if([mobile_str isEqualToString:@""]) {
        [self salert:@"Contact Number" second:@"Please enter contact number"];
    }
    else if([emailID_str isEqualToString:@""]) {
           [self salert:@"Contact Number" second:@"Please enter emailID"];
       }
    else if([firm_str isEqualToString:@""]) {
        [self salert:@"Types of firm" second:@"Please enter types of firm"];
    }
    else if([gst_str isEqualToString:@""]) {
        [self salert:@"GSTIN" second:@"Please enter gstin number"];
    }
    else if([pan_str isEqualToString:@""]) {
        [self salert:@"PAN" second:@"Please enter pan number"];
    }
    else if([year_str isEqualToString:@""]) {
        [self salert:@"Year of incorporation" second:@"Please enter year of incorporation"];
    }
    else if([shopMeter_str isEqualToString:@""]) {
        [self salert:@"Shop area in meter" second:@"Please enter shop area in meter"];
    }
    else if([wareHouse_str isEqualToString:@""]) {
        [self salert:@"Warehouse area" second:@"Please enter warehouse area"];
    }
    else if([employees_str isEqualToString:@""]) {
        [self salert:@"No of employees" second:@"Please enter no of employess"];
    }else if([anualturnover_str isEqualToString:@""]) {
        [self salert:@"Annual turnover" second:@"Please enter annual turnover"];
    }else if([prominentBrand_str isEqualToString:@""]) {
        [self salert:@"Prominent brands currently dealing with" second:@"Please enter Prominent brands currently dealing with"];
    }else if(imageGSTSelFlag == 0) {

           [self salert:@"GST Certificate" second:@"Please select gst certificate"];
  
        }else if(imagePANSelFlag == 0) {

                 [self salert:@"PAN Card" second:@"Please select pan card"];
        
      }else {
        
        Reg3ViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"register3View"];
        
                go.company_name = company_name_str;
                go.address = address_line1_str;
                go.area = area_str;
                go.city = city_str;
                go.state = state_str;
                go.pincode = pincode_str;
                go.landmark = landmark_str;
                go.website = website_str;
                go.statesID = states_str;
          
          go.ship_address = shipaddress_str;
          go.ship_area = shiparea_str;
          go.ship_city = shipcity_str;
          go.ship_state = shipstate_str;
          go.ship_landMark = shiplandmark_str;
          go.ship_pincode = shippincode_str;

                go.name = name_str;
                go.mobile = mobile_str;
                go.emailID = emailID_str;
                go.firm = firm_str;
                go.gst = gst_str;
                go.pan = pan_str;
                go.year = year_str;
                go.shopMeter = shopMeter_str;
                go.wareHouse = wareHouse_str;
                go.employees = employees_str;
                go.anualturnover = anualturnover_str;
                go.prominentBrand = prominentBrand_str;
        
          
                go.gstImage = uplodGSTImage;
                go.panImage = uplodPANImage;

        
               [self presentViewController:go animated:true completion:nil];
        
        
    }

    
}
- (IBAction)doneButton:(id)sender {
    _FlimpickerView.hidden = YES;

}
- (IBAction)FilmsType:(id)sender {
    
//self.statesTextField.text = _pickerView;
    _FlimpickerView.hidden = NO;
   
   
   _pickerView.delegate = self;
     _pickerView.dataSource = self;
  _pickerView.showsSelectionIndicator=YES;

   
   [self.view bringSubviewToFront:_FlimpickerView];

    self.pickerNames = @[@"Public Limited Company",@"Limited Liability Partnership",@"Sole Proprietorship",@"One Person Company",@"Other"];
    _pickerView.tag = 1;
}

-(IBAction)NoOfEmployeeButton:(id)sender{
    _FlimpickerView.hidden = NO;
     
     
     _pickerView.delegate = self;
       _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator=YES;

     
     [self.view bringSubviewToFront:_FlimpickerView];

      self.NoOfEmployeeArray = @[@"1-5",@"5-20",@"20-50",@">50"];
    _pickerView.tag = 2;
    
}
-(IBAction)TurnOverAction:(id)sender{
    _FlimpickerView.hidden = NO;
        
        
        _pickerView.delegate = self;
          _pickerView.dataSource = self;
       _pickerView.showsSelectionIndicator=YES;

        
        [self.view bringSubviewToFront:_FlimpickerView];

         self.TurnOverArray = @[@"<10 lakhs",@"Between 10 lakhs to 1 crore",@"Between 1 crore to 10 crore",@">10 crore"];
    _pickerView.tag = 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (_pickerView.tag == 1){
        return _pickerNames.count;
    }
   
    else if(_pickerView.tag == 2){
        return _NoOfEmployeeArray.count;
    }
    else if (_pickerView.tag == 3){
        return _TurnOverArray.count;
    }
return 0;
    
}
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
          return 1;
      
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(_pickerView.tag == 1){
        return _pickerNames[row];
    }
    else if(_pickerView.tag == 2){
        return _NoOfEmployeeArray[row];
    }
    else if (_pickerView.tag == 3){
        return _TurnOverArray[row];
    }
    
    return @"";

}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.firmTextView.text = self.pickerNames[row];
    self.employeesTextView.text = self.NoOfEmployeeArray[row];
    self.anualturnoverTextView.text = self.TurnOverArray[row];
    NSLog(@"%ldperce",(long)row);
  
}

-(void)salert:(NSString *)title second:(NSString *)message{
    
        dispatch_async(dispatch_get_main_queue(), ^{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
            
    });
    
}


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


- (IBAction)uploadBtn:(id)sender {

    currentPick = @"pan";

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
   // picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)gstUploadBtn:(id)sender {
    
    currentPick = @"gst";
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    // picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (IBAction)back:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    if([currentPick isEqualToString:@"gst"]) {
        
        
        uplodGSTImage = info[UIImagePickerControllerOriginalImage];
        imageGSTSelFlag = 1;
        
        
         self.gstLabel.hidden = NO;
        
        
    }else if([currentPick isEqualToString:@"pan"]) {
        
        
         uplodPANImage = info[UIImagePickerControllerOriginalImage];
         imagePANSelFlag = 1;
        
        
    }

   // UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];

    [picker dismissViewControllerAnimated:YES completion:NULL];

}

@end
