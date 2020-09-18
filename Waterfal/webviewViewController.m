//
//  webviewViewController.m
//  Waterfal
//
//  Created by MAC on 14/09/20.
//  Copyright © 2020 Panamon Technologies. All rights reserved.
//

#import "webviewViewController.h"
#import <WebKit/WebKit.h>
#import "UIViewController+EQViewController.h"
@interface webviewViewController ()<WKNavigationDelegate>{
    NSString * url_Link;
}

@end

@implementation webviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    url_Link = self.urlLink;
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];

    NSURL *nsurl=[NSURL URLWithString:url_Link];

    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];

    [webView loadRequest:nsrequest];

    [self.viewloaded  addSubview:webView];
    webView.navigationDelegate = self;

//    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:[
//        NSURL URLWithString:@"https://digidoc.co.in//web_api//includes//uploads//15992428822714.pdf"]];
//
//    // Store the Data locally as PDF File
//    NSString *resourceDocPath = [[NSString alloc] initWithString:[
//        [[[NSBundle mainBundle] resourcePath] stringByDeletingLastPathComponent]
//            stringByAppendingPathComponent:@"Documents"
//    ]];
//
//    NSString *filePath = [resourceDocPath
//        stringByAppendingPathComponent:@"myPDF.pdf"];
//    [pdfData writeToFile:filePath atomically:YES];
//
//
//    // Now create Request for the file that was saved in your documents folder
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//
//    [_webviewloaded setUserInteractionEnabled:YES];
//    [_webviewloaded setDelegate:self];
//    [_webviewloaded loadRequest:requestObj];
    
    

    // the URL to save
//    NSURL *yourURL = [NSURL URLWithString:url_Link];
//    // turn it into a request and use NSData to load its content
//    NSURLRequest *request = [NSURLRequest requestWithURL:yourURL];
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//
//    // find Documents directory and append your local filename
//    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//    documentsURL = [documentsURL URLByAppendingPathComponent:@"localFile.pdf"];
//
//    // and finally save the file
//    [data writeToURL:documentsURL atomically:YES];
//    NSLog(@"%@",data);
//
//    // list contents of Documents Directory just to check
//   //NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//
//    NSArray *contents = [[NSFileManager defaultManager]contentsOfDirectoryAtURL:documentsURL includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
//
//    NSLog(@"%@", [contents description]);
//
}


-(void)webView:(WKWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self showLoading:false];
}


-(void)webViewDidFinishLoad:(WKWebView *)webView
{
    [self showLoading:false];
}


-(IBAction)downloadAction:(id)sender{
    
    
        NSURL *yourURL = [NSURL URLWithString:url_Link];
        // turn it into a request and use NSData to load its content
        NSURLRequest *request = [NSURLRequest requestWithURL:yourURL];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
        // find Documents directory and append your local filename
        NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        documentsURL = [documentsURL URLByAppendingPathComponent:@"localFile.pdf"];
    
        // and finally save the file
        [data writeToURL:documentsURL atomically:YES];
        NSLog(@"%@",data);
    
        // list contents of Documents Directory just to check
       //NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
        NSArray *contents = [[NSFileManager defaultManager]contentsOfDirectoryAtURL:documentsURL includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    
        NSLog(@"%@", [contents description]);
    
}

-(IBAction)backbuttonAction:(id)sender{
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
