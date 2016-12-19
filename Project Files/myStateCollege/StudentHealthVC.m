//
//  StudentHealthVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/23/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "StudentHealthVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"
#import "LocationsVC.h"

@interface StudentHealthVC ()

@end

@implementation StudentHealthVC

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
    
    UINavigationBar *studentHealthNavBar = [self.navigationController navigationBar];
    [studentHealthNavBar setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]];
    [studentHealthNavBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:18]}];
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.openSlideOut setTarget: self.revealViewController];
        [self.openSlideOut setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self showStudentHealthButtons];
}

-(void)showStudentHealthButtons
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StudentHealth" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        StudentHealthVC *universityParkStudentHealth = [buttonsArray objectAtIndex:i];
        
        UIButton *upStudentHealthButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upStudentHealthButton setImage:[UIImage imageNamed:universityParkStudentHealth] forState:UIControlStateNormal];
        upStudentHealthButton.frame = CGRectMake(10, positionX, 355, 55);
        [upStudentHealthButton setTag:i];
        [upStudentHealthButton addTarget:self action:@selector(openStudentHealthLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.studentHealthScroll addSubview:upStudentHealthButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                upStudentHealthButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                upStudentHealthButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                upStudentHealthButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                upStudentHealthButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.studentHealthScroll addSubview:upStudentHealthButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_studentHealthScroll setContentSize:CGSizeMake(320, positionX + 10)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_studentHealthScroll setContentSize:CGSizeMake(320, positionX + 175)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_studentHealthScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_studentHealthScroll setContentSize:CGSizeMake(320, positionX + 0)];
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
                    [_studentHealthScroll setContentSize:CGSizeMake(320, positionX + 55)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_studentHealthScroll setContentSize:CGSizeMake(320, positionX + 225)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_studentHealthScroll setContentSize:CGSizeMake(320, positionX + 310)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_studentHealthScroll setContentSize:CGSizeMake(375, positionX + 55)];
                }
            }
        }
        
    }
}

-(void)openStudentHealthLinks:(id)sender
{
    UIButton *button=sender;
    
    if (button.tag ==0) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148634463"]];
    }
    else if (button.tag == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148630774"]];
    }
    else if (button.tag ==3) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==4) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8142317000"]];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebView *webView = [segue destinationViewController];
    LocationsVC *locations = [segue destinationViewController];
    
    UIButton *button = sender;
    
    if (button.tag == 0) {
        webView.loadUrl = @"http://studentaffairs.psu.edu/health/";
        webView.categoryType = @"studentHealth";
    }
    else if (button.tag == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148634463"]];
    }
    else if (button.tag == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148630074"]];
    }
    else if (button.tag == 3) {
        webView.loadUrl = @"http://www.mountnittany.org/medical-facilities/mount-nittany-medical-center/";
        webView.categoryType = @"studentHealth";
    }
    else if (button.tag == 4) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8142317000"]];
    }
    else if (button.tag == 5) {
        locations.categoryType = @"studentHealth";
    }
}

@end
