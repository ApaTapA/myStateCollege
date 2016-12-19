//
//  HelpVC.h
//  myStateCollege
//
//  Created by Thomas Diffendal on 8/2/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StartApp/StartApp.h>

@interface HelpVC : UIViewController

{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
    
    IBOutlet UIImageView *menuImage;
    IBOutlet UIImageView *locationImage;
    IBOutlet UIImageView *buttonImage;
    IBOutlet UIImageView *refreshImage;
    IBOutlet UIImageView *backImage;
    IBOutlet UIImageView *myPSUImage;
    IBOutlet UIImageView *forwardImage;
    IBOutlet UIImageView *closeImage;
    
    IBOutlet UILabel *openMenuLabel;
    IBOutlet UILabel *chooseCampusLabel;
    IBOutlet UILabel *goToPageLabel;
    IBOutlet UILabel *refreshLabel;
    IBOutlet UILabel *backLabel;
    IBOutlet UILabel *goHomeLabel;
    IBOutlet UILabel *forwardLabel;
    IBOutlet UILabel *closeLabel;


    
}

@property (nonatomic, weak) IBOutlet UIBarButtonItem *openSlideOut;

@end
