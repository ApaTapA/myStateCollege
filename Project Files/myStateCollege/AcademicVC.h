//
//  AcademicVC.h
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/20/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StartApp/StartApp.h>

@interface AcademicVC : UIViewController
{
    BOOL areAdsRemoved;
    BOOL bannerIsVisible;
    STABannerView *bannerView;
}

@property (strong, nonatomic) NSString *campusLocation;

@property (nonatomic, weak) IBOutlet UIBarButtonItem *openSlideOut;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *openLocationMenu;

@property (nonatomic, weak) IBOutlet UIScrollView *academicScroll;

@property (nonatomic, weak) IBOutlet UIView *contentView;

@end
