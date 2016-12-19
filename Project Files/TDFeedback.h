//
//  TDFeedback.h
//  myStateCollege
//
//  Created by Thomas Diffendal on 8/2/15.
//  Copyright (c) 2015 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <iAd/iAd.h>
#import <StartApp/StartApp.h>

@interface TDFeedback : UIViewController <MFMailComposeViewControllerDelegate , UIAlertViewDelegate, ADBannerViewDelegate>
{
    
    BOOL bannerIsVisible;
    STABannerView *bannerView;
    BOOL areAdsRemoved;
    
    IBOutlet UIButton *btnComments;
    IBOutlet UIButton *btnShare;
    IBOutlet UIButton *btnRate;
    IBOutlet UIButton *btnFollow;
    IBOutlet UIButton *btnFacebook;
    IBOutlet UIButton *btnInstagram;
    IBOutlet UIButton *btnWebsite;
    
    
    
}

@property (nonatomic, weak) IBOutlet UIBarButtonItem *openSlideOut;

- (IBAction)shareMYPSU:(id)sender;
- (IBAction)rateMYPSU:(id)sender;
- (IBAction)followTwitter:(id)sender;
- (IBAction)likeFacebook:(id)sender;
- (IBAction)followInstagram:(id)sender;
- (IBAction)openWebsite:(id)sender;



@end
