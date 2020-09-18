//
//  CustumerSearchViewController.m
//  Waterfal
//
//  Created by MAC on 14/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import "CustumerSearchViewController.h"
#import "AppDelegate.h"
#import "CustumerProductsViewController.h"
#import "CustumerProductDetailsViewController.h"
#import "UIViewController+EQViewController.h"
@interface CustumerSearchViewController ()<UITextFieldDelegate>{
UIActivityIndicatorView *spinner;
     NSString * cat_id, * c_name, * search_type, *user_type;
}

@property (nonatomic, strong) NSArray *IDArray;
@property (nonatomic, strong) NSArray *NameArray;
@property (nonatomic, strong) NSArray *DescArray;
@property (nonatomic, strong) NSArray *TitleArray;
@property (nonatomic, strong) NSArray *ImageArray;
@property (nonatomic, strong) NSArray *PriceArray;
@property (nonatomic, strong) NSArray *QuantityArray;





@property (nonatomic, strong) NSArray *IDSeriesArray;
@property (nonatomic, strong) NSArray *NameSeriesArray;
@property (nonatomic, strong) NSArray *DescSeriesArray;
@property (nonatomic, strong) NSArray *ImageSeriesArray;

@end

@implementation CustumerSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
             [self.view addGestureRecognizer:tap];
     [self getSeriesList];
    [self getProductList];

     self.searchTxt.delegate = self;
     _searchNotify.hidden = YES;

    [self.searchTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
     }

-(void)textFieldDidChange :(UITextField *) textField{
    

    NSString *searchStr = [self.searchTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
   
    
    if(![searchStr isEqualToString:@""]){
        
        self.collectionView.hidden = NO;
        _searchNotify.hidden = NO;
        
       // [self getProducts];
        
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



-(void)getProductList
{
    
    [self showLoading:true];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
       
    
           NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, CATAGORYLIST];
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
                
                NSLog(@"Dashboard==> %@", responseDictionary);
                
                long status = [[responseDictionary objectForKey:@"status"] integerValue];
            
                   if(status == 1 ) {
                       
                       
                       NSDictionary *data = [responseDictionary objectForKey:@"data"];
                       
                       NSMutableArray *arrayID = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayName = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayDesc = [[NSMutableArray alloc] init];
                      NSMutableArray *arrayImage = [[NSMutableArray alloc] init];
                       
                        for (NSDictionary *dat in data){
                            
                            [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
                            
                            [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"name"]]];
                            
                            [arrayDesc addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"description"]]];
                            
                            [arrayImage addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"image"]]];

                        }
                       
                    
                       self.IDArray = arrayID;
                       self.NameArray = arrayName;
                       self.DescArray = arrayDesc;
                       self.ImageArray = arrayImage;
                    dispatch_async(dispatch_get_main_queue(), ^{

                           //  [self hidePageLoader];
                            // [self.collectionView reloadData];
                              
                             
                         });
                       
                       
                    
                }else {
                    
                    NSString *msg = [responseDictionary objectForKey:@"message"];
                    [self salert:@"Error" second:msg];
                   
                }
            
            

        }else {
            
            
            NSLog(@"%@",@"ERROR");
            
        }
        
    
    }];
    
    [dataTask resume];
           
           
    });
    
  
    
}


-(void)getSeriesList
{
    
    [self showLoading:true];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
       
    
           NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, SERIESLIST];
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
                
                NSLog(@"Dashboard==> %@", responseDictionary);
                
                long status = [[responseDictionary objectForKey:@"status"] integerValue];
            
                   if(status == 1 ) {
                       
                       
                       NSDictionary *data = [responseDictionary objectForKey:@"data"];
                       
                       NSMutableArray *arrayID = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayName = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayDesc = [[NSMutableArray alloc] init];
                       NSMutableArray *arrayImages = [[NSMutableArray alloc] init];
                       
                        for (NSDictionary *dat in data){
                            
                            [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
                            
                            [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"name"]]];
                            
                            [arrayDesc addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"description"]]];
                             [arrayImages addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"image"]]];
                        }
                       
                    
                       self.IDSeriesArray = arrayID;
                       self.NameSeriesArray = arrayName;
                       self.DescSeriesArray = arrayDesc;
                       self.ImageSeriesArray = arrayImages;
                    dispatch_async(dispatch_get_main_queue(), ^{

                           //  [self hidePageLoader];
                            // [self.collectionView reloadData];
                              
                             
                         });
                       
                       
                    
                }else {
                    
                    NSString *msg = [responseDictionary objectForKey:@"message"];
                    [self salert:@"Error" second:msg];
                   
                }
            
            

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
    UIImageView * img = (UIImageView *)[cell viewWithTag:4];
   
    
    

    name.text = [self.NameArray objectAtIndex:indexPath.row];
    title.text = [self.TitleArray objectAtIndex:indexPath.row];
    price.text = [NSString stringWithFormat:@"Price: ₹%@ per product", [self.PriceArray objectAtIndex:indexPath.row]];
    
    NSURL *imageUrl = [NSURL URLWithString:[self.ImageArray objectAtIndex:indexPath.row]];
   UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
   img.image = image;

   //NSLog("%@",[Img objectAtIndex:indexPath.row]);
    
    
    UIButton *deleteBtn = (UIButton *)[cell viewWithTag:7];
    deleteBtn.tag = indexPath.row;
    [deleteBtn.layer setValue:[self.IDArray objectAtIndex:indexPath.row] forKey:@"id"];
       [deleteBtn addTarget:self action:@selector(deleteMethod:) forControlEvents:UIControlEventTouchDown];
    

    return cell;
    
    
}
-(void)deleteMethod:(UIButton*)sender{
    int tag = (int) sender.tag;

    CustumerProductDetailsViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CustumerProductDetailsViewController"];
    
        go.pid = [self.IDArray objectAtIndex:tag];
       // go.cat_type = self->c_name;

        [self presentViewController:go animated:true completion:nil];
    
    
}
- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CustumerProductDetailsViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CustumerProductDetailsViewController"];
     
         go.pid = [self.IDArray objectAtIndex:indexPath.row];
        // go.cat_type = self->c_name;

         [self presentViewController:go animated:true completion:nil];
     
    
//    CustumerProductsViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"productDetails"];
//
//        go.pid = [self.IDArray objectAtIndex:indexPath.row];
//
//        [self presentViewController:go animated:true completion:nil];
    
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
