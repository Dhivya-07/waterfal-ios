

#import "SplashViewController.h"
#import "MainHomeViewController.h"

@interface SplashViewController () {
    
    
    NSString * user_id;
    
    
}

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
}




- (void)viewWillAppear:(BOOL)animated {
    
    
    [NSTimer scheduledTimerWithTimeInterval: 2.0
      target: self
    selector:@selector(onTick:)
    userInfo: nil repeats:NO];
    
    
    
}


   


-(void)onTick:(NSTimer *)timer {
    
 MainHomeViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"mainHome"];
                 [self presentViewController:go animated:true completion:nil];
          

    
}


@end
