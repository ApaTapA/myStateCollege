//
//  LinksWebView.h
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/31/15.
//  Copyright (c) 2015 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import <StartApp/StartApp.h>

@interface LinksWebView : UIViewController <UIWebViewDelegate,UIAlertViewDelegate,ADBannerViewDelegate,UIScrollViewDelegate>

{
    BOOL bannerIsVisible;
    STABannerView *bannerView;
    BOOL *areAdsRemoved;
    
    IBOutlet UIWebView *webview;
    IBOutlet UINavigationBar *webviewNavBar;
    
    IBOutlet UIView *webViewLoadIndicator;
    IBOutlet UIImageView *logoImage;
    
    IBOutlet UIButton *logoImageButton;
    
    IBOutlet UIBarButtonItem *goToReveal;
    IBOutlet UIBarButtonItem *btnBack;
    IBOutlet UIBarButtonItem *btnForward;
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property(nonatomic, readwrite, assign) BOOL hidesBarsOnSwipe;



@property (weak, nonatomic) IBOutlet UIView *activityIndicatorView;
@property (strong, nonatomic) NSString *loadUrl;
@property (strong, nonatomic) NSString *categoryType;

-(IBAction)goHomePage:(id)sender;




@end
