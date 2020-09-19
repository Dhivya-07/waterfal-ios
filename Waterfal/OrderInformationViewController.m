

#import "OrderInformationViewController.h"
#import "AppDelegate.h"
#import "OrderConformationViewController.h"

@interface OrderInformationViewController () {
    
    
    NSString * orderId;
    NSString * user_id;
}

@property (nonatomic, strong) NSArray *NameArray;
@property (nonatomic, strong) NSArray *TitleArray;
@property (nonatomic, strong) NSArray *OrderAmountArray;
@property (nonatomic, strong) NSArray *QuantityArray;

@end

@implementation OrderInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    orderId = self.order_id;
    
    user_id = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];
    
    [self getData];
    
}


-(void)getData {
    
    
    [self pleaseWait];
       
       dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
             dispatch_async(queue, ^{
             
          
                 NSString *Url = [NSString stringWithFormat:@"%@%@?order_id=%@&user_id=%@", BASEURL, GETORDER, self->orderId, self->user_id];
          NSMutableURLRequest *Request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:Url]];
          
          
          //NSString *params =[NSString stringWithFormat:@"user_id=%@", self->user_id];
          
          [Request setHTTPMethod:@"GET"];
          //NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
          //[Request setHTTPBody:data];
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
                      
                      NSLog(@"ORDERINFORMATION==>%@", responseDictionary);
                      
                      long status = [[responseDictionary objectForKey:@"status"] integerValue];
                  
                         if(status == 1 ) {
                             
                             

        NSDictionary *data = [responseDictionary objectForKey:@"data"];
        NSDictionary *orderData = [responseDictionary objectForKey:@"order_details"];

                             
        NSMutableArray *arrayName = [[NSMutableArray alloc] init];
        NSMutableArray *arrayTitle = [[NSMutableArray alloc] init];
        NSMutableArray *arrayOrderAmount = [[NSMutableArray alloc] init];
        NSMutableArray *arrayQuantity = [[NSMutableArray alloc] init];

                         
                             
                             
            for (NSDictionary *dat in data){
                

                [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"product_name"]]];
                [arrayOrderAmount addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"price"]]];
                [arrayTitle addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"product_title"]]];
                [arrayQuantity addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"quantity"]]];
                
            }

           

            self.NameArray = arrayName;
            self.NameArray = arrayName;
            self.TitleArray = arrayTitle;
            self.OrderAmountArray = arrayOrderAmount;
            self.QuantityArray = arrayQuantity;

             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 
                 self.orderUidLabel.text = [NSString stringWithFormat:@"%@", [orderData objectForKey:@"order_id"]];
                 
                  self.orderDateLabel.text = [NSString stringWithFormat:@"%@", [orderData objectForKey:@"order_date"]];
                
                 self.valueLabel.text = [NSString stringWithFormat:@"₹%@", [orderData objectForKey:@"grand_total"]];

                  self.payTypelabel.text = [NSString stringWithFormat:@"%@", [orderData objectForKey:@"payment_type"]];
                 
                 
                 self.grossTotalLabel.text = [NSString stringWithFormat:@"₹%@", [orderData objectForKey:@"gross_total"]];
                 
                  self.discountLabel.text = [NSString stringWithFormat:@"-₹%@", [orderData objectForKey:@"discount_amount"]];
                 
                 self.taxesLabel.text = [NSString stringWithFormat:@"₹%@", [orderData objectForKey:@"tax_amount"]];
                 
                 self.grantTotalLabel.text = [NSString stringWithFormat:@"₹%@", [orderData objectForKey:@"grand_total"]];
                 
                 
                 
                 
                 
           
                 
                 [self.collectionView reloadData];
                 
                  
                 
             });
           
                             
                             
                          
                      }else {
                          
                          NSString *msg = [responseDictionary objectForKey:@"message"];
                         // [self salert:@"Alert" second:msg];
                         
                      }
                  
                  

              }else {
                  
              [self closePresentView];
                  
                  NSLog(@"%@",@"ERROR");
                  
              }
              
          
          }];
          
          [dataTask resume];
                 
                 
          });
    
    
    
    
}



- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section{
    
    return self.NameArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
     UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    UILabel * title = (UILabel *)[cell viewWithTag:1];
    title.text = [self.TitleArray objectAtIndex:indexPath.row];
    
    
    UILabel * name = (UILabel *)[cell viewWithTag:2];
    name.text = [self.NameArray objectAtIndex:indexPath.row];
    
    
    UILabel * price = (UILabel *)[cell viewWithTag:3];
    price.text = [NSString stringWithFormat:@"Price: ₹%@", [self.OrderAmountArray objectAtIndex:indexPath.row]];
    
    
    UILabel * quantity = (UILabel *)[cell viewWithTag:4];
    quantity.text = [NSString stringWithFormat:@"Quantity : %@", [self.QuantityArray objectAtIndex:indexPath.row]];
    
 
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height - 1, cell.frame.size.width, 1)];
       bottomBorder.backgroundColor = [UIColor redColor];


    
    return cell;
    
    
}





- (IBAction)procedToPayBtn:(id)sender {
    
    
    OrderConformationViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"oConformView"];
    
    go.order_id = self->orderId;
    
   [self presentViewController:go animated:true completion:nil];
      
    
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
@end
