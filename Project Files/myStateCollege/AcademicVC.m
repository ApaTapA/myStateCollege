//
//  AcademicVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/20/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "AcademicVC.h"
#import "SWRevealViewController.h"
#import "LocationsVC.h"
#import "LinksWebView.h"

@interface AcademicVC ()

@end

@implementation AcademicVC

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
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([_campusLocation isEqualToString:@"UP"])
    {
        NSLog(@"WE ARE University Park");
    }
    
    areAdsRemoved = [[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
    
    
    [self showAcademicButtons];

}

-(void)showAcademicButtons
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Academic" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"StateCollege"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        AcademicVC *universityParkAcademicButton = [buttonsArray objectAtIndex:i];
        
        UIButton *upAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upAcademicButton setImage:[UIImage imageNamed:universityParkAcademicButton] forState:UIControlStateNormal];
        [upAcademicButton setTag:i];
        [upAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];

        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                upAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                upAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                upAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                upAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.academicScroll addSubview:upAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_academicScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_academicScroll setContentSize:CGSizeMake(320, positionX + 175)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_academicScroll setContentSize:CGSizeMake(320, positionX + 265)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_academicScroll setContentSize:CGSizeMake(375, positionX + 20)];
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
                    [_academicScroll setContentSize:CGSizeMake(320, positionX + 125)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_academicScroll setContentSize:CGSizeMake(320, positionX + 225)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_academicScroll setContentSize:CGSizeMake(320, positionX + 310)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_academicScroll setContentSize:CGSizeMake(375, positionX + 55)];
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
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebView *webView = [segue destinationViewController];
    LocationsVC *locations = [segue destinationViewController];

    UIButton *button = sender;
        
        if (button.tag == 0) {
            webView.loadUrl = @"https://cms.psu.edu/";
        }
        else if (button.tag == 1) {
            webView.loadUrl = @"https://psu.instructure.com/";
        }
        else if (button.tag == 2) {
            webView.loadUrl = @"https://webmail.psu.edu/";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"https://elion.psu.edu/";
        }
        else if (button.tag == 4) {
            webView.loadUrl = @"https://lionpath.psu.edu/";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"https://www.absecom.psu.edu/eliving/student_pages/student_main.cfm";
        }
        else if (button.tag == 6) {
            webView.loadUrl = @"https://www.absecom.psu.edu/ONLINE_CARD_OFFICE/USER_PAGES/PSU_USER_MENU_WIN.cfm";
        }
        else if (button.tag == 7) {
            webView.loadUrl = @"https://psu.app.box.com/login";
        }
        else if (button.tag == 8) {
            webView.loadUrl = @"http://schedule.psu.edu/";
        }
        else if (button.tag == 9) {
            webView.loadUrl = @"http://registrar.psu.edu/academic_calendar/calendar_index.cfm";
        }
        else if (button.tag == 10) {
            webView.loadUrl = @"http://www.psu.edu/";
        }
        else if (button.tag == 11) {
            webView.loadUrl = @"http://www.worldcampus.psu.edu/";
        }
        else if (button.tag == 12) {
            webView.loadUrl = @"http://www.libraries.psu.edu/psul/hours.html";
        }
        else if (button.tag == 13) {
            webView.loadUrl = @"http://m.psu.edu/library/?db=true";
        }
        else if (button.tag == 14) {
            webView.loadUrl = @"http://cat.libraries.psu.edu/uhtbin/patroninfo.exe";
        }
        else if (button.tag == 15) {
            webView.loadUrl = @"http://m.psu.edu/labs/index.php?campus=UP";
        }
        else if (button.tag == 16) {
            webView.loadUrl = @"http://clc.its.psu.edu/printing";
        }
        else if (button.tag == 17) {
            webView.loadUrl = @"https://advising.psu.edu/";
        }
        else if (button.tag == 18) {
            webView.loadUrl = @"http://studentaffairs.psu.edu/career/";
        }
        else if (button.tag == 19) {
            webView.loadUrl = @"http://testing.psu.edu/";
        }
        else if (button.tag == 20) {
            webView.loadUrl = @"http://m.psu.edu/people/";
        }
        else if (button.tag == 21) {
            webView.loadUrl = @"http://pennstatelearning.psu.edu/";
        }
        else if (button.tag == 22) {
            webView.loadUrl = @"http://www.psuknowhow.com/";
        }
        else if (button.tag == 23) {
            webView.loadUrl = @"http://www.liontutors.com/";
        }
        else if (button.tag == 24) {
            locations.categoryType = @"Academic";
        }
            
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
