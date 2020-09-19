

#import "MainHomeViewController.h"
#import "LoginRegisterViewController.h"
#import "CustomerHomeViewController.h"
#import "DealerDashboardViewController.h"
#import "Reg1ViewController.h"
#import "ProfileViewController.h"
#import "CustomerViewController.h"
@interface MainHomeViewController () {
    
    NSString * user_id;
}

@end

@implementation MainHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}




- (IBAction)dealerBtn:(id)sender {
    
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

       NSObject * object = [prefs objectForKey:@"user_id"];
       
       
       
//       if(object != nil){
//          //object is there
//
//
//       }
//
    if ([object  isEqual: @""]){
           
           
            LoginRegisterViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"loginRegisterView"];
                        [self presentViewController:go animated:true completion:nil];
               
           
       } else{

           UITabBarController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"homeView"];
           [self presentViewController:go animated:true completion:nil];
       }

    
}

-(int)getRandomNumberBetween:(int)from and:(int)to {

    return (int)from + arc4random() % (to-from+1);
}

- (IBAction)customerBtn:(id)sender {
     
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

       NSObject * object = [prefs objectForKey:@"user_id"];
    
    if ([object isEqual:@""]){
        int randomNumber = [self getRandomNumberBetween:9 and:99];
        NSNumber *randomNo = [NSNumber numberWithInt: randomNumber];

        NSLog(@"%did",randomNumber);
        [[NSUserDefaults standardUserDefaults] setObject: randomNo forKey:@"user_id"]; //save NSNumber instance not the int
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
       
    
    CustomerViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomerViewController"];
              [self presentViewController:go animated:true completion:nil];
    
}
@end
