//
//  CampusDiningVC.h
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/22/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "ViewController.h"
#import <StartApp/StartApp.h>

@interface CampusDiningVC : UIViewController
{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
}

@property (strong, nonatomic) NSString *campusLocation;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *openSlideOut;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *openLocationMenu;

@property (nonatomic, weak) IBOutlet UIScrollView *campusDiningScroll;

@end
