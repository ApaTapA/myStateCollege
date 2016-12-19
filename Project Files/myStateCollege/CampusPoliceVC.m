//
//  CampusPoliceVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/23/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "CampusPoliceVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"
#import "LocationsVC.h"

@interface CampusPoliceVC ()

@end

@implementation CampusPoliceVC

- (void)viewDidAppear:(BOOL)animated
{
    if (!areAdsRemoved) {
        if (bannerView == nil) {
            
            bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize autoOrigin:STAAdOrigin_Bottom
                                                    withView:self.view withDelegate:nil];
            [self.view addSubview:bannerView];
        }
    }
    
    else if (areAdsRemoved) {
        //        [self doRemoveAds];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    areAdsRemoved = [[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UINavigationBar *campusPoliceNavBar = [self.navigationController navigationBar];
    [campusPoliceNavBar setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]];
    [campusPoliceNavBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:18]}];
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.openSlideOut setTarget: self.revealViewController];
        [self.openSlideOut setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self showCampusPoliceButtons];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showCampusPoliceButtons
{
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusPolice" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        CampusPoliceVC *universityParkCampusPolice = [buttonsArray objectAtIndex:i];
        
        UIButton *upCampusPoliceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upCampusPoliceButton setImage:[UIImage imageNamed:universityParkCampusPolice] forState:UIControlStateNormal];
        upCampusPoliceButton.frame = CGRectMake(10, positionX, 355, 55);
        [upCampusPoliceButton setTag:i];
        [upCampusPoliceButton addTarget:self action:@selector(openCampusPoliceLinks:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.campusPoliceScroll addSubview:upCampusPoliceButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                upCampusPoliceButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                upCampusPoliceButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                upCampusPoliceButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                upCampusPoliceButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.campusPoliceScroll addSubview:upCampusPoliceButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED

            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_campusPoliceScroll setContentSize:CGSizeMake(320, positionX + 10)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_campusPoliceScroll setContentSize:CGSizeMake(320, positionX + 175)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_campusPoliceScroll setContentSize:CGSizeMake(320, positionX + 265)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_campusPoliceScroll setContentSize:CGSizeMake(320, positionX + 0)];
                }
                
            }
            
        }
        else {
            //ADS ARE NOT REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_campusPoliceScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_campusPoliceScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_campusPoliceScroll setContentSize:CGSizeMake(320, positionX + 310)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_campusPoliceScroll setContentSize:CGSizeMake(375, positionX + 55)];
                }
            }
        }
        
    }
}

-(void)openCampusPoliceLinks:(id)sender
{
    UIButton *button=sender;
    
    if (button.tag ==0) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148631111"]];
    }
    else if (button.tag == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148651864"]];
    }
    else if (button.tag ==3) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==4) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==5) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==6) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebView *webView = [segue destinationViewController];
    LocationsVC *locations = [segue destinationViewController];
    
    UIButton *button = sender;

    if (button.tag == 0) {
        webView.loadUrl = @"http://www.police.psu.edu/up-police/";
        webView.categoryType = @"campusPolice";
    }
    else if (button.tag == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148658164"]];
    }
    else if (button.tag == 3) {
        webView.loadUrl = @"http://www.police.psu.edu/psu-police/report-crime.cfm";
        webView.categoryType = @"campusPolice";
    }
    else if (button.tag == 4) {
        webView.loadUrl = @"http://www.police.psu.edu/up-police/services/index.cfm";
        webView.categoryType = @"campusPolice";
    }
    else if (button.tag == 5) {
        webView.loadUrl = @"http://www.police.psu.edu/up-police/safety/emergency-telephones.cfm";
        webView.categoryType = @"campusPolice";
    }
    else if (button.tag == 6) {
        webView.loadUrl = @"http://m.psu.edu/emergency/";
        webView.categoryType = @"campusPolice";
    }
    else if (button.tag == 7) {
        locations.categoryType = @"campusPolice";
    }
}

@end
