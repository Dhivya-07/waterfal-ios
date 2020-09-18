//
//  webviewViewController.h
//  Waterfal
//
//  Created by MAC on 14/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface webviewViewController : UIViewController<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewloaded;

@property (nonatomic, assign) NSString *urlLink;

@property (weak, nonatomic) IBOutlet UIWebView *webviewloaded;

-(IBAction)backbuttonAction:(id)sender;
-(IBAction)downloadAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
