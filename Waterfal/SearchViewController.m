
#import "SearchViewController.h"
#import "AppDelegate.h"
#import "ProductDetaislViewController.h"

@interface SearchViewController () <UITextFieldDelegate>{
    
    UIActivityIndicatorView *spinner;
    
}

@property (nonatomic, strong) NSArray *IDArray;
@property (nonatomic, strong) NSArray *NameArray;
@property (nonatomic, strong) NSArray *DescArray;
@property (nonatomic, strong) NSArray *TitleArray;
@property (nonatomic, strong) NSArray *CodeArray;
@property (nonatomic, strong) NSArray *PriceArray;
@property (nonatomic, strong) NSArray *QuantityArray;
@property (nonatomic, strong) NSArray *ImageArray;



@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
            [self.view addGestureRecognizer:tap];
    [self getProducts];

    self.searchTxt.delegate = self;
    _searchNotify.hidden = YES;
    [self.searchTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
}


-(void)textFieldDidChange :(UITextField *) textField{
    

    NSString *searchStr = [self.searchTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
   
    
    if(![searchStr isEqualToString:@""]){
        
        self.collectionView.hidden = NO;
        _searchNotify.hidden = NO;
        
        [self getProducts];
        
    }else {
        
        self.collectionView.hidden = YES;
        _searchNotify.hidden = YES;
        
        
        
        
    }
    
    
    self.searchNotify.text = [NSString stringWithFormat:@"Search : ""\"%@\"", searchStr];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self.searchTxt becomeFirstResponder];

    
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



-(void)getProducts
{
    
    
    NSString *searchStr = [self.searchTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
   // [self ShowpageLoader];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
       
    
    NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, SEARCHPRODUCT];
    NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
    
     NSString *params =[NSString stringWithFormat:@"name=%@", searchStr];
         
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
                
                NSLog(@"Dashboard==> %@", responseDictionary);
                
                long status = [[responseDictionary objectForKey:@"status"] integerValue];
            

                    NSMutableArray *arrayID = [[NSMutableArray alloc] init];
                    NSMutableArray *arrayName = [[NSMutableArray alloc] init];
                    NSMutableArray *arrayDesc = [[NSMutableArray alloc] init];
                    NSMutableArray *arrayTitle = [[NSMutableArray alloc] init];
                    NSMutableArray *arrayCode = [[NSMutableArray alloc] init];
                    NSMutableArray *arrayPrice = [[NSMutableArray alloc] init];
                    NSMutableArray *arrayQuantity = [[NSMutableArray alloc] init];
                    NSMutableArray *arrayImage = [[NSMutableArray alloc] init];
            
                   if(status == 1 ) {
                       
                       
                       NSDictionary *data = [responseDictionary objectForKey:@"data"];
                       
                     
                       
                        for (NSDictionary *dat in data){
                            
                            [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
                            
                            [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"name"]]];
                            
                            [arrayDesc addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"description"]]];
                            
                            [arrayTitle addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"product_title"]]];
                            
                            [arrayCode addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"product_code"]]];
                            
                            [arrayPrice addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"price"]]];
                            
                            [arrayQuantity addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"quantity"]]];
                            
                            [arrayImage addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"display_image"]]];
                            

                        }
                       
                
                    
                }else {
                    
                    NSString *msg = [responseDictionary objectForKey:@"message"];
                  //  [self salert:@"Alert" second:msg];
                   
                }
            
            

            self.IDArray = arrayID;
            self.NameArray = arrayName;
            self.DescArray = arrayDesc;
            self.TitleArray = arrayTitle;
            self.CodeArray = arrayCode;
            self.PriceArray = arrayPrice;
            self.QuantityArray = arrayQuantity;
            self.ImageArray = arrayImage;
            
            
            dispatch_async(dispatch_get_main_queue(), ^{

                       //  [self hidePageLoader];
                
                    
                         [self.collectionView reloadData];
                          
                         
                     });
                               
            

        }else {
            
            
            NSLog(@"%@",@"ERROR");
            
        }
        
    
    }];
    
    [dataTask resume];
           
           
    });
    
  
    
}

- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section{
    
    return self.IDArray.count;
}

//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
     UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel * name = (UILabel *)[cell viewWithTag:1];
    UILabel * title = (UILabel *)[cell viewWithTag:2];
    UILabel * price = (UILabel *)[cell viewWithTag:3];
    
    
    

    name.text = [self.NameArray objectAtIndex:indexPath.row];
    title.text = [self.TitleArray objectAtIndex:indexPath.row];
    price.text = [NSString stringWithFormat:@"Price: ₹%@ per product", [self.PriceArray objectAtIndex:indexPath.row]];
    
    
    
    

    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
         ProductDetaislViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"productDetails"];
    
        go.pid = [self.IDArray objectAtIndex:indexPath.row];

        [self presentViewController:go animated:true completion:nil];
    
}



- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)salert:(NSString *)title second:(NSString *)message{
    
        dispatch_async(dispatch_get_main_queue(), ^{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
            
    });
    
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

@end
