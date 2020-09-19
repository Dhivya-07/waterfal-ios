

#import "ProductListsViewController.h"
#import "ProductDetaislViewController.h"
#import "AppDelegate.h"

@interface ProductListsViewController () {
    
    UIActivityIndicatorView *spinner;
    
    NSString * cat_id, * c_name, * dealer,* search_type, *user_type;;
     
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

@implementation ProductListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cat_id = self.cid;
    c_name = self.cname;
    
    search_type = self.searchType;
       user_type = self.userType;
    
   // dealer = @"dealer";
    self.cnameLabel.text = c_name;

    

}


- (void)viewWillAppear:(BOOL)animated{
    
    [self getProducts];
    
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
    
    [self ShowpageLoader];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
    
           NSString *Url = [NSString stringWithFormat:@"%@%@?cat_id=%@&search_type=%@&user_type=%@", BASEURL, ALLPRODUCTS, self->cat_id,self->search_type,self->user_type];
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
                
                NSLog(@"Dashboard==> %@", responseDictionary);
                
                long status = [[responseDictionary objectForKey:@"status"] integerValue];
            
                   if(status == 1 ) {
                       
                       
                       NSDictionary *data = [responseDictionary objectForKey:@"data"];
                       
                       NSMutableArray *arrayID = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayName = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayDesc = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayTitle = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayCode = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayPrice = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayQuantity = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayImage = [[NSMutableArray alloc] init];
                       
                        for (NSDictionary *dat in data){
                            
                            [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
                            
                            [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"name"]]];
                            
                            [arrayDesc addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"description"]]];
                            
                            [arrayTitle addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"product_title"]]];
                            
                            [arrayCode addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"product_code"]]];
                            
                            [arrayPrice addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"price"]]];
                            
                            [arrayQuantity addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"quantity"]]];
                            
                            [arrayImage addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"image"]]];
                            
                            
                            
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

                             [self hidePageLoader];
                             [self.collectionView reloadData];
                              
                             
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

- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section{
    if (_IDArray.count == 0){
        return 0;
    }else{
    return self.IDArray.count;
    }
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

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
        go.cat_type = self->c_name;
    go.searchType = search_type;

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

@end
