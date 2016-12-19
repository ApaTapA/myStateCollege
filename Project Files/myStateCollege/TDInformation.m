//
//  TDInformation.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 8/2/15.
//  Copyright (c) 2015 ApaTapA. All rights reserved.
//

#import "TDInformation.h"
#import "SWRevealViewController.h"

@interface TDInformation ()

@end

@implementation TDInformation

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewDidLoad {
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
        if ((int) [[UIScreen mainScreen] bounds].size.height == 667)
        {
//            if (areAdsRemoved)
//            {
//                [lblVersion setFrame:CGRectMake(120, 620, 135, 27)];
//            }
        }
        
        else if ((int) [[UIScreen mainScreen] bounds].size.height == 736)
        {
            //IPHONE 6 PLUS
            [lblTitle setFrame:CGRectMake(51, 72, 313, 50)];
            [lblDevelop setFrame:CGRectMake(117, 109, 180, 21)];
            [lblProgram setFrame:CGRectMake(120, 156, 164, 39)];
            [lblThomas setFrame:CGRectMake(120, 188, 164, 23)];
            [lblGraphics setFrame:CGRectMake(120, 246, 164, 39)];
            [lblScott setFrame:CGRectMake(120, 275, 164, 23)];
            [lblDisclaimer setFrame:CGRectMake(135, 333, 135, 50)];
            [lblDisclaimerText setFrame:CGRectMake(86, 376, 233, 69)];
            [lblVersion setFrame:CGRectMake(140, 637, 135, 23)];
        }
        
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c
            [lblTitle setFrame:CGRectMake(4, 72, 313, 50)];
            [lblDevelop setFrame:CGRectMake(71, 110, 180, 21)];
            [lblProgram setFrame:CGRectMake(79, 150, 164, 39)];
            [lblThomas setFrame:CGRectMake(78, 186, 164, 23)];
            [lblGraphics setFrame:CGRectMake(79, 228, 164, 39)];
            [lblScott setFrame:CGRectMake(79, 267, 164, 23)];
            [lblDisclaimer setFrame:CGRectMake(93, 314, 135, 50)];
            [lblDisclaimerText setFrame:CGRectMake(44, 364, 233, 69)];
            [lblVersion setFrame:CGRectMake(93, 491, 135, 24)];
        
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            //IPHONE 4s
            [lblTitle setFrame:CGRectMake(4, 71, 313, 50)];
            [lblDevelop setFrame:CGRectMake(71, 110, 180, 21)];
            [lblProgram setFrame:CGRectMake(79, 140, 164, 39)];
            [lblThomas setFrame:CGRectMake(79, 170, 164, 23)];
            [lblGraphics setFrame:CGRectMake(79, 201, 164, 39)];
            [lblScott setFrame:CGRectMake(79, 237, 164, 23)];
            [lblDisclaimer setFrame:CGRectMake(93, 268, 135, 50)];
            [lblDisclaimerText setFrame:CGRectMake(45, 308, 233, 69)];
            [lblVersion setFrame:CGRectMake(93, 405, 135, 24)];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"]) {
        if (bannerView == nil) {
            bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize autoOrigin:STAAdOrigin_Bottom
                                                    withView:self.view withDelegate:nil];
            [self.view addSubview:bannerView];        }
        
    }
    else {
        [self doRemoveAds];
    }
}

-(void)doRemoveAds
{
    bannerView.hidden = YES;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int) [[UIScreen mainScreen] bounds].size.height == 667)
        {
           [lblVersion setFrame:CGRectMake(120, 620, 135, 27)];
        }
        
    else if ((int) [[UIScreen mainScreen] bounds].size.height == 736)
        {
            [lblVersion setFrame:CGRectMake(139, 693, 135, 23)];
        }

    else if ((int) [[UIScreen mainScreen] bounds].size.height == 568)
        {
            [lblVersion setFrame:CGRectMake(93, 530, 135, 25)];
        }
        
    else if ((int) [[UIScreen mainScreen] bounds].size.height == 480)
        {
            [lblVersion setFrame:CGRectMake(93, 448, 135, 25)];
        }
    }
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
