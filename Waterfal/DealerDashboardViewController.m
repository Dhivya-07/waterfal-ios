
#import "DealerDashboardViewController.h"
#import "OfferSchemeViewController.h"
#import "AppDelegate.h"
#import "CartViewController.h"
#import "ProductsViewController.h"
#import "HistoryViewController.h"
#import "HistorySetlementViewController.h"
#import "FavouritesViewController.h"
#import "UIViewController+EQViewController.h"

@interface DealerDashboardViewController () {
    
    
    NSArray *_pickerData;
    
    UIActivityIndicatorView *spinner;
}


@property (nonatomic, strong) NSArray *OfferIDArray;



@end

@implementation DealerDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    self.pick1.dataSource = self;
    self.pick1.delegate = self;
    
    
    
    self.pick2.dataSource = self;
    self.pick2.delegate = self;
    
    self.pick3.dataSource = self;
    self.pick3.delegate = self;
    
    self.pick4.dataSource = self;
    self.pick4.delegate = self;
    
    
    
    
    
    
    _pickerData = @[@"Monthwise", @"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    
    
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.v1.bounds];
      self.v1.layer.masksToBounds = NO;
      self.v1.layer.shadowColor = [UIColor blackColor].CGColor;
      self.v1.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
      self.v1.layer.shadowOpacity = 0.3f;
      self.v1.layer.shadowPath = shadowPath.CGPath;
    
    
    
    
    UIBezierPath *shadowPath2 = [UIBezierPath bezierPathWithRect:self.v2.bounds];
         self.v2.layer.masksToBounds = NO;
         self.v2.layer.shadowColor = [UIColor blackColor].CGColor;
         self.v2.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
         self.v2.layer.shadowOpacity = 0.3f;
         self.v2.layer.shadowPath = shadowPath2.CGPath;
    
    
    UIBezierPath *shadowPath3 = [UIBezierPath bezierPathWithRect:self.v3.bounds];
           self.v3.layer.masksToBounds = NO;
           self.v3.layer.shadowColor = [UIColor blackColor].CGColor;
           self.v3.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
           self.v3.layer.shadowOpacity = 0.3f;
           self.v3.layer.shadowPath = shadowPath3.CGPath;
    
    
    UIBezierPath *shadowPath4 = [UIBezierPath bezierPathWithRect:self.v4.bounds];
             self.v4.layer.masksToBounds = NO;
             self.v4.layer.shadowColor = [UIColor blackColor].CGColor;
             self.v4.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
             self.v4.layer.shadowOpacity = 0.3f;
             self.v4.layer.shadowPath = shadowPath4.CGPath;
    
    UIBezierPath *shadowPath5 = [UIBezierPath bezierPathWithRect:self.v5.bounds];
               self.v5.layer.masksToBounds = NO;
               self.v5.layer.shadowColor = [UIColor blackColor].CGColor;
               self.v5.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
               self.v5.layer.shadowOpacity = 0.3f;
               self.v5.layer.shadowPath = shadowPath5.CGPath;
    
    
    

        [self closeMenu];
       
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
              [self.view addGestureRecognizer:tap];
            
            
            
            UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeleft:)];
            swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
            [_viewSideBack addGestureRecognizer:swipeLeft];
           
    
    
    
   // NSString *str=@"http://chart.apis.google.com/chart?cht=pc&chd=t:120,45|120,60,50,70,60&chs=300x200&chl=||helo|wrd|india|pak|ban&chco=FFFFFF|FFFFFF,e72a28|a9d331|ffce08|8a2585|184a7d";
    
    
    
    
  
    

}


- (void)viewWillAppear:(BOOL)animated
{
    [self getOffer];
    //[self getDashboard];
    
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
       
        
      NSString *str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:90,50,40,80,50,40,60|50,20,40,50,50,40,60&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";

      NSString *myurl=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

             NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL
             URLWithString:myurl]];



        dispatch_sync(dispatch_get_main_queue(), ^(void) {
           UIImage *myimage = [[UIImage alloc] initWithData:imageData];
           self.barChart.image=myimage;
        });
    });
    
    
/*3*/
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
            
        
        
       NSString *  str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:80,30,20,20&chl=Bib cock|Tap|Angle cock|Sink";
        
        
               NSString *myurl=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                      
                      NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL
                      URLWithString:myurl]];
                
           dispatch_sync(dispatch_get_main_queue(), ^(void) {
               
               UIImage *myimage = [[UIImage alloc] initWithData:imageData];
               self.pieChart.image=myimage;
               
               
               
               
               
           });
               
               
           });
    
    /*2*/
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        
        
       NSString * str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|50,50&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
               
            
              
           
           NSString *myurl=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                  
                  NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL
                  URLWithString:myurl]];
             dispatch_sync(dispatch_get_main_queue(), ^(void) {
           
                  UIImage *myimage = [[UIImage alloc] initWithData:imageData];
                  self.overDueDounutChart.image=myimage;
                 
                 
                 
                 self.over_due_value.text = [NSString stringWithFormat:@"50%@", @"K"];
           
                 
             });
              
          });
       
           
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
                 
               
                  NSString *   str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
                 
           
           NSString *myurl2=[str2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
           
           NSData *imageData2 = [[NSData alloc] initWithContentsOfURL:[NSURL
           URLWithString:myurl2]];
                 
           dispatch_sync(dispatch_get_main_queue(), ^(void) {
           UIImage *myimage2 = [[UIImage alloc] initWithData:imageData2];
           self.dueTodayDounutChart.image=myimage2;
               
            self.due_today_value.text = [NSString stringWithFormat:@"40%@", @"K"];
               
               
               
                 
             });
           
           
       });
           

           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
               

          NSString *   str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
      

           
           NSString *myurl3=[str3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                  
                  NSData *imageData3 = [[NSData alloc] initWithContentsOfURL:[NSURL
                  URLWithString:myurl3]];
               
                dispatch_sync(dispatch_get_main_queue(), ^(void) {
                  UIImage *myimage3 = [[UIImage alloc] initWithData:imageData3];
                  self.notYetDueDounutChat.image=myimage3;
                    
                      self.notyet_due_value.text = [NSString stringWithFormat:@"40%@", @"K"];
               
               
                     });
                   
                   
               });
           
    
    
    
    /*4*/
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        
       NSString * str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|50,50&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
                  
             
        
        
           
              
              NSString *myurl=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                     
                     NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL
                     URLWithString:myurl]];
           
           
                 dispatch_sync(dispatch_get_main_queue(), ^(void) {
           
           
                     UIImage *myimage = [[UIImage alloc] initWithData:imageData];
                     self.primaryPersonDounutChart.image=myimage;
                     
                     
                     
                     self.primary_person_value.text = [NSString stringWithFormat:@"50%@", @"%"];
              
                     
                 });
            });
          
           
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
                 
                 NSString * str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
                 
              
              NSString *myurl2=[str2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
              
              NSData *imageData2 = [[NSData alloc] initWithContentsOfURL:[NSURL
              URLWithString:myurl2]];
                 
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
              UIImage *myimage2 = [[UIImage alloc] initWithData:imageData2];
              self.secondaryPersonDounutChart.image=myimage2;
              

                self.secondary_person_value.text = [NSString stringWithFormat:@"40%@", @"%"];
              
              
                     });
                });
              
    
    
    
}


-(void)getOffer{
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
       
    
    NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, ALLOFFER];
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
                
                NSLog(@"OFFER==> %@", responseDictionary);
                
                long status = [[responseDictionary objectForKey:@"status"] integerValue];
            
                   if(status == 1 ) {
                    
                       
                       NSDictionary *data = [responseDictionary objectForKey:@"data"];
                                           
                                           NSMutableArray *arrayID = [[NSMutableArray alloc] init];
                       
                       
                        for (NSDictionary *dat in data){
                            
                             [arrayID addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"id"]]];
                            
                        }
    
                       
                        self.OfferIDArray = arrayID;
                    
                         dispatch_async(dispatch_get_main_queue(), ^{
                       
                             
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

-(void)getDashboard{
    
    [self ShowpageLoader];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{
       
    
    NSString *Url = [NSString stringWithFormat:@"%@%@", BASEURL, DASHBOARD];
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
                    
    
                    
                         dispatch_async(dispatch_get_main_queue(), ^{
                       
                              [self hidePageLoader];
                              
                             
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



-(void)salert:(NSString *)title second:(NSString *)message{
    
        dispatch_async(dispatch_get_main_queue(), ^{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
            
    });
    
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
    
        _viewSideBack.hidden = NO;
        _viewSideMenu.hidden = NO;
       
       
       CATransition *transition = [CATransition animation];
         transition.duration = 0.5;
         transition.type = kCATransitionPush;
         transition.subtype = kCATransitionFromLeft;
         [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
         [_viewSideMenu.layer addAnimation:transition forKey:nil];
    
    
}

- (IBAction)cart:(UIBarButtonItem *)sender {
    
    
    CartViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"cartView"];
       [self presentViewController:go animated:true completion:nil];
       
    
}

- (IBAction)closeNav:(id)sender {
    
    [self closeMenu];
    
}

-(IBAction)DashboardButtonAction:(id)sender{
    [self closeMenu];

}
-(IBAction)ProductsButtonAction:(id)sender{
     ProductsViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"productView"];

    
        [self presentViewController:go animated:true completion:nil];
    
}
-(IBAction)FavouritesButtonAction:(id)sender{
    FavouritesViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"favouritesView"];

       
           [self presentViewController:go animated:true completion:nil];
    
}
-(IBAction)OrderHistoryButtonAction:(id)sender{
    HistoryViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"historyView"];

          
    [self presentViewController:go animated:true completion:nil];
    
}
-(IBAction)StatementButtonAction:(id)sender{
    HistorySetlementViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"HistorySetlementViewController"];

            
      [self presentViewController:go animated:true completion:nil];
      
    
}
-(IBAction)LogoutButtonAction:(id)sender{
    [self logOut:true];

}
- (NSInteger)collectionView:(UICollectionView *)cv numberOfItemsInSection:(NSInteger)section{
    
    return self.OfferIDArray.count;
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
    
         OfferSchemeViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"OfferS"];

    
        [self presentViewController:go animated:true completion:nil];
    
}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.textColor = [UIColor blackColor];
    label.text = _pickerData[row];
    return label;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}



- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    
    if(thePickerView == self.pick1) {
        
        NSString *str;
        
        
        if(row ==0){
            
            
              str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:90,50,40,80,50,40,60|50,20,40,50,50,40,60&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            
            
        }else

        if(row == 1){
            
            
             str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:40,60,80,40,30,50,50|40,30,50,80,60,80,20&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            

            
        }else

        if(row == 2){
            
            str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:60,80,70,20,50,40,80|60,40,60,90,70,50,80&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            

            
        }else if(row ==3){
            
            
              str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:90,50,40,80,50,40,60|50,20,40,50,50,40,60&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            
            
        }else

        if(row == 4){
            
            
             str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:40,60,80,40,30,50,50|40,30,50,80,60,80,20&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            

            
        }else

        if(row == 5){
            
            str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:60,80,70,20,50,40,80|60,40,60,90,70,50,80&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            

            
        }else if(row ==6){
            
            
              str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:90,50,40,80,50,40,60|50,20,40,50,50,40,60&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            
            
        }else

        if(row == 7){
            
            
             str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:40,60,80,40,30,50,50|40,30,50,80,60,80,20&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            

            
        }else

        if(row == 8){
            
            str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:60,80,70,20,50,40,80|60,40,60,90,70,50,80&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            

            
        }else if(row ==9){
            
            
              str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:90,50,40,80,50,40,60|50,20,40,50,50,40,60&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            
            
        }else

        if(row == 10){
            
            
             str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:40,60,80,40,30,50,50|40,30,50,80,60,80,20&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            

            
        }else

        if(row == 11){
            
            str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:60,80,70,20,50,40,80|60,40,60,90,70,50,80&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            

            
        }else if(row == 12){
            
            
              str = @"https://chart.apis.google.com/chart?cht=bvg&chco=65c466,3478f6&chd=t:90,50,40,80,50,40,60|50,20,40,50,50,40,60&chs=435x200&chds=0,100&chxt=x,y&chxl=0:|Jan|Feb|Mar|Apr|May|June|July";
            

            
        }
        
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
          
         NSString *myurl=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         
         NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL
         URLWithString:myurl]];
             
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            
            UIImage *myimage = [[UIImage alloc] initWithData:imageData];
                   self.barChart.image=myimage;
            
        });
            
            
        });
        
        
        
        
       
        
        
        
    }else if(thePickerView == self.pick3) {
        
        
        
        NSString *str;
        
        
        if(row ==0){
            
            
              str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:70,40,20,20&chl=Bib cock|Tap|Angle cock|Sink";
            
            
        }else

        if(row == 1){
            
            
             str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:50,50,40,20&chl=Bib cock|Tap|Angle cock|Sink";
            

            
        }else

        if(row == 2){
            
            str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:60,30,20,10&chl=Bib cock|Tap|Angle cock|Sink";
            
            
            //&chdl=Big Cock (32,000)|Tap|Angle Cock|Sink

            
        }else if(row ==3){
            
            
              str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:90,20,70,10&chl=Bib cock|Tap|Angle cock|Sink";
            
            
        }else

        if(row == 4){
            
            
             str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:10,30,20,20&chl=Bib cock|Tap|Angle cock|Sink";
            

            
        }else

        if(row == 5){
            
            str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:60,30,20,20&chl=Bib cock|Tap|Angle cock|Sink";
            

            
        }else if(row ==6){
            
            
              str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:80,80,20,20&chl=Bib cock|Tap|Angle cock|Sink";
            
            
        }else

        if(row == 7){
            
            
             str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:80,30,80,20&chl=Bib cock|Tap|Angle cock|Sink";
            

            
        }else

        if(row == 8){
            
            str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:80,80,20,20&chl=Bib cock|Tap|Angle cock|Sink";
            

            
        }else if(row ==9){
            
            
              str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:80,30,20,80&chl=Bib cock|Tap|Angle cock|Sink";
            
            
        }else

        if(row == 10){
            
            
             str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:80,50,20,20&chl=Bib cock|Tap|Angle cock|Sink";
            

            
        }else

        if(row == 11){
            
            str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:80,30,50,20&chl=Bib cock|Tap|Angle cock|Sink";
            

            
        }else if(row == 12){
            
            
              str = @"https://chart.apis.google.com/chart?cht=p&chco=4293a4,030502,6ec0f2,f2ac4c&chs=400x350&chd=t:80,40,20,20&chl=Bib cock|Tap|Angle cock|Sink";
            

            
        }
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
         
            NSString *myurl=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                   
                   NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL
                   URLWithString:myurl]];
             
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            
            UIImage *myimage = [[UIImage alloc] initWithData:imageData];
            self.pieChart.image=myimage;
            
        });
            
            
        });
        
        
        
        
       
       
        
    
        
    }else if(thePickerView == self.pick2) {
    
    
    NSString *str;
    NSString *str2;
    NSString *str3;
    
    NSString *v1, *v2, *v3;
    
    
    if(row ==0){
        
        
          str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|50,50&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122";
        
        v1 = @"50";
        
        str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        v2 = @"30";
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        v3 = @"30";
 
        
    }else

    if(row == 1){
        
        
        v1 = @"30";
        v2 = @"90";
        v3 = @"90";
        
         str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        

         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|90,10&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|90,10&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        
    }else

    if(row == 2){
        
        str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|20,80&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        
         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|70,30&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|70,30&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";

        
        v1 = @"20";
               v2 = @"70";
               v3 = @"30";
        
    }else if(row ==3){
        
        
          str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        
         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|80,20&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
         str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|80,20&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        
        v1 = @"40";
               v2 = @"80";
               v3 = @"80";
        
        
    }else

    if(row == 4){
        
        
         str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|80,20&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        
         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        
        v1 = @"80";
               v2 = @"30";
               v3 = @"30";
        
    }else

    if(row == 5){
        
        str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|60,40&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        
        
         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        
        v1 = @"60";
               v2 = @"40";
               v3 = @"40";
        
        
        
    }else if(row ==6){
        
        
          str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|80,20&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        
         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|70,30&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|70,30&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        
        v1 = @"80";
               v2 = @"70";
               v3 = @"70";
        
        
    }else

    if(row == 7){
        
        
         str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        
         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        
        v1 = @"40";
               v2 = @"40";
               v3 = @"40";
        
    }else

    if(row == 8){
        
        str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|50,50&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        
        
         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|20,80&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|20,80&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        
        v1 = @"50";
               v2 = @"20";
               v3 = @"20";
        
        
        
    }else if(row ==9){
        
        
          str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        
        
         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|20,80&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|20,80&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        
        
        v1 = @"30";
               v2 = @"20";
               v3 = @"20";
        
        
        
    }else

    if(row == 10){
        
        
         str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|50,50&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        
         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        
        
        v1 = @"50";
               v2 = @"40";
               v3 = @"40";
             
        
    }else

    if(row == 11){
        
        str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|90,10&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        
         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|10,90&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|10,90&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        
        v1 = @"90";
               v2 = @"10";
               v3 = @"10";
        

        
    }else if(row == 12){
        
        
          str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,74D3EF|EDEDED&chs=122x122&chp=4.7";
        
        
         str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,c51233|EDEDED&chs=122x122";
        
        str3 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,21a68b|EDEDED&chs=122x122";
        

        
        v1 = @"40";
               v2 = @"30";
               v3 = @"30";
        
        }
        
        
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        NSString *myurl=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
               
               NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL
               URLWithString:myurl]];
          dispatch_sync(dispatch_get_main_queue(), ^(void) {
        
               UIImage *myimage = [[UIImage alloc] initWithData:imageData];
               self.overDueDounutChart.image=myimage;
              
              
              
              self.over_due_value.text = [NSString stringWithFormat:@"%@K", v1];
              
              
              
          });
           
       });
    
        
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        NSString *myurl2=[str2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSData *imageData2 = [[NSData alloc] initWithContentsOfURL:[NSURL
        URLWithString:myurl2]];
              
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
        UIImage *myimage2 = [[UIImage alloc] initWithData:imageData2];
        self.dueTodayDounutChart.image=myimage2;
            
            
         self.due_today_value.text = [NSString stringWithFormat:@"%@K", v2];
            
              
          });
        
        
    });
        

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
        NSString *myurl3=[str3 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
               
               NSData *imageData3 = [[NSData alloc] initWithContentsOfURL:[NSURL
               URLWithString:myurl3]];
            
             dispatch_sync(dispatch_get_main_queue(), ^(void) {
               UIImage *myimage3 = [[UIImage alloc] initWithData:imageData3];
               self.notYetDueDounutChat.image=myimage3;
            
            self.notyet_due_value.text = [NSString stringWithFormat:@"%@K", v3];
                  });
                
                
            });
        
        
        
    }else if(thePickerView == self.pick4) {
       
       
       NSString *str;
       NSString *str2;
        
        NSString *v1, *v2;
     
       
       
       if(row ==0){
           
           
             str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
          
           v1= @"30";
           v2= @"70";
    
           
       }else

       if(row == 1){
           
           
            str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           

            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|90,10&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
           v1= @"30";
           v2= @"90";
         
           
       }else

       if(row == 2){
           
           str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|20,80&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|70,30&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
          v1= @"20";
          v2= @"70";
           
       }else if(row ==3){
           
           
             str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|80,20&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
         v1= @"40";
         v2= @"80";
           
       }else

       if(row == 4){
           
           
            str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|80,20&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
         v1= @"80";
         v2= @"30";
           
       }else

       if(row == 5){
           
           str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|60,40&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
           
            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
           
           v1= @"60";
           v2= @"40";
           
       }else if(row ==6){
           
           
             str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|80,20&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|70,30&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
        
           v1= @"80";
           v2= @"70";
           
       }else

       if(row == 7){
           
           
            str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
          
           v1= @"40";
           v2= @"40";
           
       }else

       if(row == 8){
           
           str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|50,50&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
           
            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|20,80&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
           
         
               v1= @"50";
           v2= @"20";

           
       }else if(row ==9){
           
           
             str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
           
            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|20,80&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
           
         v1= @"30";
         v2= @"20";
           
           
       }else

       if(row == 10){
           
           
            str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|50,50&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
           v1= @"50";
           v2= @"40";
                
           
       }else

       if(row == 11){
           
           str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|90,10&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|10,90&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
          v1= @"90";
          v2= @"10";

           
       }else if(row == 12){
           
           
             str = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|40,60&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
           
            str2 = @"https://chart.googleapis.com/chart?cht=pc&chd=t:-1|-1|-1|-1|30,70&chco=FFFFFF,FFFFFF,FFFFFF,FFFFFF,ffa524|EDEDED&chs=122x122";
           
         
           v1= @"40";
           v2= @"30";

           
           }
        
        
        
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        
           
           NSString *myurl=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                  
                  NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL
                  URLWithString:myurl]];
        
        
              dispatch_sync(dispatch_get_main_queue(), ^(void) {
        
        
                  UIImage *myimage = [[UIImage alloc] initWithData:imageData];
                  self.primaryPersonDounutChart.image=myimage;
                  
                  
                  self.primary_person_value.text = [NSString stringWithFormat:@"%@%@", v1, @"%"];
           
                  
              });
         });
       
        
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
           
           NSString *myurl2=[str2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
           
           NSData *imageData2 = [[NSData alloc] initWithContentsOfURL:[NSURL
           URLWithString:myurl2]];
              
         dispatch_sync(dispatch_get_main_queue(), ^(void) {
           UIImage *myimage2 = [[UIImage alloc] initWithData:imageData2];
           self.secondaryPersonDounutChart.image=myimage2;
           

            self.secondary_person_value.text = [NSString stringWithFormat:@"%@%@", v2, @"%"];
           
                  });
             });
           
         
           
           
       }
    
    

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
