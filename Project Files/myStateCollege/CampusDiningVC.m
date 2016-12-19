//
//  CampusDiningVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/22/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "CampusDiningVC.h"
#import "SWRevealViewController.h"
#import "LinksWebView.h"
#import "LocationsVC.h"

@interface CampusDiningVC ()

@end

@implementation CampusDiningVC

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
    
    [self showCampusDiningButtons];
}

-(void)showCampusDiningButtons
{
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusDining" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        CampusDiningVC *universityParkCampusDiningButton = [buttonsArray objectAtIndex:i];
        
        UIButton *upCampusDiningButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upCampusDiningButton setImage:[UIImage imageNamed:universityParkCampusDiningButton] forState:UIControlStateNormal];
        upCampusDiningButton.frame = CGRectMake(10, positionX, 355, 55);
        [upCampusDiningButton setTag:i];
        [upCampusDiningButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.campusDiningScroll addSubview:upCampusDiningButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                upCampusDiningButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                upCampusDiningButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                upCampusDiningButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                upCampusDiningButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
        }
        
        [self.campusDiningScroll addSubview:upCampusDiningButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_campusDiningScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_campusDiningScroll setContentSize:CGSizeMake(320, positionX + 175)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_campusDiningScroll setContentSize:CGSizeMake(320, positionX + 265)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    [_campusDiningScroll setContentSize:CGSizeMake(320, positionX + 15)];
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
                    [_campusDiningScroll setContentSize:CGSizeMake(320, positionX + 125)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_campusDiningScroll setContentSize:CGSizeMake(320, positionX + 225)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_campusDiningScroll setContentSize:CGSizeMake(320, positionX + 310)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    [_campusDiningScroll setContentSize:CGSizeMake(320, positionX + 55)];
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
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebView *webView = [segue destinationViewController];
    LocationsVC *locations = [segue destinationViewController];
    
    UIButton *button = sender;
    
        if (button.tag == 0) {
            webView.loadUrl = @"http://foodservices.psu.edu/dining-commons";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 1) {
            webView.loadUrl = @"http://foodservices.psu.edu/residential-dining-hours";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 2) {
            webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=11&locationName=Findlay+Dining+Commons&naFlag=1";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 3) {
            webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=17&locationName=North+Food+District&naFlag=1";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 4) {
            webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=14&locationName=Pollock+Dining+Commons+&naFlag=1";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 5) {
            webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=13&locationName=South+Food+District&naFlag=1";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 6) {
            webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=16&locationName=West+Food+District&naFlag=1";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 7) {
            webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=24&locationName=The+Mix+at+Pollock&naFlag=1";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 8) {
            webView.loadUrl = @"http://www.hubdining.psu.edu/HUBDining/Dining-Options.cfm";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 9) {
            webView.loadUrl = @"http://foodservices.psu.edu/au-bon-pain";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 10) {
            webView.loadUrl = @"http://www.bluechipbistro.psu.edu/";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 11) {
            webView.loadUrl = @"http://www.cafelaura.psu.edu/";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 12) {
            webView.loadUrl = @"http://creamery.psu.edu/";
            webView.categoryType = @"campusDining";
        }
        else if (button.tag == 13) {
            locations.categoryType = @"campusDining";
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
