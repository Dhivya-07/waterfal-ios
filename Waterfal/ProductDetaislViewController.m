

#import "ProductDetaislViewController.h"
#import "OrderInformationViewController.h"
#import "AppDelegate.h"
#import <DGActivityIndicatorView/DGActivityIndicatorView.h>

@interface ProductDetaislViewController ()<UITextFieldDelegate> {
    
    NSString * p_id,* search_type;
    UIActivityIndicatorView *spinner;
    NSString * order_amount;
    NSString * user_id;
    
    NSString * catType;
}

@end

@implementation ProductDetaislViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    p_id = self.pid;
    self.titleTxt.text = @"";
    self.nameTxt.text = @"";
    self.descTxt.text = @"";
    self.priceTxt.text = @"";
    self.quantity.delegate = self;
    
    
    catType = self.cat_type;
     search_type = self.searchType;
    
    self.cat_typeLabel.text = catType;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
    self.quantity.delegate = self;
    
    user_id = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    
    [self getData];
    
    
}


-(void)getData
{
    
    int ver = arc4random() % 100;
    
    [self ShowpageLoader];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
          dispatch_async(queue, ^{
            
       
              NSString *Url = [NSString stringWithFormat:@"%@%@?id=%@&user_id=%@&search_type=%@", BASEURL, PRODUCT, self->p_id, self->user_id, self->search_type];
       NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
       
       
       //NSString *params =[NSString stringWithFormat:@"id=%@", self->p_id];
       
       [Request setHTTPMethod:@"GET"];
      // NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
       //[Request setHTTPBody:data];
       NSURLSession *session = [NSURLSession sharedSession];
       
       
       NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:Request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
       {
           
           if(error) {
               //[self closePresentView];
              NSLog(@"dataTaskWithRequest error: %@", error);
              return;
           }
           
           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
           if(httpResponse.statusCode == 200)
           {
               
               //[self closePresentView];
               
               NSError *parseError = nil;
                   NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                   
                   //NSLog(@"Details==>%@", responseDictionary);
                   
                   long status = [[responseDictionary objectForKey:@"status"] integerValue];
               
                      if(status == 1 ) {
                       
                         
               
                        dispatch_async(dispatch_get_main_queue(), ^{
                      
                            
                             [self hidePageLoader];
                            
                     NSDictionary *data = [responseDictionary objectForKey:@"data"];
                            
                        self.titleTxt.text = [data objectForKey:@"product_title"];

                        self.nameTxt.text = [data objectForKey:@"name"];

                        self.descTxt.text = [data objectForKey:@"description"];

                        self.priceTxt.text = [NSString stringWithFormat:@"Price: ₹%@ per product", [data objectForKey:@"price"]];
                            
                        self->order_amount = [NSString stringWithFormat:@"%@", [data objectForKey:@"price"]];
                            
                       NSString * user_cart_quantity =  [NSString stringWithFormat:@"%@", [data objectForKey:@"user_cart_quantity"]];
                            
                            if(![user_cart_quantity isEqualToString:@"0"]) {
                                
                                
                                self.quantity.text = user_cart_quantity;
                                
                            }
                            
                        
                        
                        

                            
                        });
                  
                          
                       
                   }else {
                       
                       NSString *msg = [responseDictionary objectForKey:@"message"];
                       [self salert:@"Alert" second:msg];
                      
                   }
               
               

           }else {
               
           //[self closePresentView];
               
               NSLog(@"%@",@"ERROR");
               
           }
           
       
       }];
       
       [dataTask resume];
              
              
       });
    

}




- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section{
    
    return 6;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
     UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
    
    
}


- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
         ProductDetaislViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"productDetails"];

    
        [self presentViewController:go animated:true completion:nil];
    
}



- (IBAction)addCart:(id)sender {
    
    NSString * quantity = [self.quantity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    if([quantity isEqualToString:@""]) {
        
    
         [self salert:@"Alert" second:@"Please enter quantity"];
        
    }else {
        
       [self addcart];
        
    }
      
}


-(void)addcart {
    
    
    [self.view endEditing:true];
    [self pleaseWait];
    
    
    NSString * quantity = [self.quantity.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
          dispatch_async(queue, ^{
          
              
       
       NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, CART];
       NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
       
       
              NSString *params =[NSString stringWithFormat:@"user_id=%@&product_id=%@&quantity=%@",  self->user_id, self->p_id, quantity];
           
              
              NSLog(@"PARAMMMMM %@", params);
              
       
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
               
                      if(status == 1 ) {
                       
                       
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                NSString *msg = [responseDictionary objectForKey:@"message"];
                                [self ShowAlert:msg];
                          
                        
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

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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




@end
