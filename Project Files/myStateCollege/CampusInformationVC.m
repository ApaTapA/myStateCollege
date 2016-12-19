//
//  CampusInformationVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/23/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "CampusInformationVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"
#import "LocationsVC.h"


@interface CampusInformationVC ()

@end

@implementation CampusInformationVC

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    areAdsRemoved = [[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    UINavigationBar *campusInformationNavBar = [self.navigationController navigationBar];
    [campusInformationNavBar setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]];
    [campusInformationNavBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:18]}];
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.openSlideOut setTarget: self.revealViewController];
        [self.openSlideOut setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self showCampusInformationButtons];
}

-(void)showCampusInformationButtons
{

    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusInformation" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        CampusInformationVC *universityParkCampusInformationButtons = [buttonsArray objectAtIndex:i];
        
        UIButton *upCampusInformationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upCampusInformationButton setImage:[UIImage imageNamed:universityParkCampusInformationButtons] forState:UIControlStateNormal];
        upCampusInformationButton.frame = CGRectMake(10, positionX, 355, 55);
        [upCampusInformationButton setTag:i];
        [upCampusInformationButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.campusInformationScroll addSubview:upCampusInformationButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                upCampusInformationButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                upCampusInformationButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                upCampusInformationButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                upCampusInformationButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.campusInformationScroll addSubview:upCampusInformationButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
          
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_campusInformationScroll setContentSize:CGSizeMake(320, positionX + 10)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_campusInformationScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_campusInformationScroll setContentSize:CGSizeMake(320, positionX + 265)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_campusInformationScroll setContentSize:CGSizeMake(320, positionX + 0)];
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
                    [_campusInformationScroll setContentSize:CGSizeMake(320, positionX + 55)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_campusInformationScroll setContentSize:CGSizeMake(320, positionX + 225)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_campusInformationScroll setContentSize:CGSizeMake(320, positionX + 310)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_campusInformationScroll setContentSize:CGSizeMake(375, positionX + 55)];
                }
            }
        }
        
    }
}

-(void)openLinks:(id)sender
{
    UIButton *button=sender;
    
    if (button.tag ==0) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==1) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==2) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
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
    else if (button.tag ==7) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebView *webView = [segue destinationViewController];
    LocationsVC *locations = [segue destinationViewController];
    
    UIButton *button = sender;
    
    if (button.tag == 0) {
        webView.loadUrl = @"http://www.psu.edu/";
        webView.categoryType = @"campusInformation";
    }
    else if (button.tag == 1) {
        webView.loadUrl = @"http://www.map.psu.edu/";
        webView.categoryType = @"campusInformation";
    }
    else if (button.tag == 2) {
        webView.loadUrl = @"http://studentaffairs.psu.edu/hub/studentorgs/orgdirectory/";
        webView.categoryType = @"campusInformation";
    }
    else if (button.tag == 3) {
        webView.loadUrl = @"http://rescom.psu.edu/contact-us";
        webView.categoryType = @"campusInformation";
    }
    else if (button.tag == 4) {
        webView.loadUrl = @"http://psu.bncollege.com/webapp/wcs/stores/servlet/BNCBHomePage?catalogId=10001&storeId=18555&langId=-1";
        webView.categoryType = @"campusInformation";
    }
    else if (button.tag == 5) {
        webView.loadUrl = @"http://www.housing.psu.edu/housing/housing/residence-areas/index.cfm";
        webView.categoryType = @"campusInformation";
    }
    else if (button.tag == 6) {
        webView.loadUrl = @"http://www.housing.psu.edu/housing/housing/channel-list.cfm";
        webView.categoryType = @"campusInformation";
    }
    else if (button.tag == 7) {
        webView.loadUrl = @"http://www.housing.psu.edu/housing/housing/commons.cfm";
        webView.categoryType = @"campusInformation";
    }
    else if (button.tag == 8) {
        locations.categoryType = @"campusInformation";
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
