//
//  LinksWebView.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/31/15.
//  Copyright (c) 2015 ApaTapA. All rights reserved.
//

#import "LinksWebView.h"
#import "SWRevealViewController.h"
#import "CampusDiningVC.h"

@interface LinksWebView ()

@end

@implementation LinksWebView

@synthesize categoryType;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    webview.scrollView.bounces = NO;
        
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c
            [webviewNavBar setFrame:CGRectMake(0, 0, 320, 60)];
            [logoImage setFrame:CGRectMake(123, 20, 74, 32)];
            [logoImageButton setFrame:CGRectMake(123, 25, 74, 32)];
            [webview setFrame:CGRectMake(0, 60, 320, 458)];
            [_activityIndicatorView setFrame:CGRectMake(135, 209, 50, 50)];
            btnBack.imageInsets = UIEdgeInsetsMake(0, -50, 0, 0);
            btnForward.imageInsets = UIEdgeInsetsMake(0, 0, 0, -50);

            
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            //IPHONE 4s
            [webview setFrame:CGRectMake(0, 60, 320, 370)];
            [_activityIndicatorView setFrame:CGRectMake(135, 195, 50, 50)];
            [logoImage setFrame:CGRectMake(123, 21, 74, 32)];
            
            //IPHONE 6 PLUS
            [webviewNavBar setFrame:CGRectMake(0, 0, 414, 60)];
            [logoImage setFrame:CGRectMake(159, 15, 96, 41)];
            [logoImageButton setFrame:CGRectMake(163, 15, 88, 41)];
            [webview setFrame:CGRectMake(0, 60, 414, 626)];
            [_activityIndicatorView setFrame:CGRectMake(182, 323, 50, 50)];

        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
        {
            [webview setFrame:CGRectMake(0, 60, 375, 557)];
            [_activityIndicatorView setFrame:CGRectMake(162, 259, 50, 50)];

        }
    }

    self.activityIndicatorView.layer.cornerRadius = 5;
    
    //Set the Webview Delegate to "SELF"
    webview.delegate = self;
    
    webview.scalesPageToFit = YES;
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    webView.scrollView.scrollEnabled = NO;
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *javaScript = @"function myFunction(){return 1+1;}";
    [webView stringByEvaluatingJavaScriptFromString:javaScript];
    
    self.activityIndicatorView.hidden = YES;
    [self.activityIndicator stopAnimating];
    webView.scrollView.scrollEnabled = YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.activityIndicatorView.hidden = YES;
    [self.activityIndicator stopAnimating];
    
    if ([error code] == NSURLErrorCancelled) return; {
    
    UIAlertView *webViewFailAlert = [[UIAlertView alloc] initWithTitle:@"Failed to Load" message:@"Please check internet connection" delegate:self cancelButtonTitle:@"Go Back" otherButtonTitles:@"Try Again", nil];
    [webViewFailAlert setTag:1];
    
    [webViewFailAlert show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ((alertView.tag =1)) {
        if (buttonIndex == 0){
            NSString * storyboardName = @"Main";
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"academic"];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"]) {
        if (bannerView == nil) {
            bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize autoOrigin:STAAdOrigin_Bottom
                                                    withView:self.view withDelegate:nil];
            NSLog(@"NOT");
            [self.view addSubview:bannerView];
        }


    }
    else {
        [self doRemoveAds];
    }
        
    //URL Request Object
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:_loadUrl]];
    
    //Load the Request in the UIWebview
    [webview loadRequest:requestUrl];
    
}

-(IBAction)goHomePage:(id)sender
{
    //URL Request Object
    NSURLRequest *requestUrl = [NSURLRequest requestWithURL:[NSURL URLWithString:_loadUrl]];
    
    //Load the Request in the UIWebview
    [webview loadRequest:requestUrl];
 
}

-(void)doRemoveAds
{
    bannerView.hidden = YES;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c
            [webview setFrame:CGRectMake(0, 60, 320, 508)];
            [_activityIndicatorView setFrame:CGRectMake(135, 259, 50, 50)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
        {
            //IPHONE 6
            [webview setFrame:CGRectMake(0, 60, 375, 607)];
            [_activityIndicatorView setFrame:CGRectMake(162, 309, 50, 50)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            //IPHONE 4s
            [webview setFrame:CGRectMake(0, 60, 320, 436)];
            [_activityIndicatorView setFrame:CGRectMake(135, 245, 50, 50)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
        {
            //IPHONE 6/6s Plus
            [webview setFrame:CGRectMake(0, 60, 414, 676)];
            [_activityIndicatorView setFrame:CGRectMake(182, 323, 50, 50)];
        }

    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([categoryType  isEqual: @"campusDining"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"campusDining"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
        NSLog(@"CampusDining");
    }
    else if ([categoryType  isEqual: @"campusInformation"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"campusInformation"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([categoryType  isEqual: @"newsEvents"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"newsEvents"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([categoryType  isEqual: @"campusPolice"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"campusPolice"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([categoryType  isEqual: @"greeklife"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"greeklife"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([categoryType  isEqual: @"nightlife"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"nightlife"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([categoryType  isEqual: @"parkingTransportation"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"parkingTransportation"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([categoryType  isEqual: @"sportsFitness"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"sportsFitness"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([categoryType  isEqual: @"studentHealth"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"studentHealth"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end