//
//  SlideOutVC.h
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/31/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideOutVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

{
    IBOutlet UITableView *slideOutTableView;
    IBOutlet UILabel *schoolLabel;
    BOOL areAdsRemoved;
}

@property (strong, nonatomic) NSString *campusLocation;


@end
