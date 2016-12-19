//
//  ParkingTransportationVC.h
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/23/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "ViewController.h"
#import <StartApp/StartApp.h>

@interface ParkingTransportationVC : UIViewController <UIAlertViewDelegate>
{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
}

@property (nonatomic, weak) IBOutlet UIBarButtonItem *openSlideOut;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *openLocationMenu;

@property (nonatomic, weak) IBOutlet UIView *trackScheduleView;

@property (nonatomic, weak) IBOutlet UILabel *routeLetterLabel;
@property (nonatomic, weak) IBOutlet UILabel *routeNameLabel;

@property (nonatomic, weak) IBOutlet UIButton *btnSchedule;
@property (nonatomic, weak) IBOutlet UIButton *btnTrack;
@property (nonatomic, weak) IBOutlet UIButton *btnClose;

@property (nonatomic, weak) IBOutlet UIScrollView *parkingTransportationScroll;

@property (strong, nonatomic) NSString *campusLocation;
@property (strong, nonatomic) NSString *busRoute;


-(IBAction)closeTrackScheduleView:(id)sender;

@end
