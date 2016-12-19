//
//  TDInformation.h
//  myStateCollege
//
//  Created by Thomas Diffendal on 8/2/15.
//  Copyright (c) 2015 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StartApp/StartApp.h>

@interface TDInformation : UIViewController
{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
    
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblDevelop;
    IBOutlet UILabel *lblProgram;
    IBOutlet UILabel *lblThomas;
    IBOutlet UILabel *lblGraphics;
    IBOutlet UILabel *lblScott;
    IBOutlet UILabel *lblDisclaimer;
    IBOutlet UILabel *lblDisclaimerText;
    IBOutlet UILabel *lblVersion;
}

@property (nonatomic, weak) IBOutlet UIBarButtonItem *openSlideOut;


@end
