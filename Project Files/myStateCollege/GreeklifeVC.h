//
//  GreeklifeVC.h
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/23/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "ViewController.h"
#import <StartApp/StartApp.h>

@interface GreeklifeVC : UIViewController
{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
}

@property (nonatomic, weak) IBOutlet UIBarButtonItem *openSlideOut;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *openLocationMenu;

@property (nonatomic, weak) IBOutlet UIScrollView *greeklifeScroll;

@property (strong, nonatomic) NSString *campusLocation;

@end
