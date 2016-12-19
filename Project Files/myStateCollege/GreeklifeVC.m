
//
//  GreeklifeVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/23/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "GreeklifeVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"
#import "LocationsVC.h"

@interface GreeklifeVC ()

@end

@implementation GreeklifeVC

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

    UINavigationBar *greeklifeNavBar = [self.navigationController navigationBar];
    [greeklifeNavBar setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]];
    [greeklifeNavBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:18]}];
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.openSlideOut setTarget: self.revealViewController];
        [self.openSlideOut setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self showGreekLifeButtons];
}

-(void)showGreekLifeButtons
{
      NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Greeklife" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        GreeklifeVC *universityParkGreeklife = [buttonsArray objectAtIndex:i];
        
        UIButton *upGreeklifeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upGreeklifeButton setImage:[UIImage imageNamed:universityParkGreeklife] forState:UIControlStateNormal];
        upGreeklifeButton.frame = CGRectMake(10, positionX, 355, 55);
        [upGreeklifeButton setTag:i];
        [upGreeklifeButton addTarget:self action:@selector(openGreekLifeLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.greeklifeScroll addSubview:upGreeklifeButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                upGreeklifeButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                upGreeklifeButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                upGreeklifeButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                upGreeklifeButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.greeklifeScroll addSubview:upGreeklifeButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED

            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 175)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 265)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 15)];
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
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 125)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 225)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_greeklifeScroll setContentSize:CGSizeMake(320, positionX + 310)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_greeklifeScroll setContentSize:CGSizeMake(375, positionX + 55)];
                }
            }
        }
        
    }
}

-(void)openGreekLifeLinks:(id)sender
{
    UIButton *button=sender;
    
    if (button.tag ==1) {
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
    else if (button.tag ==11) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==12) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==13) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==14) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==15) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==16) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==17) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==18) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==19) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==20) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==21) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==22) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==23) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==24) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==25) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==26) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==27) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==28) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==29) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==30) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==31) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==32) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==33) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==34) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==35) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==36) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==37) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==38) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==39) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==40) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==41) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==42) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==43) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==44) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==45) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==46) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==47) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==48) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==49) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==50) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==51) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==52) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==53) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==54) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==56) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==57) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==58) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==59) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==60) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==61) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==62) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==63) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==64) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==65) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==66) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==67) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==68) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==69) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==70) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==71) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==72) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==73) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==74) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==75) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==76) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==77) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==78) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==79) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==80) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==81) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==82) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebView *webView = [segue destinationViewController];
    LocationsVC *locations = [segue destinationViewController];
    
    UIButton *button = sender;
    
    if (button.tag == 1) {
        webView.loadUrl = @"https://batchgeo.com/map/97327dcccd12d1bb598f39c2fa552570";
        webView.categoryType = @"greeklife";
    }
    if (button.tag == 3) {
        webView.loadUrl = @"http://psuacacia.acaciaconnect.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 4) {
        webView.loadUrl = @"http://www.alphachirho.org/?";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 5) {
        webView.loadUrl = @"http://www.aepi.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 6) {
        webView.loadUrl = @"http://agrgamma.chapterspot.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 7) {
        webView.loadUrl = @"http://aklpsu.org/brotherhood/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 8) {
        webView.loadUrl = @"http://pennstatealphas.wix.com/home";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 9) {
        webView.loadUrl = @"http://www.apd.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 10) {
        webView.loadUrl = @"http://www.apxpennstate.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 11) {
        webView.loadUrl = @"http://alphasigmaphi.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 12) {
        webView.loadUrl = @"http://www.ato.org/default.aspx";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 13) {
        webView.loadUrl = @"http://www.alphazeta.org/dnn/default.aspx";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 14) {
        webView.loadUrl = @"http://www.betasigmabeta.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 15) {
        webView.loadUrl = @"https://betapsu.2stayconnected.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 16) {
        webView.loadUrl = @"https://www.chiphi.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 17) {
        webView.loadUrl = @"http://www.chipsi.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 18) {
        webView.loadUrl = @"http://deltachi.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 19) {
        webView.loadUrl = @"http://phirhodke.dekeunited.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 20) {
        webView.loadUrl = @"http://www.deltaphifraternity.org/?";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 21) {
        webView.loadUrl = @"https://psudelts.2stayconnected.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 22) {
        webView.loadUrl = @"http://dtsbeta.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 23) {
        webView.loadUrl = @"http://www.deltau.org/Home";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 24) {
        webView.loadUrl = @"http://www.kdr.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 25) {
        webView.loadUrl = @"https://kappasigpsu.2stayconnected.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 26) {
        webView.loadUrl = @"http://www.clubs.psu.edu/up/ifc/lxa/LXA/Index.html";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 27) {
        webView.loadUrl = @"http://www.pennstatelambdas.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 28) {
        webView.loadUrl = @"http://www.lambda1975.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 29) {
        webView.loadUrl = @"http://www.pennstatefiji.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 30) {
        webView.loadUrl = @"http://www.phideltatheta.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 31) {
        webView.loadUrl = @"http://www.phipsipsu.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 32) {
        webView.loadUrl = @"http://www.phikappatau.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 33) {
        webView.loadUrl = @"http://www.phikaps.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 34) {
        webView.loadUrl = @"http://phimudelta.publishpath.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 35) {
        webView.loadUrl = @"http://www.phisigmakappa.org/gc-home";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 36) {
        webView.loadUrl = @"https://www.pikes.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 37) {
        webView.loadUrl = @"http://www.pikapp.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 38) {
        webView.loadUrl = @"http://www.pilam-psu.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 39) {
        webView.loadUrl = @"http://www.sae.net/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 40) {
        webView.loadUrl = @"http://sam.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 41) {
        webView.loadUrl = @"http://www.sigmachi.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 42) {
        webView.loadUrl = @"http://www.clubs.psu.edu/up/ifc/slb/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 43) {
        webView.loadUrl = @"http://sigmanupennstate.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 44) {
        webView.loadUrl = @"http://www.sigep-pennstate.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 45) {
        webView.loadUrl = @"http://sigmapi.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 46) {
        webView.loadUrl = @"http://sigtaupsu.weebly.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 47) {
        webView.loadUrl = @"http://www.taudelt.net/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 48) {
        webView.loadUrl = @"https://www.tke.org/chapter/116/pi";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 49) {
        webView.loadUrl = @"http://www.tauphidelta.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 50) {
        webView.loadUrl = @"http://www.thetadeltachi.net/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 51) {
        webView.loadUrl = @"http://www.thetachi.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 52) {
        webView.loadUrl = @"http://www.psutriangle.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 53) {
        webView.loadUrl = @"http://www.zbt.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 54) {
        webView.loadUrl = @"http://www.pisigmazetes.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 56) {
        webView.loadUrl = @"https://www.alphachiomega.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 57) {
        webView.loadUrl = @"http://www.alphadeltapipsu.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 58) {
        webView.loadUrl = @"http://www.aka1908.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 59) {
        webView.loadUrl = @"http://www.akdphi.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 60) {
        webView.loadUrl = @"http://www.alphaomicronpi.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 61) {
        webView.loadUrl = @"https://www.alphaphi.org/Home";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 62) {
        webView.loadUrl = @"http://www.alphasigmaalpha.org/Home";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 63) {
        webView.loadUrl = @"http://www.alphaxidelta.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 64) {
        webView.loadUrl = @"http://www.chiomega.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 65) {
        webView.loadUrl = @"http://www.tridelta.org/Home";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 66) {
        webView.loadUrl = @"https://www.deltagamma.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 67) {
        webView.loadUrl = @"http://www.deltazeta.org/Home";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 68) {
        webView.loadUrl = @"http://www.gammaphibeta.org/Home";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 69) {
        webView.loadUrl = @"http://www.kappaalphatheta.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 70) {
        webView.loadUrl = @"http://www.kappadelta.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 71) {
        webView.loadUrl = @"https://www.kappakappagamma.org/kappa/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 72) {
        webView.loadUrl = @"https://www.pibetaphi.org/pibetaphi/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 73) {
        webView.loadUrl = @"http://www.phimu.org/Home";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 74) {
        webView.loadUrl = @"https://sigmadeltatau.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 75) {
        webView.loadUrl = @"http://www.angelfire.com/pa5/kapparho/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 76) {
        webView.loadUrl = @"http://www.sigmakappa.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 77) {
        webView.loadUrl = @"http://www.sigmalambdagamma.com/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 78) {
        webView.loadUrl = @"http://www.sigmalambdaupsilon.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 79) {
        webView.loadUrl = @"http://psusigmaomicronpi.wixsite.com/psusopi";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 80) {
        webView.loadUrl = @"http://www.trisigma.org/Home.mvc";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 81) {
        webView.loadUrl = @"http://www.zphib1920.org/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 82) {
        webView.loadUrl = @"https://www.zetataualpha.org/cms400min/";
        webView.categoryType = @"greeklife";
    }
    else if (button.tag == 83) {
        locations.categoryType = @"greeklife";
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
