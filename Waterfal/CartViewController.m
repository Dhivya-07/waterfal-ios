

#import "CartViewController.h"
#import "AppDelegate.h"
#import "OrderInformationViewController.h"
#import "ProductDetaislViewController.h"

@interface CartViewController () {
    
    
    NSString * user_id;
}

@property (nonatomic, strong) NSArray *IDArray;
@property (nonatomic, strong) NSArray *NameArray;
@property (nonatomic, strong) NSArray *TitleArray;
@property (nonatomic, strong) NSArray *OrderAmountArray;
@property (nonatomic, strong) NSArray *QuantityArray;



@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.proceedView.hidden = YES;
    self.cartEmptyView.hidden = YES;
    
    
    
    user_id = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];
    
    }



- (void)viewWillAppear:(BOOL)animated {
    
    
    
    [self getData];
    
    
    
}

-(void)getData {
    
    
    int ver = arc4random() % 100;

    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
          dispatch_async(queue, ^{
          
              
       
              NSString *Url = [NSString stringWithFormat:@"%@%@?user_id=%@&v=%d", BASEURL, GETCART, self->user_id, ver];
       NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
              
              NSLog(@"URLLLLLL %@", Url);
       
       
       //NSString *params =[NSString stringWithFormat:@"user_id=%@", self->user_id];
       
       [Request setHTTPMethod:@"GET"];
      // NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
     //  [Request setHTTPBody:data];
       NSURLSession *session = [NSURLSession sharedSession];
       
       
       NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:Request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
       {
           
           if(error) {
              // [self closePresentView];
              NSLog(@"dataTaskWithRequest error: %@", error);
              return;
           }
           
           NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
           if(httpResponse.statusCode == 200)
           {
               
               //[self closePresentView];
               
               NSError *parseError = nil;
                   NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                   
                   NSLog(@"Details==>%@", responseDictionary);
                   
                   long status = [[responseDictionary objectForKey:@"status"] integerValue];
               
               NSString *tax_percentage = [NSString stringWithFormat:@"%@", [responseDictionary objectForKey:@"tax_percentage"]];
               
               NSString *gross_total = [NSString stringWithFormat:@"₹%@", [responseDictionary objectForKey:@"gross_total"]];
                             
               NSString *grand_total = [NSString stringWithFormat:@"₹%@", [responseDictionary objectForKey:@"grand_total"]];
               
               NSString *tax_total = [NSString stringWithFormat:@"₹%@", [responseDictionary objectForKey:@"tax_total"]];
                          
               
               NSMutableArray *arrayID = [[NSMutableArray alloc] init];
               NSMutableArray *arrayName = [[NSMutableArray alloc] init];
               NSMutableArray *arrayTitle = [[NSMutableArray alloc] init];
               NSMutableArray *arrayOrderAmount = [[NSMutableArray alloc] init];
               NSMutableArray *arrayQuantity = [[NSMutableArray alloc] init];
               
                      if(status == 1 ) {
                          
                          
        NSDictionary *data = [responseDictionary objectForKey:@"data"];
                                    
         for (NSDictionary *dat in data){
             
             [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"product_id"]]];
             [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"name"]]];
             [arrayTitle addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"product_title"]]];
             [arrayOrderAmount addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"price"]]];
             [arrayQuantity addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"quantity"]]];
             
             
             
         }

        
            self.IDArray = arrayID;
            self.NameArray = arrayName;
            self.TitleArray = arrayTitle;
            self.OrderAmountArray = arrayOrderAmount;
            self.QuantityArray = arrayQuantity;

          dispatch_async(dispatch_get_main_queue(), ^{
              
              
              self.proceedView.hidden = NO;
              
               self.cartEmptyView.hidden = YES;
              
              [self.collectionView reloadData];
              
              

              self->_taxPercentLabel.text = [NSString stringWithFormat:@"Taxes(@ %@ %@)", tax_percentage, @"%"];
              

              self->_grossTotalLabel.text = gross_total;
              self->_taxTotalLabel.text = tax_total;
              self->_grandTotalLabel.text = grand_total;
              
               
              
          });
        
                          
                          
                       
                   }else {
                       
                          dispatch_async(dispatch_get_main_queue(), ^{
                              
                              self.cartEmptyView.hidden = NO;
                              
                          });
                       
                       
                       
                       NSString *msg = [responseDictionary objectForKey:@"message"];
                      // [self salert:@"Alert" second:msg];
                      
                   }
               
               

           }else {
               
          // [self closePresentView];
               
               NSLog(@"%@",@"ERROR");
               
           }
           
       
       }];
       
       [dataTask resume];
              
              
       });
       
    
}


- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section{
    
    return self.IDArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
     UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    

    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, 1)];
       bottomBorder.backgroundColor = [UIColor redColor];
    
    
    
    UILabel * title = (UILabel *)[cell viewWithTag:1];
    title.text = [self.TitleArray objectAtIndex:indexPath.row];
    

    UILabel * name = (UILabel *)[cell viewWithTag:2];
    name.text = [self.NameArray objectAtIndex:indexPath.row];
    
    
    
    UILabel * price = (UILabel *)[cell viewWithTag:3];
    price.text = [NSString stringWithFormat:@"Price: ₹%@ per product", [self.OrderAmountArray objectAtIndex:indexPath.row]];
    
    
    UILabel * quantity = (UILabel *)[cell viewWithTag:4];
    quantity.text = [NSString stringWithFormat:@"Quantity : %@", [self.QuantityArray objectAtIndex:indexPath.row]];
    
    
    UIButton *deleteBtn = (UIButton *)[cell viewWithTag:7];
    [deleteBtn.layer setValue:[self.IDArray objectAtIndex:indexPath.row] forKey:@"product_id"];
    [deleteBtn addTarget:self action:@selector(deleteMethod:) forControlEvents:UIControlEventTouchDown];

    
    
    UIButton *editBtn = (UIButton *)[cell viewWithTag:6];
    [editBtn.layer setValue:[self.IDArray objectAtIndex:indexPath.row] forKey:@"product_id"];
    [editBtn addTarget:self action:@selector(editMethod:) forControlEvents:UIControlEventTouchDown];


    
    

    return cell;
    
    
}


-(void)editMethod:(UIButton*)sender{
    
     NSString *product_id = (NSString *)[sender.layer valueForKey:@"product_id"];
    
    
    
    
    ProductDetaislViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"productDetails"];
       
           go.pid = product_id;

           [self presentViewController:go animated:true completion:nil];
    
    
}



-(void)deleteMethod:(UIButton*)sender{

    
    NSString *product_id = (NSString *)[sender.layer valueForKey:@"product_id"];
    NSString * quantity = @"0";
    
    [self pleaseWait];
    

    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
          dispatch_async(queue, ^{
          
              
       
       NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, CART];
       NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
       
       
              NSString *params =[NSString stringWithFormat:@"user_id=%@&product_id=%@&quantity=%@",  self->user_id, product_id, quantity];
           
              
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
                                
                                [self getData];
                          
                        
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


- (IBAction)procedToPayBtn:(id)sender {
    
    [self createOrder];
    
}

-(void)createOrder {
    
    [self pleaseWait];
    
       
       dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
             dispatch_async(queue, ^{
             
                 
          
          NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, CREATEORDER];
          NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
          
          
          NSString *params =[NSString stringWithFormat:@"user_id=%@", self->user_id];
          
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
                             
                                NSString * order_id = [NSString stringWithFormat:@"%@", [responseDictionary objectForKey:@"order_id"]];

                             dispatch_async(dispatch_get_main_queue(), ^{
                                 
                                OrderInformationViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"orderinfView"];
                                go.order_id = order_id;
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

@end
