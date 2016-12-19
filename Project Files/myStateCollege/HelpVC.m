//
//  HelpVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 8/2/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "HelpVC.h"
#import "SWRevealViewController.h"

@interface HelpVC ()

@end

@implementation HelpVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"]) {
        if (bannerView == nil) {
            
            bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize autoOrigin:STAAdOrigin_Bottom
                                                    withView:self.view withDelegate:nil];
            [self.view addSubview:bannerView];
        }
        
    }
    else {
        [self doRemoveAds];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationBar *academicNavBar = [self.navigationController navigationBar];
    [academicNavBar setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]];
    [academicNavBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:18]}];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.openSlideOut setTarget: self.revealViewController];
        [self.openSlideOut setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
        {
            //IPHONE 6/6s Plus
            [menuImage setFrame:CGRectMake(25, 75, 40, 40)];
            [openMenuLabel setFrame:CGRectMake(100, 86, 102, 21)];
            [locationImage setFrame:CGRectMake(20, 135, 45, 45)];
            [chooseCampusLabel setFrame:CGRectMake(100, 147, 148, 21)];
            [buttonImage setFrame:CGRectMake(20, 200, 190, 40)];
            [goToPageLabel setFrame:CGRectMake(224, 210, 144, 21)];
            [refreshImage setFrame:CGRectMake(15, 255, 60, 60)];
            [refreshLabel setFrame:CGRectMake(100, 274, 148, 21)];
            [backImage setFrame:CGRectMake(18, 320, 60, 60)];
            [backLabel setFrame:CGRectMake(100, 339, 159, 21)];
            [myPSUImage setFrame:CGRectMake(8, 395, 70, 41)];
            [goHomeLabel setFrame:CGRectMake(100, 405, 124, 21)];
            [forwardImage setFrame:CGRectMake(15, 450, 60, 60)];
            [forwardLabel setFrame:CGRectMake(100, 469, 181, 21)];
            [closeImage setFrame:CGRectMake(15, 515, 60, 60)];
            [closeLabel setFrame:CGRectMake(100, 534, 46, 21)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5c/5s
            [menuImage setFrame:CGRectMake(25, 75, 30, 30)];
            [openMenuLabel setFrame:CGRectMake(92, 84, 102, 21)];
            [locationImage setFrame:CGRectMake(23, 120, 35, 35)];
            [chooseCampusLabel setFrame:CGRectMake(92, 127, 148, 21)];
            [buttonImage setFrame:CGRectMake(20, 170, 170, 35)];
            [goToPageLabel setFrame:CGRectMake(204, 177, 110, 21)];
            [refreshImage setFrame:CGRectMake(15, 215, 50, 50)];
            [refreshLabel setFrame:CGRectMake(92, 229, 148, 21)];
            [backImage setFrame:CGRectMake(18, 270, 50, 50)];
            [backLabel setFrame:CGRectMake(92, 284, 159, 21)];
            [myPSUImage setFrame:CGRectMake(8, 335, 70, 41)];
            [goHomeLabel setFrame:CGRectMake(92, 345, 124, 21)];
            [forwardImage setFrame:CGRectMake(15, 391, 50, 50)];
            [forwardLabel setFrame:CGRectMake(92, 405, 181, 21)];
            [closeImage setFrame:CGRectMake(20, 449, 50, 50)];
            [closeLabel setFrame:CGRectMake(92, 463, 46, 21)];
            
            [openMenuLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [chooseCampusLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [goToPageLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [refreshLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [backLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [goHomeLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [forwardLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [closeLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            //IPHONE 4s
            [menuImage setFrame:CGRectMake(25, 75, 30, 30)];
            [openMenuLabel setFrame:CGRectMake(88, 79, 102, 21)];
            [locationImage setFrame:CGRectMake(23, 114, 35, 35)];
            [chooseCampusLabel setFrame:CGRectMake(88, 121, 148, 21)];
            [buttonImage setFrame:CGRectMake(20, 160, 170, 35)];
            [goToPageLabel setFrame:CGRectMake(204, 167, 110, 21)];
            [refreshImage setFrame:CGRectMake(15, 200, 50, 50)];
            [refreshLabel setFrame:CGRectMake(88, 215, 148, 21)];
            [backImage setFrame:CGRectMake(18, 243, 50, 50)];
            [backLabel setFrame:CGRectMake(88, 257, 159, 21)];
            [myPSUImage setFrame:CGRectMake(8, 297, 70, 41)];
            [goHomeLabel setFrame:CGRectMake(88, 304, 124, 21)];
            [forwardImage setFrame:CGRectMake(15, 341, 50, 50)];
            [forwardLabel setFrame:CGRectMake(88, 356, 181, 21)];
            [closeImage setFrame:CGRectMake(20, 383, 50, 50)];
            [closeLabel setFrame:CGRectMake(88, 398, 46, 21)];
            
            [openMenuLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [chooseCampusLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [goToPageLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [refreshLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [backLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [goHomeLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [forwardLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [closeLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
        }
    }
}

-(void)doRemoveAds
{
    bannerView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
