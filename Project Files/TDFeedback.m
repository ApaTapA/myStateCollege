//
//  TDFeedback.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 8/2/15.
//  Copyright (c) 2015 ApaTapA. All rights reserved.
//

#import "TDFeedback.h"
#import "SWRevealViewController.h"

@interface TDFeedback ()

@end

@implementation TDFeedback

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

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

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
        {
            //IPHONE 6 PLUS
        
                [btnComments setFrame:CGRectMake(62, 80, 130, 130)];
                [btnShare setFrame:CGRectMake(222, 80, 130, 130)];
                [btnRate setFrame:CGRectMake(62, 230, 130, 130)];
                [btnFollow setFrame:CGRectMake(222, 230, 130, 130)];
                [btnFacebook setFrame:CGRectMake(62, 380, 130, 130)];
                [btnInstagram setFrame:CGRectMake(222, 380, 130, 130)];
                [btnWebsite setFrame:CGRectMake(62, 530, 130, 130)];
        }
        
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
        {
            //IPHONE 6/6s
            
                [btnComments setFrame:CGRectMake(70, 80, 110, 110)];
                [btnShare setFrame:CGRectMake(200, 80, 110, 110)];
                [btnRate setFrame:CGRectMake(70, 205, 110, 110)];
                [btnFollow setFrame:CGRectMake(200, 205, 110, 110)];
                [btnFacebook setFrame:CGRectMake(70, 330, 110, 110)];
                [btnInstagram setFrame:CGRectMake(200, 330, 110, 110)];
                [btnWebsite setFrame:CGRectMake(70, 455, 110, 110)];
        }
        
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c

                [btnComments setFrame:CGRectMake(60, 75, 90, 90)];
                [btnShare setFrame:CGRectMake(170, 75, 90, 90)];
                [btnRate setFrame:CGRectMake(60, 185, 90, 90)];
                [btnFollow setFrame:CGRectMake(170, 185, 90, 90)];
                [btnFacebook setFrame:CGRectMake(60, 295, 90, 90)];
                [btnInstagram setFrame:CGRectMake(170, 295, 90, 90)];
                [btnWebsite setFrame:CGRectMake(60, 405, 90, 90)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            //IPHONE 4
            
            [btnComments setFrame:CGRectMake(75, 75, 80, 80)];
            [btnShare setFrame:CGRectMake(175, 75, 80, 80)];
            [btnRate setFrame:CGRectMake(75, 165, 80, 80)];
            [btnFollow setFrame:CGRectMake(175, 165, 80, 80)];
            [btnFacebook setFrame:CGRectMake(75, 255, 80, 80)];
            [btnInstagram setFrame:CGRectMake(175, 255, 80, 80)];
            [btnWebsite setFrame:CGRectMake(75, 345, 80, 80)];
        }
    }

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"]) {
        if (bannerView == nil) {
            
            bannerView = [[STABannerView alloc] initWithSize:STA_AutoAdSize autoOrigin:STAAdOrigin_Bottom
                                                    withView:self.view withDelegate:nil];
            [self.view addSubview:bannerView];
        }
        
    }
    else {
        [self doRemoveAds];
    }
}

-(void)doRemoveAds
{
    bannerView.hidden = YES;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
        {
            //IPHONE 6/6s
            [btnComments setFrame:CGRectMake(45, 75, 130, 130)];
            [btnShare setFrame:CGRectMake(200, 75, 130, 130)];
            [btnRate setFrame:CGRectMake(45, 225, 130, 130)];
            [btnFollow setFrame:CGRectMake(200, 225, 130, 130)];
            [btnFacebook setFrame:CGRectMake(45, 375, 130, 130)];
            [btnInstagram setFrame:CGRectMake(200, 375, 130, 130)];
            [btnWebsite setFrame:CGRectMake(45, 525, 130, 130)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c
        
            [btnComments setFrame:CGRectMake(45, 80, 105, 105)];
            [btnShare setFrame:CGRectMake(170, 80, 105, 105)];
            [btnRate setFrame:CGRectMake(45, 205, 105, 105)];
            [btnFollow setFrame:CGRectMake(170, 205, 105, 105)];
            [btnFacebook setFrame:CGRectMake(45, 330, 105, 105)];
            [btnInstagram setFrame:CGRectMake(170, 330, 105, 105)];
            [btnWebsite setFrame:CGRectMake(45, 455, 105, 105)];
        }
        else if ((int) [[UIScreen mainScreen] bounds].size.height == 736)
        {
            //IPHONE 6/6s Plus
            
            [btnComments setFrame:CGRectMake(50, 80, 145, 145)];
            [btnShare setFrame:CGRectMake(220, 80, 145, 145)];
            [btnRate setFrame:CGRectMake(50, 240, 145, 145)];
            [btnFollow setFrame:CGRectMake(220, 240, 145, 145)];
            [btnFacebook setFrame:CGRectMake(50, 400, 145, 145)];
            [btnInstagram setFrame:CGRectMake(220, 400, 145, 145)];
            [btnWebsite setFrame:CGRectMake(50, 560, 145, 145)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            //IPHONE 4
            
            [btnComments setFrame:CGRectMake(35, 80, 240, 30)];
            [btnShare setFrame:CGRectMake(35, 130, 240, 30)];
            [btnRate setFrame:CGRectMake(35, 180, 240, 30)];
            [btnFollow setFrame:CGRectMake(35, 230, 240, 30)];
            [btnFacebook setFrame:CGRectMake(35, 280, 240, 30)];
            [btnInstagram setFrame:CGRectMake(35, 330, 240, 30)];
            [btnWebsite setFrame:CGRectMake(35, 380, 240, 30)];
        }
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

- (IBAction)shareMYPSU:(id)sender
{
    NSString *shareText = @"Get connected to University Park! Check out MyPSU. Get the App Here https://itunes.apple.com/us/app/mypsu/id1025602672?ls=1&mt=8";
    NSArray *itemsToShare = @[shareText];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)rateMYPSU:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/mypsu/id1025602672?ls=1&mt=8"]];
}

- (IBAction)followTwitter:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/ApaTapA_LLC"]];
}

- (IBAction)likeFacebook:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/apatapallc"]];
}

- (IBAction)openWebsite:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://apatapallc.wix.com/apatapa"]];
}

- (IBAction)followInstagram:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://instagram.com/apatapa_apps/"]];
}

-(IBAction)openEmail:(id)sender
{
    // Email Subject
    NSString *emailTitle = @"MyPSU v2.0.8";
    // Email Content
    NSString *messageBody = @" ";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"apatapallc@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];

}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultCancelled) {
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"Suggestions & Comments" message:@"Message Canceled!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert1 show];
    }
    else if (result == MFMailComposeResultSaved) {
        UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"Suggestions & Comments" message:@"Message Saved!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert2 show];
    }
    else if (result == MFMailComposeResultSent) {
        UIAlertView *alert3 = [[UIAlertView alloc]initWithTitle:@"Suggestions & Comments" message:@"Message Sent!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert3 show];
    }
    else if (result == MFMailComposeResultFailed) {
        UIAlertView *alert4 = [[UIAlertView alloc]initWithTitle:@"Suggestions & Comments" message:@"Message Failed!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alert4 show];
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
