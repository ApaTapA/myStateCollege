//
//  NewsEventsVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/23/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "NewsEventsVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"
#import "LocationsVC.h"

@interface NewsEventsVC ()

@end

@implementation NewsEventsVC

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
    
    UINavigationBar *newsEventNavBar = [self.navigationController navigationBar];
    [newsEventNavBar setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]];
    [newsEventNavBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:18]}];
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.openSlideOut setTarget: self.revealViewController];
        [self.openSlideOut setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self showCampusNewsAndEventButtons];
    
}

-(void)showCampusNewsAndEventButtons
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusNewsAndEvents" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        NewsEventsVC *universityParkNewsAndEvents = [buttonsArray objectAtIndex:i];
        
        UIButton *upCampusNewsAndEvents = [UIButton buttonWithType:UIButtonTypeCustom];
        [upCampusNewsAndEvents setImage:[UIImage imageNamed:universityParkNewsAndEvents] forState:UIControlStateNormal];
        upCampusNewsAndEvents.frame = CGRectMake(10, positionX, 355, 55);
        [upCampusNewsAndEvents setTag:i];
        [upCampusNewsAndEvents addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.campusNewsEventsScroll addSubview:upCampusNewsAndEvents];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                upCampusNewsAndEvents.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                upCampusNewsAndEvents.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                upCampusNewsAndEvents.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                upCampusNewsAndEvents.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.campusNewsEventsScroll addSubview:upCampusNewsAndEvents];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED

            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_campusNewsEventsScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_campusNewsEventsScroll setContentSize:CGSizeMake(320, positionX + 175)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_campusNewsEventsScroll setContentSize:CGSizeMake(320, positionX + 265)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_campusNewsEventsScroll setContentSize:CGSizeMake(320, positionX + 15)];
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
                    [_campusNewsEventsScroll setContentSize:CGSizeMake(320, positionX + 125)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_campusNewsEventsScroll setContentSize:CGSizeMake(320, positionX + 225)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_campusNewsEventsScroll setContentSize:CGSizeMake(320, positionX + 310)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_campusNewsEventsScroll setContentSize:CGSizeMake(375, positionX + 55)];
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
    else if (button.tag ==8) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==9) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebView *webView = [segue destinationViewController];
    LocationsVC *locations = [segue destinationViewController];
    
    UIButton *button = sender;
    
    if (button.tag == 0) {
        webView.loadUrl = @"http://events.psu.edu/";
        webView.categoryType = @"newsEvents";
    }
    else if (button.tag == 1) {
        webView.loadUrl = @"http://php.scripts.psu.edu/clubs/up/pennstatespa/";
        webView.categoryType = @"newsEvents";
    }
    else if (button.tag == 2) {
        webView.loadUrl = @"http://cpa.psu.edu/events";
        webView.categoryType = @"newsEvents";
    }
    else if (button.tag == 3) {
        webView.loadUrl = @"http://bjc.psu.edu/events-list";
        webView.categoryType = @"newsEvents";
    }
    else if (button.tag == 4) {
        webView.loadUrl = @"https://www.thon.org/";
        webView.categoryType = @"newsEvents";
    }
    else if (button.tag == 5) {
        webView.loadUrl = @"http://news.psu.edu/campus/university-park";
        webView.categoryType = @"newsEvents";
    }
    else if (button.tag == 6) {
        webView.loadUrl = @"http://news.psu.edu/";
        webView.categoryType = @"newsEvents";
    }
    else if (button.tag == 7) {
        webView.loadUrl = @"http://onwardstate.com/";
        webView.categoryType = @"newsEvents";
    }
    else if (button.tag == 8) {
        webView.loadUrl = @"http://www.collegian.psu.edu/";
        webView.categoryType = @"newsEvents";
    }
    else if (button.tag == 9) {
        webView.loadUrl = @"https://weather.com/weather/today/l/40.79,-77.86";
        webView.categoryType = @"newsEvents";
    }
    else if (button.tag == 10) {
        locations.categoryType = @"newsEvents";
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
