
#import "CustomerHomeViewController.h"
#import "ProductsCollectionViewCell.h"
#import "ProductListsViewController.h"
#import "AppDelegate.h"
#import "SearchViewController.h"
#import "Mycart2ViewController.h"
#import "googleMapViewController.h"
#import <DGActivityIndicatorView/DGActivityIndicatorView.h>
#import "UIViewController+EQViewController.h"
#import "CustumerProductsViewController.h"

@interface CustomerHomeViewController ()<UITextFieldDelegate> {
    NSString * pincode_str;
    DGActivityIndicatorView *activityIndicatorView;

}


@property (nonatomic, strong) NSArray *NameArray;
@property (nonatomic, strong) NSArray *Comapany_nameArray;
@property (nonatomic, strong) NSArray *MobileArray;
@property (nonatomic, strong) NSArray *AddressArray;
@property (nonatomic, strong) NSArray *AreaArray;
@property (nonatomic, strong) NSArray *CityArray;
@property (nonatomic, strong) NSArray *PincodeArray;
@property (nonatomic, strong) NSArray *StateArray;


@end

@implementation CustomerHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self closeMenu];
    self.neareststalLabel.hidden = YES;
    self.productsButton.hidden = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeleft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_viewSideBack addGestureRecognizer:swipeLeft];
    
    _textfield.delegate = self;
    pincode_str = [self.textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    

    
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
    
    [self dismissViewControllerAnimated:true completion:nil];
    
//    _viewSideBack.hidden = NO;
//    _viewSideMenu.hidden = NO;
//
//
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.5;
//    transition.type = kCATransitionPush;
//    transition.subtype = kCATransitionFromLeft;
//    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    [_viewSideMenu.layer addAnimation:transition forKey:nil];
    
    
}
-(IBAction)searchButtonAction:(id)sender{
    pincode_str = [self.textfield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if([pincode_str isEqualToString:@""]) {
        [self salert:@"Pincode" second:@"Please enter the Pincode"];
    }
    
   
    if (pincode_str.length > 7 ){
        [self salert:@"Pincode" second:@"Please enter the correct Pincode"];
    }
    else{
        [self getdealers];

    }
}

-(void)getdealers{
    
  [self showLoading:true];

    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
    dispatch_async(queue, ^{
        
        
        NSString *Url = [NSString stringWithFormat:@"%@%@?pincode=%@", BASEURL, GETDEALERS, self->pincode_str];
        // NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, GETDEALERS];
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
                
                NSLog(@"getdelars==> %@", responseDictionary);
                
                long status = [[responseDictionary objectForKey:@"status"] integerValue];
                
                
                NSMutableArray *arrayName = [[NSMutableArray alloc] init];
                NSMutableArray *arrayComapanyName = [[NSMutableArray alloc] init];
                NSMutableArray *arrayMobile = [[NSMutableArray alloc] init];
                NSMutableArray *arrayArea = [[NSMutableArray alloc] init];
                NSMutableArray *arrayState = [[NSMutableArray alloc] init];
                NSMutableArray *arrayAddress = [[NSMutableArray alloc] init];
                
                NSMutableArray *arrayCity = [[NSMutableArray alloc] init];
                NSMutableArray *arrayPincode = [[NSMutableArray alloc] init];
                
                
                if(status == 1 ) {

                    NSDictionary *data = [responseDictionary objectForKey:@"dealers"];
                    
                    for (NSDictionary *dat in data){
                        
                        [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"name"]]];
                        [arrayComapanyName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"company_name"]]];
                        [arrayMobile  addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"mobile"]]];
                        [arrayArea addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"area"]]];
                        [arrayState addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"state"]]];
                        [arrayCity addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"city"]]];
                        [arrayPincode addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"pincode"]]];
                        [arrayAddress addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"address"]]];
                        
                        
                    }
                    
                    self.NameArray = arrayName;
                    self.Comapany_nameArray = arrayComapanyName;
                    self.MobileArray = arrayMobile;
                    self.AreaArray = arrayArea;
                    self.CityArray = arrayCity;
                    self.PincodeArray = arrayPincode;
                    self.CityArray = arrayCity;
                    self.AddressArray = arrayAddress;
                    self.StateArray = arrayState;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        self.neareststalLabel.hidden = NO;

                        self.productsButton.hidden = YES;
                        
                        [self.collectionView reloadData];
                        
                        
                        
                    });
                    
                    
                    
                }else {
                    NSString *msg = [responseDictionary objectForKey:@"message"];
                    [self salert:@"Alert" second:msg];
                    
                    NSDictionary *data = [responseDictionary objectForKey:@"dealers"];
                    
                    for (NSDictionary *dat in data){
                        
                        [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"name"]]];
                        [arrayComapanyName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"company_name"]]];
                        [arrayMobile  addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"mobile"]]];
                        [arrayArea addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"area"]]];
                        [arrayState addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"state"]]];
                        [arrayCity addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"city"]]];
                        [arrayPincode addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"pincode"]]];
                        [arrayAddress addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"address"]]];
                        
                        
                    }
                   
                    
                    self.NameArray = arrayName;
                    self.Comapany_nameArray = arrayComapanyName;
                    self.MobileArray = arrayMobile;
                    self.AreaArray = arrayArea;
                    self.CityArray = arrayCity;
                    self.PincodeArray = arrayPincode;
                    self.CityArray = arrayCity;
                    self.AddressArray = arrayAddress;
                    self.StateArray = arrayState;

                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.neareststalLabel.hidden = YES;
                        
                        self.productsButton.hidden = NO;

                            [self.collectionView reloadData];
                                           
                                           
                                           
                                       });                }
                
                
            }else {
                
                NSLog(@"%@",@"ERROR");
                
            }
            
            
        }];
        
        [dataTask resume];
        
        
    });
    
    
    
}
-(IBAction)ProductsBuutonAction:(id)sender{
    
    
    CustumerProductsViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CustumerProductsViewController"];
      //go.dealer_id = pincode_str;
         [self presentViewController:go animated:true completion:nil];
    
}
-(IBAction)cartButtonAction:(id)sender{
    Mycart2ViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"Mycart2ViewController"];
    //go.dealer_id = pincode_str;
       [self presentViewController:go animated:true completion:nil];
}
-(void)salert:(NSString *)title second:(NSString *)message{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    });
    
}

- (IBAction)closeNav:(id)sender {
    
    [self closeMenu];
    
}

- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section{
    
    if (_NameArray.count == 0){
        return 0;
    }
    else{
        return _NameArray.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ProductsCollectionViewCell";
    
    ProductsCollectionViewCell *cell = [_collectionView  dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.nameLabel.text = _Comapany_nameArray[indexPath.row];
    cell.addressLabel.text = _AddressArray[indexPath.row];

    cell.cityLabel.text =[NSString stringWithFormat:@"%@ %@", [_CityArray objectAtIndex:indexPath.row],[_StateArray objectAtIndex:indexPath.row]];

    cell.pincodeLabel.text = _PincodeArray[indexPath.row];
    cell.mobileNumberLabel.text = [NSString stringWithFormat:@"ContactNumber%@",[_MobileArray objectAtIndex:indexPath.row]];
    cell.contactNameLabel.text = _NameArray[indexPath.row];
   // cell.contactNameLabel.text = _NameArray[indexPath.row];
    cell.productsButton.tag = indexPath.row;
    [cell.productsButton addTarget:self action:@selector(ProductsMethod:) forControlEvents:UIControlEventTouchUpInside];
    cell.callButton.tag = indexPath.row;
    [cell.callButton addTarget:self action:@selector(callbutton:) forControlEvents:UIControlEventTouchUpInside];
    cell.mapButton.tag = indexPath.row;
    [cell.mapButton addTarget:self  action:@selector(mapButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, 1)];
    bottomBorder.backgroundColor = [UIColor redColor];
    
    return cell;
    
    
}
-(void)mapButton:(UIButton *)sender{
   // googleMapViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"googleMapViewController"];
       //go.dealer_id = pincode_str;
        //  [self presentViewController:go animated:true completion:nil];
}
-(void)callbutton:(UIButton *)sender{
    int tag = (int) sender.tag;
    NSString *phoneNumber = [@"tel://" stringByAppendingString:_MobileArray[tag]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}
-(void)ProductsMethod:(UIButton*)sender{
    //ProductListsViewController //productListView
    SearchViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"searchView"];
    [self presentViewController:go animated:true completion:nil];
    
    
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    // compare first character to 'space' character by decimal value
    if (text.length && [text characterAtIndex:0] == 32) {
        
        // check if previous character is a newline
        NSInteger locationOfPreviousCharacter = range.location - 1;
        if (locationOfPreviousCharacter < 0 || [textView.text characterAtIndex:locationOfPreviousCharacter] == 6) {
            textView.backgroundColor = [UIColor yellowColor];
            return NO;
        }
    }
    
    return YES;
}
@end
