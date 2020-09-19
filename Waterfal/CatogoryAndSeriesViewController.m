//
//  CatogoryAndSeriesViewController.m
//  Waterfal
//
//  Created by MAC on 18/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import "CatogoryAndSeriesViewController.h"
#import "ProductDetaislViewController.h"
#import "AppDelegate.h"
#import "UIViewController+EQViewController.h"
#import "CustumerListViewController.h"
#import "AsyncImageView.h"


@interface CatogoryAndSeriesViewController (){
    UIActivityIndicatorView *spinner;
       
       NSString * cat_id, * c_name, * dealer,* search_type, *user_type;
}

@property (nonatomic, strong) NSArray *IDArray;
@property (nonatomic, strong) NSArray *NameArray;
@property (nonatomic, strong) NSArray *DescArray;
@property (nonatomic, strong) NSArray *TitleArray;
@property (nonatomic, strong) NSArray *CodeArray;
@property (nonatomic, strong) NSArray *PriceArray;
@property (nonatomic, strong) NSArray *QuantityArray;
@property (nonatomic, strong) NSArray *ImageArray;

@property (nonatomic, strong) NSArray *IDSeriesArray;
@property (nonatomic, strong) NSArray *NameSeriesArray;
@property (nonatomic, strong) NSArray *DescSeriesArray;
@property (nonatomic, strong) NSArray *imageSeriesArray;

@end

@implementation CatogoryAndSeriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getProductList];
    [self getSeriesList];
        cat_id = self.cid;
       c_name = self.cname;
       
       search_type = self.searchType;
          user_type = self.userType;
       
      // dealer = @"dealer";
       self.cnameLabel.text = c_name;
    
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
                      
                       NSMutableArray *arrayimg = [[NSMutableArray alloc] init];
                        for (NSDictionary *dat in data){
                            
                            [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
                            
                            [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"name"]]];
                            
                            [arrayDesc addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"description"]]];
                            [arrayimg addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"image"]]];
                        }
                       
                    
                       self.IDArray = arrayID;
                       self.NameArray = arrayName;
                       self.DescArray = arrayDesc;
                       self.ImageArray = arrayimg;
                    dispatch_async(dispatch_get_main_queue(), ^{

                        [self showLoading: false];
                             [self.collectionView reloadData];
                              
                             
                         });
                       
                       
                    
                }else {
                    
                    NSString *msg = [responseDictionary objectForKey:@"message"];
                    [self salert:@"Error" second:msg];
                   
                }
            
            

        }else {
            [self showLoading:false];

            
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
                      NSMutableArray *arrayimge = [[NSMutableArray alloc] init];
                       
                        for (NSDictionary *dat in data){
                            
                            [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
                            
                            [arrayName addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"name"]]];
                            
                            [arrayDesc addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"description"]]];
                             [arrayimge addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"image"]]];
                        }
                       
                    
                       self.IDSeriesArray = arrayID;
                       self.NameSeriesArray = arrayName;
                       self.DescSeriesArray = arrayDesc;
                       self.imageSeriesArray = arrayimge;
                    dispatch_async(dispatch_get_main_queue(), ^{

                        [self showLoading:false];
                        [self.collectionView reloadData];
                              
                             
                         });
                       
                       
                    
                }else {
                    
                    NSString *msg = [responseDictionary objectForKey:@"message"];
                    [self salert:@"Error" second:msg];
                   
                }
            
            

        }else {
           // [self showLoading:false];

            
            NSLog(@"%@",@"ERROR");
            
        }
        
    
    }];
    
    [dataTask resume];
           
           
    });
    
  
    
}

- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section{
    
    if ([cat_id isEqualToString:@"1"]){
        return self.IDArray.count;
    }
    else if ([cat_id isEqualToString:@"2"]){
        return self.IDSeriesArray.count;
    }
    return 0;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
     UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel * name = (UILabel *)[cell viewWithTag:1];
    UILabel * title = (UILabel *)[cell viewWithTag:2];
    UIImageView * img = (UIImageView *)[cell viewWithTag:4];
    
    if ([cat_id isEqualToString:@"1"]){
          name.text = [self.NameArray objectAtIndex:indexPath.row];
        title.text = [self.DescArray objectAtIndex:indexPath.row];
        
        
        NSString *imageUrl = [self.ImageArray objectAtIndex:indexPath.row];
        UIImageView *coursePicture = (UIImageView *) img;
                    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:coursePicture];
                    coursePicture.imageURL = [NSURL URLWithString:imageUrl];
        
    
//          UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
//          img.image = image;
        
        
        
    }
      else if ([cat_id isEqualToString:@"2"]){
          name.text = [self.NameSeriesArray objectAtIndex:indexPath.row];
        title.text = [self.DescSeriesArray objectAtIndex:indexPath.row];
    
          
//          NSURL *imageUrl = [NSURL URLWithString:[self.imageSeriesArray objectAtIndex:indexPath.row]];
//            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
//            img.image = image;
          
          
          NSString *imageUrl2 = [self.imageSeriesArray objectAtIndex:indexPath.row];
          UIImageView *coursePicture = (UIImageView *) img;
                      [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:coursePicture];
                      coursePicture.imageURL = [NSURL URLWithString:imageUrl2];
          
          
          
          
      }

   // name.text = [self.NameArray objectAtIndex:indexPath.row];
   // title.text = [self.TitleArray objectAtIndex:indexPath.row];
//price.text = [NSString stringWithFormat:@"Price: ₹%@ per product", [self.PriceArray objectAtIndex:indexPath.row]];
//
    
    
    

    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
         CustumerListViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CustumerListViewController"];
    
    //go.searchType = @"Custumer";
    go.userType = @"custumer";
    if ([cat_id isEqualToString:@"1"]){
        go.cid = _IDArray[indexPath.row];
            go.searchType = @"categories";
        go.cname = @"Product type";
 
           
       }
         else if ([cat_id isEqualToString:@"2"]){
             go.cid = _IDSeriesArray[indexPath.row];
             go.searchType =@"series";
            go.cname = @"Series type";
         }

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
