//
//  ParkingTransportationVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/23/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "ParkingTransportationVC.h"
#import "SWRevealViewController.h"
#import "LinksWebview.h"
#import "LocationsVC.h"

@interface ParkingTransportationVC ()

@end

@implementation ParkingTransportationVC

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
    
    UINavigationBar *parkingTransportationNavBar = [self.navigationController navigationBar];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
        {
            //IPHONE 6
            self.trackScheduleView.frame = CGRectMake(38, 250, 300, 142);
            self.routeLetterLabel.frame = CGRectMake(8, 15, 125, 25);
            self.routeNameLabel.frame = CGRectMake(8, 55, 200, 21);
            self.btnTrack.frame = CGRectMake(210, 102, 80, 35);
            self.btnSchedule.frame = CGRectMake(120, 102, 80, 35);
            self.btnClose.frame = CGRectMake(258, 0, 35, 35);
            
            [parkingTransportationNavBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],
               NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:18]}];
            
            _btnTrack.titleLabel.font = [UIFont fontWithName:@"Hoefler Text" size:13.0];
            _btnSchedule.titleLabel.font = [UIFont fontWithName:@"Hoefler Text" size:13.0];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            self.trackScheduleView.frame = CGRectMake(35, 206, 251, 142);
            self.routeLetterLabel.frame = CGRectMake(8, 15, 251, 25);
            self.routeNameLabel.frame = CGRectMake(8, 48, 251, 21);
            self.btnTrack.frame = CGRectMake(165, 104, 80, 30);
            self.btnSchedule.frame = CGRectMake(70, 104, 80, 30);
            self.btnClose.frame = CGRectMake(221, 0, 30, 30);
            
            _btnTrack.titleLabel.font = [UIFont fontWithName:@"Hoefler Text" size:12.0];
            _btnSchedule.titleLabel.font = [UIFont fontWithName:@"Hoefler Text" size:12.0];
            
            [parkingTransportationNavBar setTitleTextAttributes:
              @{NSForegroundColorAttributeName:[UIColor whiteColor],
                NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:16]}];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            self.trackScheduleView.frame = CGRectMake(35, 163, 251, 142);
            self.routeLetterLabel.frame = CGRectMake(8, 15, 251, 25);
            self.routeNameLabel.frame = CGRectMake(8, 48, 251, 21);
            self.btnTrack.frame = CGRectMake(165, 104, 80, 30);
            self.btnSchedule.frame = CGRectMake(70, 104, 80, 30);
            self.btnClose.frame = CGRectMake(221, 0, 30, 30);
            
            _btnTrack.titleLabel.font = [UIFont fontWithName:@"Hoefler Text" size:12.0];
            _btnSchedule.titleLabel.font = [UIFont fontWithName:@"Hoefler Text" size:12.0];
            
            [parkingTransportationNavBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],
               NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:15]}];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
        {
            [parkingTransportationNavBar setTitleTextAttributes:
             @{NSForegroundColorAttributeName:[UIColor whiteColor],
               NSFontAttributeName:[UIFont fontWithName:@"Hoefler Text" size:18]}];
        }

    }
    
    self.trackScheduleView.layer.cornerRadius = 10;
    
    _trackScheduleView.hidden = YES;
    
    areAdsRemoved = [[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [parkingTransportationNavBar setBarTintColor:[UIColor colorWithRed:66.0/255.0 green:66.0/255.0 blue:66.0/255.0 alpha:1.0]];
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.openSlideOut setTarget: self.revealViewController];
        [self.openSlideOut setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self showParkingAndTransportationButtons];
}

-(void)showParkingAndTransportationButtons
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ParkingAndTransportation" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        ParkingTransportationVC *universityParkParkingAndTransportation = [buttonsArray objectAtIndex:i];
        
        UIButton *upParkingTransportationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [upParkingTransportationButton setImage:[UIImage imageNamed:universityParkParkingAndTransportation] forState:UIControlStateNormal];
        upParkingTransportationButton.frame = CGRectMake(10, positionX, 355, 55);
        [upParkingTransportationButton setTag:i];
        [upParkingTransportationButton addTarget:self action:@selector(openParkingTransportationLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.parkingTransportationScroll addSubview:upParkingTransportationButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                upParkingTransportationButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                upParkingTransportationButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                upParkingTransportationButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                upParkingTransportationButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.parkingTransportationScroll addSubview:upParkingTransportationButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED

            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_parkingTransportationScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_parkingTransportationScroll setContentSize:CGSizeMake(320, positionX + 175)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_parkingTransportationScroll setContentSize:CGSizeMake(320, positionX + 265)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_parkingTransportationScroll setContentSize:CGSizeMake(320, positionX + 15)];
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
                    [_parkingTransportationScroll setContentSize:CGSizeMake(320, positionX + 125)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_parkingTransportationScroll setContentSize:CGSizeMake(320, positionX + 225)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_parkingTransportationScroll setContentSize:CGSizeMake(320, positionX + 310)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_parkingTransportationScroll setContentSize:CGSizeMake(375, positionX + 55)];
                }
            }
        }
    }
}

-(void)customTrackScheduleView
{
    _trackScheduleView.hidden = NO;
    _parkingTransportationScroll.userInteractionEnabled = NO;
    _parkingTransportationScroll.alpha = .25;
}



-(void)openParkingTransportationLinks:(id)sender
{
    UIButton *button=sender;
    
    if (button.tag == 8)
    {
        [self customTrackScheduleView];
        _busRoute = @"A";
    }
    
    if (button.tag ==1) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==2) {
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
    else if (button.tag ==9)
    {
        [self customTrackScheduleView];
        _busRoute = @"B";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route B"];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Boalsburg"];
    }
    else if (button.tag ==10)
    {
        [self customTrackScheduleView];
        _busRoute = @"C";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Houserville"];
    }
    else if (button.tag ==11)
    {
        [self customTrackScheduleView];
        _busRoute = @"F";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Pine Grove"];
    }
    else if (button.tag ==12)
    {
        [self customTrackScheduleView];
        _busRoute = @"G";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Stormstown"];
    }
    else if (button.tag ==13)
    {
        [self customTrackScheduleView];
        _busRoute = @"HP";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Toftrees/Scenery Park"];
    }
    else if (button.tag ==14)
    {
        [self customTrackScheduleView];
        _busRoute = @"K";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Cato Park"];
    }
    else if (button.tag ==15)
    {
        [self customTrackScheduleView];
        _busRoute = @"M";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Nittany Mall"];
    }
    else if (button.tag ==16)
    {
        [self customTrackScheduleView];
        _busRoute = @"N";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Martin St./Aaron Dr."];
    }
    else if (button.tag ==17)
    {
        [self customTrackScheduleView];
        _busRoute = @"NE";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Martin/Aaron Express"];
    }
    else if (button.tag ==18)
    {
        [self customTrackScheduleView];
        _busRoute = @"NV";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Martin/Vairo/Toftrees"];
    }
    else if (button.tag ==19)
    {
        [self customTrackScheduleView];
        _busRoute = @"R";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Waupelani Dr."];
    }
    else if (button.tag ==20)
    {
        [self customTrackScheduleView];
        _busRoute = @"RC";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Waupelani/Campus"];
    }
    else if (button.tag ==21)
    {
        [self customTrackScheduleView];
        _busRoute = @"RP";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Waupelani/Downtown"];
    }
    else if (button.tag ==22)
    {
        [self customTrackScheduleView];
        _busRoute = @"S";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Science Park"];
    }
    else if (button.tag ==23)
    {
        [self customTrackScheduleView];
        _busRoute = @"UT";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"University Terrace"];
    }
    else if (button.tag ==24)
    {
        [self customTrackScheduleView];
        _busRoute = @"V";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Vairo Blvd."];
    }
    else if (button.tag ==25)
    {
        [self customTrackScheduleView];
        _busRoute = @"VE";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Vairo Blvd. Express"];
    }
    else if (button.tag ==26)
    {
        [self customTrackScheduleView];
        _busRoute = @"VN";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Toftrees/Vairo/Martin"];
    }
    else if (button.tag ==27)
    {
        [self customTrackScheduleView];
        _busRoute = @"W";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Valley Vista"];
    }
    else if (button.tag ==28)
    {
        [self customTrackScheduleView];
        _busRoute = @"WE";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Havershire Blvd Express"];
    }
    else if (button.tag ==29)
    {
        [self customTrackScheduleView];
        _busRoute = @"XB";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Bellefonte"];
    }
    else if (button.tag ==30)
    {
        [self customTrackScheduleView];
        _busRoute = @"XG";
        
        self.routeLetterLabel.text = [NSString stringWithFormat:@"Route %@",_busRoute];
        self.routeNameLabel.text = [NSString stringWithFormat:@"Pleasant Gap"];
    }
        else if (button.tag ==31) {
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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148651436"]];
    }
    else if (button.tag ==43) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==45) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8142318294"]];
    }
    else if (button.tag ==46) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8142377433"]];
    }
    else if (button.tag ==47) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8143555555"]];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebView *webView = [segue destinationViewController];
    LocationsVC *locations = [segue destinationViewController];
    
    UIButton *button = sender;
    
    if (button.tag == 1) {
        webView.loadUrl = @"http://www.catabus.com/";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 2) {
        webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/System%20Map/index.html";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 4) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=1";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 5) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=2";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 6) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=3";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 7) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=4";
        webView.categoryType = @"parkingTransportation";
    }

    else if (button.tag == 9) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=20";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 10) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=21";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 11) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=22";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 12) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=23";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 13) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=24";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 14) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=25";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 15) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=26";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 16) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=27";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 17) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=28";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 18) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=29";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 19) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=30";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 20) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=48";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 21) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=49";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 22) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=31";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 23) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=32";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 24) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=33";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 25) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=34";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 26) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=52";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 27) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=35";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 28) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=54";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 29) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=39";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 30) {
        webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=40";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 31) {
        webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/FootballShuttle/index.html";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 33) {
        webView.loadUrl = @"http://transportation.psu.edu/vehicle-registration";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 34) {
        webView.loadUrl = @"http://transportation.psu.edu/resident-student-permits";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 35) {
        webView.loadUrl = @"http://transportation.psu.edu/campus-student-permits";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 36) {
        webView.loadUrl = @"http://transportation.psu.edu/student-parking-regulations";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 37) {
        webView.loadUrl = @"http://transportation.psu.edu/manage-vehicle-information-0";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 38) {
        webView.loadUrl = @"http://transportation.psu.edu/student-motorcycles";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 39) {
        webView.loadUrl = @"http://transportation.psu.edu/student-parking-rates-0";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 40) {
        webView.loadUrl = @"http://transportation.psu.edu/student-tickets-and-appeals";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 41) {
        webView.loadUrl = @"http://transportation.psu.edu/visitor-parking";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 43) {
        webView.loadUrl = @"https://downtownstatecollege.com/get-around/parking-information";
        webView.categoryType = @"parkingTransportation";
    }
    else if (button.tag == 50) {
        locations.categoryType = @"parkingTransportation";
    }
    
    if (button.tag == 100) {
        if ([_busRoute isEqualToString: @"A"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=19";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"B"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=20";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"C"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=21";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"F"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=22";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"G"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=23";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"HP"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=24";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"K"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=25";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"M"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=26";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"N"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=27";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"NE"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=28";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"NV"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=29";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"R"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=30";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"RC"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=48";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"RP"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=49";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"S"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=31";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"UT"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=32";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"V"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=33";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"VE"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=34";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"VN"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=52";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"W"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=35";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"WE"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=54";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"XB"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=39";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"XG"])
        {
            webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=40";
            webView.categoryType = @"parkingTransportation";
        }
    }
    else if (button.tag == 99) {
        if ([_busRoute isEqualToString: @"A"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/A%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"B"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/B%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"C"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/C%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"F"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/F%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"G"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/G%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"HP"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/HP%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"K"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/K%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"M"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/M%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"N"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/N%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"NE"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/NE%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"NV"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/NV%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"R"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/R%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"RC"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/RC%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"RP"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/RP%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"S"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/S%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"UT"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/UT%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"V"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/V%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"VE"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/VE%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"VN"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/VN%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"W"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/W%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"WE"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/WE%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"XB"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/XB%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
        else if ([_busRoute isEqualToString: @"XG"])
        {
            webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/XG%20Route/index.html";
            webView.categoryType = @"parkingTransportation";
        }
    }
}

-(IBAction)closeTrackScheduleView:(id)sender
{
    _trackScheduleView.hidden = YES;
    _parkingTransportationScroll.userInteractionEnabled = YES;
    _parkingTransportationScroll.alpha = 1.0;
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
