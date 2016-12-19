//
//  SportsFitnessVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/23/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "SportsFitnessVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"
#import "LocationsVC.h"

@interface SportsFitnessVC ()

@end

@implementation SportsFitnessVC

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
    
    UINavigationBar *sportsFitnessNavBar = [self.navigationController navigationBar];
    [sportsFitnessNavBar setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]];
    [sportsFitnessNavBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:18]}];
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.openSlideOut setTarget: self.revealViewController];
        [self.openSlideOut setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self showSportsAndFitnessButtons];
}

-(void)showSportsAndFitnessButtons
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SportsAndFitness" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        SportsFitnessVC *universityParkSportsAndFitness = [buttonsArray objectAtIndex:i];
        
        UIButton *upSportsFitnessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upSportsFitnessButton setImage:[UIImage imageNamed:universityParkSportsAndFitness] forState:UIControlStateNormal];
        upSportsFitnessButton.frame = CGRectMake(10, positionX, 355, 55);
        [upSportsFitnessButton setTag:i];
        [upSportsFitnessButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.sportsFitnessScroll addSubview:upSportsFitnessButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                upSportsFitnessButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                upSportsFitnessButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                upSportsFitnessButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                upSportsFitnessButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.sportsFitnessScroll addSubview:upSportsFitnessButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED

            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_sportsFitnessScroll setContentSize:CGSizeMake(320, positionX + 10)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_sportsFitnessScroll setContentSize:CGSizeMake(320, positionX + 175)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_sportsFitnessScroll setContentSize:CGSizeMake(320, positionX + 265)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_sportsFitnessScroll setContentSize:CGSizeMake(320, positionX + 0)];
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
                    [_sportsFitnessScroll setContentSize:CGSizeMake(320, positionX + 55)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_sportsFitnessScroll setContentSize:CGSizeMake(320, positionX + 225)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_sportsFitnessScroll setContentSize:CGSizeMake(320, positionX + 310)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_sportsFitnessScroll setContentSize:CGSizeMake(375, positionX + 55)];
                }
            }
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebView *webView = [segue destinationViewController];
    LocationsVC *locations = [segue destinationViewController];
    
    UIButton *button = sender;
    
    if (button.tag == 0) {
        webView.loadUrl = @"https://teamexchange.ticketmaster.com/html/eventlist.htmI?l=EN&team=psustud";
        webView.categoryType = @"sportsFitness";
    }
    else if (button.tag == 1) {
        webView.loadUrl = @"http://www.gopsusports.com/";
        webView.categoryType = @"sportsFitness";
    }
    else if (button.tag == 2) {
        webView.loadUrl = @"http://www.gopsusports.com/calendar/events/";
        webView.categoryType = @"sportsFitness";
    }
    else if (button.tag == 3) {
        webView.loadUrl = @"http://studentaffairs.psu.edu/campusrec/strength/";
        webView.categoryType = @"sportsFitness";
    }
    else if (button.tag == 4) {
        webView.loadUrl = @"https://studentaffairs.psu.edu/CurrentFitnessAttendance/";
        webView.categoryType = @"sportsFitness";
    }
    else if (button.tag == 5) {
        webView.loadUrl = @"http://studentaffairs.psu.edu/campusrec/groupx/classes.html";
        webView.categoryType = @"sportsFitness";
    }
    else if (button.tag == 6) {
        webView.loadUrl = @"http://sites.psu.edu/clubsports/";
        webView.categoryType = @"sportsFitness";
    }
    else if (button.tag == 7) {
        webView.loadUrl = @"http://www.athletics.psu.edu/imsports/";
        webView.categoryType = @"sportsFitness";
    }
    else if (button.tag == 8) {
        locations.categoryType = @"sportsFitness";
    }
}


@end
