//
//  NightlifeVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/23/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "NightlifeVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"
#import "LocationsVC.h"

@interface NightlifeVC ()

@end

@implementation NightlifeVC

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
    
    UINavigationBar *nightlifeNavBar = [self.navigationController navigationBar];
    [nightlifeNavBar setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]];
    [nightlifeNavBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:18]}];
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.openSlideOut setTarget: self.revealViewController];
        [self.openSlideOut setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self showNightLifeButtons];
}

-(void)showNightLifeButtons
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Nightlife" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        NightlifeVC *universityParkNightlife = [buttonsArray objectAtIndex:i];
        
        UIButton *upNightlifeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upNightlifeButton setImage:[UIImage imageNamed:universityParkNightlife] forState:UIControlStateNormal];
        upNightlifeButton.frame = CGRectMake(10, positionX, 355, 55);
        [upNightlifeButton setTag:i];
        [upNightlifeButton addTarget:self action:@selector(openNightlifeLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.nightlifeScroll addSubview:upNightlifeButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                upNightlifeButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                upNightlifeButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                upNightlifeButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                upNightlifeButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.nightlifeScroll addSubview:upNightlifeButton];
        
        if (areAdsRemoved) {
//            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_nightlifeScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_nightlifeScroll setContentSize:CGSizeMake(320, positionX + 175)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_nightlifeScroll setContentSize:CGSizeMake(320, positionX + 265)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_nightlifeScroll setContentSize:CGSizeMake(320, positionX + 15)];
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
                    [_nightlifeScroll setContentSize:CGSizeMake(320, positionX + 125)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_nightlifeScroll setContentSize:CGSizeMake(320, positionX + 225)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_nightlifeScroll setContentSize:CGSizeMake(320, positionX + 310)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_nightlifeScroll setContentSize:CGSizeMake(375, positionX + 55)];
                }
            }
        }
    }
}

-(void)openNightlifeLinks:(id)sender
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
    else if (button.tag ==10) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebView *webView = [segue destinationViewController];
    LocationsVC *locations = [segue destinationViewController];
    
    UIButton *button = sender;
    
    if (button.tag == 0) {
        webView.loadUrl = @"http://www.yelp.com/search?cflt=restaurants&find_loc=State+College%2C+PA";
        webView.categoryType = @"nightlife";
    }
    else if (button.tag == 1) {
        webView.loadUrl = @"http://www.statecollege.com/business/b/bars---nightclubs,30/";
        webView.categoryType = @"nightlife";
    }
    else if (button.tag == 2) {
        webView.loadUrl = @"http://www.onwardstate.com/bartour/";
        webView.categoryType = @"nightlife";
    }
    else if (button.tag == 3) {
        webView.loadUrl = @"http://shopnittanymall.com/";
        webView.categoryType = @"nightlife";
    }
    else if (button.tag == 4) {
        webView.loadUrl = @"https://www.uecmovies.com/theatres/details/1012";
        webView.categoryType = @"nightlife";
    }
    else if (button.tag == 5) {
        webView.loadUrl = @"https://www.uecmovies.com/theatres/details/1011";
        webView.categoryType = @"nightlife";
    }
    else if (button.tag == 6) {
        webView.loadUrl = @"http://thestatetheatre.org/";
        webView.categoryType = @"nightlife";
    }
    else if (button.tag == 7) {
        webView.loadUrl = @"http://www.statecollege.com/performances/";
        webView.categoryType = @"nightlife";
    }
    else if (button.tag == 8) {
        webView.loadUrl = @"http://www.northlandbowl.com/";
        webView.categoryType = @"nightlife";
    }
    else if (button.tag == 9) {
        webView.loadUrl = @"http://www.statecollege.com/outdoor-guide/";
        webView.categoryType = @"nightlife";
    }
    else if (button.tag == 10) {
        webView.loadUrl = @"http://tusseymountain.com/";
        webView.categoryType = @"nightlife";
    }
    else if (button.tag == 11) {
        locations.categoryType = @"nightlife";
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
