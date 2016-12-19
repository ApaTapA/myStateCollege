//
//  MainMenu.h
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/28/15.
//  Copyright (c) 2015 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <StartApp/StartApp.h>

@interface MainMenu : UIViewController <ADBannerViewDelegate>

{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
    
    
    IBOutlet UIImageView *academicIcon;
    IBOutlet UIImageView *diningIcon;
    IBOutlet UIImageView *newsIcon;
    IBOutlet UIImageView *policeIcon;
    IBOutlet UIImageView *greeklifeIcon;
    IBOutlet UIImageView *nightlifeIcon;
    IBOutlet UIImageView *parkingIcon;
    IBOutlet UIImageView *sportsIcon;
    IBOutlet UIImageView *informationIcon;
    IBOutlet UIImageView *studentHealthIcon;
    
    IBOutlet UIImageView *firstTimeMessage;
    
    IBOutlet UIButton *btnInformation;
    IBOutlet UIButton *btnFeedback;
    IBOutlet UIButton *btnRemoveAdsSetting;
    IBOutlet UIButton *btnRestorePurchases;
    
    IBOutlet UIButton *btnCloseDropdown;

    IBOutlet UIView *iapLoading;
    IBOutlet UIActivityIndicatorView *iap;
    
    IBOutlet UIImageView *divider1;
    IBOutlet UIImageView *divider2;
    IBOutlet UIImageView *divider3;
    
    IBOutlet UILabel *schoolLabel;
    IBOutlet UIButton *btnSettings;
    IBOutlet UIButton *btnCloseSettings;
    
    
    IBOutlet UIImageView *mainMenuBackground;
}

@property (strong, nonatomic) IBOutlet UIScrollView *mainMenuScroll;

@property (strong, nonatomic) IBOutlet UIButton *btnSelectCategory;

@property (strong, nonatomic) NSString *loadUrl;

@property (weak, nonatomic) IBOutlet UIView *settingsView;

@property (strong, nonatomic) IBOutlet UIImageView *categoryIcon;

//Category Buttons
@property (strong, nonatomic) IBOutlet UIButton *btnAcademic;
@property (strong, nonatomic) IBOutlet UIButton *btnCampusDining;
@property (strong, nonatomic) IBOutlet UIButton *btnCampusInformation;
@property (strong, nonatomic) IBOutlet UIButton *btnCampusNewsAndEvents;
@property (strong, nonatomic) IBOutlet UIButton *btnCampusPolice;
@property (strong, nonatomic) IBOutlet UIButton *btnGreekLife;
@property (strong, nonatomic) IBOutlet UIButton *btnNightlife;
@property (strong, nonatomic) IBOutlet UIButton *btnParkingAndTransportation;
@property (strong, nonatomic) IBOutlet UIButton *btnSportsAndFitness;
@property (strong, nonatomic) IBOutlet UIButton *btnStudentHealth;

@property (strong, nonatomic) IBOutlet UIButton *btnRemoveAds;
@property (strong, nonatomic) IBOutlet UIButton *btnRestorePurchase;



@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;

@property (strong, nonatomic) IBOutlet UIView *categoryView;

//In-App Purchases


- (IBAction)purchase;
- (IBAction)restore;
- (IBAction)tapsRemoveAds;


//Actions
- (IBAction)selectCategory:(id)sender;
- (IBAction)selectSettings:(id)sender;
- (IBAction)categoryAcademic:(id)sender;
- (IBAction)categoryCampusDining:(id)sender;
- (IBAction)campusNewsAndEvents:(id)sender;
- (IBAction)campusPolice:(id)sender;
- (IBAction)categoryParkingAndTransportation:(id)sender;
- (IBAction)categoryNightlife:(id)sender;
- (IBAction)categorySportsAndFitness:(id)sender;
- (IBAction)categoryStudentHealth:(id)sender;
- (IBAction)categoryGreeklife:(id)sender;
- (IBAction)settingInformation:(id)sender;
- (IBAction)settingFeedback:(id)sender;


@end
