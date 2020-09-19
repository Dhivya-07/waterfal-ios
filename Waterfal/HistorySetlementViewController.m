
#import "HistorySetlementViewController.h"
#import "AppDelegate.h"
#import "UIViewController+EQViewController.h"

@interface HistorySetlementViewController (){
    NSString * user_id, *startDate, *endDate;
    NSDictionary *r2data;


}
@property (nonatomic, strong) NSArray *AmountArray;
@property (nonatomic, strong) NSArray *DateArray;
@property (nonatomic, strong) NSArray *ParticularsArray;
@property (nonatomic, strong) NSArray *TypeArray;
@property (nonatomic, strong) NSArray *NoArray;
@property (nonatomic, strong) NSArray *TypesArray;

@end

@implementation HistorySetlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _DVIew.hidden = YES;
   
        user_id = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];


    _pickerview.datePickerMode = UIDatePickerModeDate;
     // [_pickerview setMinimumDate:[NSDate date]];
      
     [self.view bringSubviewToFront:_DVIew];
    
    
      /*  NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"history" ofType:@"html"];
           NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];

           
       //    [_webView loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
           
           
           WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
             WKWebView *WkwebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
             WkwebView.navigationDelegate = self;
           
            [WkwebView loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
             //NSURL *nsurl=[NSURL URLWithString:_pdfurl];
             //NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
            // [webView loadRequest:nsrequest];
             [self.wView addSubview:WkwebView]; */
    
    
    
    
}
- (IBAction)doneButtonAction:(id)sender {
    
    _DVIew.hidden = YES;
    
    
      NSDate *chosen = [self.pickerview date];

     int ptag = (int)_pickerview.tag;
    
    
     if(ptag==1) {
         
         _fromTextField.text = [self formatDate:chosen];
         
         startDate = [self formatDate2:chosen];
         // [_pickerview setMinimumDate:chosen];
         
         
         
         endDate = @"";
         _toTextField.text = @"dd mm yyyy";
         _toTextField.text = @"dd mm yyyy";

         
     }else if(ptag ==2){
         
         _toTextField.text = [self formatDate:chosen];
        // [_pickerview setMinimumDate:chosen];
         endDate = [self formatDate2:chosen];
      
         
         
        
         
         NSDate *now = chosen;
                      NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                      NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
//          NSDate *startDate = [calendar dateFromComponents:components];
//          NSLog(@"StartDate = %@", startDate);

          components.day += 1;
          NSDate *joindaten = [calendar dateFromComponents:components];
         
         [_pickerview setMinimumDate:joindaten];

         
     }
     }
    
    

-(IBAction)fromTextAction:(id)sender{
  //  [_pickerview setMinimumDate:[NSDate date]];

    
    _DVIew.hidden = NO;
    [self.view bringSubviewToFront:_DVIew];
           [_pickerview setTag:1];

}
-(IBAction)TotextAction:(id)sender{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
           [dateFormat setDateFormat:@"YYYY/MM/dd"];
           NSDate *dte = [dateFormat dateFromString:startDate];
          // [_pickerview setMinimumDate:dte];
           _DVIew.hidden = NO;
    [self.view bringSubviewToFront:_DVIew];

           [_pickerview setTag:2];
}

- (NSString *)formatDate2:(NSDate *)date
{
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
      [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd"];
      NSString *formattedDate = [dateFormatter stringFromDate:date];
      return formattedDate;
}


- (NSString *)formatDate:(NSDate *)date
{
      NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
      [dateFormatter setDateFormat:@"dd MMM yyyy"];
      NSString *formattedDate = [dateFormatter stringFromDate:date];
      return formattedDate;
}



-(IBAction)getProducts:(id)sender{
    [self getStatements];

}



-(void)getStatements
{

    [self showLoading:true];

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul);
       dispatch_async(queue, ^{

           NSString *Url = [NSString stringWithFormat:@"%@%@?user_id=%@&from_date=%@&to_date=%@", BASEURL, STATEMENTS, @"38", self->startDate, self->endDate];
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
            
            
            if(status == 1) {
            
//
//            NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"history" ofType:@"html"];
//               NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
//
//
//           //    [_webView loadHTMLString:htmlString baseURL: [[NSBundle mainBundle] bundleURL]];
//
               
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
               WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
                 WKWebView *WkwebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
                 WkwebView.navigationDelegate = self;
               
                [WkwebView loadHTMLString:[responseDictionary objectForKey:@"data"] baseURL: [[NSBundle mainBundle] bundleURL]];
                 //NSURL *nsurl=[NSURL URLWithString:_pdfurl];
                 //NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
                // [webView loadRequest:nsrequest];
                 [self.wView addSubview:WkwebView];
            
            
            
            });
            
            
            
            
            
            
            
            
            }
            
            
            
            
            
            
            
//                            NSMutableArray *arrayAmount = [[NSMutableArray alloc] init];
//                            NSMutableArray *arrayDate = [[NSMutableArray alloc] init];
//                              NSMutableArray *arrayParticulars = [[NSMutableArray alloc] init];
//              NSMutableArray *arraytypes = [[NSMutableArray alloc] init];
//                              NSMutableArray *arrayType = [[NSMutableArray alloc] init];
//                              NSMutableArray *arrayNumber = [[NSMutableArray alloc] init];
//

//                   if(status == 1 ) {
//
//
//                       NSDictionary *data = [responseDictionary objectForKey:@"data"];
//                       for (NSDictionary *dat in data){
//
//                            [arrayAmount addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"amount"]]];
//
//                            [arrayDate addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"date"]]];
//
//                            [arrayParticulars addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"particulars"]]];
//                              [arraytypes addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"type"]]];
//                            [arrayType addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"vch_type"]]];
//
//                            [arrayNumber addObject:[NSString stringWithFormat:@"%@", [dat objectForKey:@"vouch_no"]]];
//
//
//                                              }
//
//
//
//                         dispatch_async(dispatch_get_main_queue(), ^{
//
////                             [self hidePageLoader];
////                             [self.collectionView reloadData];
//
//
//                         });
//
//
//
//                }else {
//
//                    NSString *msg = [responseDictionary objectForKey:@"message"];
//                    [self salert:@"Alert" second:msg];
//
//                }
//
//            self.AmountArray = arrayAmount;
//                self.DateArray = arrayDate;
//                      self.ParticularsArray = arrayParticulars;
//                      self.TypesArray = arraytypes;
//                      self.TypeArray = arrayType;
//                      self.NoArray = arrayNumber;
//
//
//        }else {
//
//
//            NSLog(@"%@",@"ERROR");
//
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




- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
  if (!navigationAction.targetFrame.isMainFrame) {
    [webView loadRequest:navigationAction.request];
  }

  return nil;
}



- (IBAction)back:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
