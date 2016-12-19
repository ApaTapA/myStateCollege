//
//  MainMenu.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/28/15.
//  Copyright (c) 2015 ApaTapA. All rights reserved.
//

#import "MainMenu.h"
#import "LinksWebView.h"
#import <StoreKit/StoreKit.h>
#import <iAd/iAd.h>

@interface MainMenu () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@end

@implementation MainMenu

#define kRemoveAdsProductIdentifier @"com.thomasdiffendal.mypsu.removeads"

- (IBAction)tapsRemoveAds{
    self.settingsView.hidden = YES;
//    NSLog(@"User requests to remove ads");
    
    if([SKPaymentQueue canMakePayments]){
//        NSLog(@"User can make payments");
        iapLoading.hidden = NO;
        [iap startAnimating];
        
        SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:kRemoveAdsProductIdentifier]];
        productsRequest.delegate = self;
        [productsRequest start];
        
    }
    else{
//        NSLog(@"User cannot make payments due to parental controls");
        //this is called the user cannot make payments, most likely due to parental controls
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if(count > 0){
        validProduct = [response.products objectAtIndex:0];
//        NSLog(@"Products Available!");
        [self purchase:validProduct];
    }
    else if(!validProduct){
//        NSLog(@"No products available");
        //this is called if your product id is not valid, this shouldn't be called unless that happens.
    }
}

- (IBAction)purchase:(SKProduct *)product{
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (IBAction) restore{
    //this is called when the user restores purchases, you should hook this up to a button
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    self.settingsView.hidden = YES;
}

- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
//    NSLog(@"received restored transactions: %i", queue.transactions.count);
    for(SKPaymentTransaction *transaction in queue.transactions){
        if(transaction.transactionState == SKPaymentTransactionStateRestored){
            //called when the user successfully restores a purchase
//            NSLog(@"Transaction state -> Restored");
            
            iapLoading.hidden = YES;
            [iap stopAnimating];
            
            [self doRemoveAds];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch(transaction.transactionState){
            case SKPaymentTransactionStatePurchasing: NSLog(@"Transaction state -> Purchasing");
                //called when the user is in the process of purchasing, do not add any of your own code here.
                break;
            case SKPaymentTransactionStatePurchased:
                //this is called when the user has successfully purchased the package (Cha-Ching!)
                [self doRemoveAds]; //you can add your code for what you want to happen when the user buys the purchase here, for this tutorial we use removing ads
                iapLoading.hidden = YES;
                [iap stopAnimating];
                [self showAcademicButtons];
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//                NSLog(@"Transaction state -> Purchased");
                break;
            case SKPaymentTransactionStateRestored:
//                NSLog(@"Transaction state -> Restored");
                [self doRemoveAds];
                iapLoading.hidden = YES;
                [iap stopAnimating];
                [self showAcademicButtons];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                //called when the transaction does not finish
                if(transaction.error.code == SKErrorPaymentCancelled){
//                    NSLog(@"Transaction state -> Cancelled");
                    iapLoading.hidden = YES;
                    [iap stopAnimating];
                    //the user cancelled the payment ;(
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
        }
    }
}

- (void)doRemoveAds{
    self.settingsView.hidden = YES;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            [self.settingsView setFrame:CGRectMake(193, 28, 121, 155)];
            [btnInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:13]];
            [btnFeedback.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:13]];
        }
        if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
        {
            self.settingsView.frame = CGRectMake(217, 28, 150, 80);
        }
    }
    
    divider2.hidden = YES;
    divider3.hidden = YES;
    areAdsRemoved = YES;
    bannerView.hidden = YES;
    self.btnRemoveAds.hidden = YES;
    self.btnRemoveAds.enabled = NO;
    self.btnRestorePurchase.hidden = YES;
    self.btnRestorePurchase.enabled = NO;
    [[NSUserDefaults standardUserDefaults] setBool:areAdsRemoved forKey:@"areAdsRemoved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    iapLoading.hidden = YES;
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    iapLoading.layer.cornerRadius = 5;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c
            [schoolLabel setFrame:CGRectMake(3, -2, 118,31)];
            [mainMenuBackground setFrame:CGRectMake(0, 0, 320, 568)];
            [self.btnSelectCategory setFrame:CGRectMake(46, 39, 228, 31)];
            [btnCloseDropdown setFrame:CGRectMake(46, 39, 228, 31)];
            [btnSettings setFrame:CGRectMake(280, -6, 40, 40)];
            [btnCloseSettings setFrame:CGRectMake(280, -6, 40, 40)];
            [self.categoryIcon setFrame:CGRectMake(54, 42, 25, 25)];
            [self.categoryLabel setFrame:CGRectMake(91, 42, 183, 25)];
            [_mainMenuScroll setFrame:CGRectMake(0, 76, 320, 601)];
            [self.categoryView setFrame:CGRectMake(46, 71, 228, 396)];
            [self.btnAcademic setFrame:CGRectMake(45, 6, 174, 35)];
            [self.btnCampusDining setFrame:CGRectMake(45, 36, 192, 54)];
            [self.btnCampusInformation setFrame:CGRectMake(45, 89, 192, 30)];
            [self.btnCampusNewsAndEvents setFrame:CGRectMake(45, 128, 209, 30)];
            [self.btnCampusPolice setFrame:CGRectMake(45, 167, 129, 30)];
            [self.btnGreekLife setFrame:CGRectMake(45, 204, 110, 30)];
            [self.btnNightlife setFrame:CGRectMake(45, 243, 103, 30)];
            [self.btnParkingAndTransportation setFrame:CGRectMake(45, 282, 197, 30)];
            [self.btnSportsAndFitness setFrame:CGRectMake(45, 321, 159, 30)];
            [self.btnStudentHealth setFrame:CGRectMake(45, 355, 179, 40)];
            [academicIcon setFrame:CGRectMake(8, 11, 25, 25)];
            [diningIcon setFrame:CGRectMake(8.5, 50, 25, 25)];
            [informationIcon setFrame:CGRectMake(6, 89, 25, 25)];
            [newsIcon setFrame:CGRectMake(6, 128, 25, 25)];
            [policeIcon setFrame:CGRectMake(6, 167, 25, 25)];
            [greeklifeIcon setFrame:CGRectMake(6, 206, 25, 25)];
            [nightlifeIcon setFrame:CGRectMake(6, 245, 25, 25)];
            [parkingIcon setFrame:CGRectMake(6, 284, 25, 25)];
            [sportsIcon setFrame:CGRectMake(6, 323, 25, 25)];
            [studentHealthIcon setFrame:CGRectMake(6, 362, 25, 25)];
            [self.settingsView setFrame:CGRectMake(193, 28, 121, 155)];
            [btnInformation setFrame:CGRectMake(5, 5, 140, 31)];
            [btnFeedback setFrame:CGRectMake(5, 46, 140, 30)];
            [self.btnRemoveAds setFrame:CGRectMake(5, 87, 140, 30)];
            [self.btnRestorePurchase setFrame:CGRectMake(5, 125, 139, 30)];
            
            
            
            [divider1 setFrame:CGRectMake(5, 38, 110, 1)];
            [divider2 setFrame:CGRectMake(5, 80, 110, 1)];
            [divider3 setFrame:CGRectMake(5, 118, 110, 1)];
            
            [firstTimeMessage setFrame:CGRectMake(0, 0, 320, 442)];
            
            [iapLoading setFrame:CGRectMake(95, 219, 130, 130)];
            
            
            [btnInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnFeedback.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnRemoveAdsSetting.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnRestorePurchases.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            
            [self.categoryLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnAcademic.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnCampusDining.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnCampusInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnCampusNewsAndEvents.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnCampusPolice.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnGreekLife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnNightlife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnParkingAndTransportation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnSportsAndFitness.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            [self.btnStudentHealth.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
            
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            [schoolLabel setFrame:CGRectMake(3, 0, 118,31)];
            [mainMenuBackground setFrame:CGRectMake(0, 0, 320, 515)];
            [self.btnSelectCategory setFrame:CGRectMake(50, 34, 220, 30)];
            [btnCloseDropdown setFrame:CGRectMake(50, 34, 220, 30)];
            [btnSettings setFrame:CGRectMake(280, -6, 40, 40)];
            [btnCloseSettings setFrame:CGRectMake(280, -6, 40, 40)];
            [self.categoryIcon setFrame:CGRectMake(60, 39, 20, 20)];
            [self.categoryLabel setFrame:CGRectMake(93, 37, 199, 25)];
            [_mainMenuScroll setFrame:CGRectMake(0, 69, 320, 601)];
            [self.categoryView setFrame:CGRectMake(50, 65, 220, 350)];
            [self.btnAcademic setFrame:CGRectMake(43, 3, 208, 35)];
            [self.btnCampusDining setFrame:CGRectMake(43, 28, 192, 54)];
            [self.btnCampusInformation setFrame:CGRectMake(43, 74, 209, 30)];
            [self.btnCampusNewsAndEvents setFrame:CGRectMake(43, 108, 209, 30)];
            [self.btnCampusPolice setFrame:CGRectMake(43, 142, 199, 30)];
            [self.btnGreekLife setFrame:CGRectMake(43, 176, 192, 30)];
            [self.btnNightlife setFrame:CGRectMake(43, 210, 103, 30)];
            [self.btnParkingAndTransportation setFrame:CGRectMake(43, 244, 197, 30)];
            [self.btnSportsAndFitness setFrame:CGRectMake(43, 278, 199, 30)];
            [self.btnStudentHealth setFrame:CGRectMake(43, 307, 199, 40)];
            [academicIcon setFrame:CGRectMake(10, 11, 20, 20)];
            [diningIcon setFrame:CGRectMake(10, 45, 20, 20)];
            [informationIcon setFrame:CGRectMake(10, 79, 20, 20)];
            [newsIcon setFrame:CGRectMake(10, 113, 20, 20)];
            [policeIcon setFrame:CGRectMake(10, 147, 20, 20)];
            [greeklifeIcon setFrame:CGRectMake(10, 181, 20, 20)];
            [nightlifeIcon setFrame:CGRectMake(10, 215, 20, 20)];
            [parkingIcon setFrame:CGRectMake(10, 249, 20, 20)];
            [sportsIcon setFrame:CGRectMake(10, 283, 20, 20)];
            [studentHealthIcon setFrame:CGRectMake(10, 317, 20, 20)];
            [self.settingsView setFrame:CGRectMake(190, 28, 122, 163)];
            [btnInformation setFrame:CGRectMake(5, 5, 140, 31)];
            [btnFeedback setFrame:CGRectMake(5, 46, 140, 30)];
            [self.btnRemoveAds setFrame:CGRectMake(5, 87, 140, 30)];
            [self.btnRestorePurchase setFrame:CGRectMake(5, 126, 134, 30)];
            
            [divider1 setFrame:CGRectMake(3, 38, 115, 1)];
            [divider2 setFrame:CGRectMake(3, 80, 115, 1)];
            [divider3 setFrame:CGRectMake(3, 118, 115, 1)];
            
            [firstTimeMessage setFrame:CGRectMake(0, 0, 320, 361)];
            
            [iapLoading setFrame:CGRectMake(95, 175, 130, 130)];
            
            [btnInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnFeedback.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnRemoveAdsSetting.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            [btnRestorePurchases.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14]];
            
            [self.categoryLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnAcademic.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnCampusDining.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnCampusInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnCampusNewsAndEvents.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnCampusPolice.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnGreekLife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnNightlife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnParkingAndTransportation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnSportsAndFitness.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
            [self.btnStudentHealth.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:14.0]];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
        {
            [schoolLabel setFrame:CGRectMake(7, 0, 118,31)];
            [mainMenuBackground setFrame:CGRectMake(0, 0, 414, 690)];
            [self.btnSelectCategory setFrame:CGRectMake(66, 46, 283, 37)];
            [btnCloseDropdown setFrame:CGRectMake(66, 46, 283, 37)];
            [btnSettings setFrame:CGRectMake(370, -7, 45, 45)];
            [btnCloseSettings setFrame:CGRectMake(370, -7, 45, 45)];
            [self.categoryIcon setFrame:CGRectMake(80, 50, 30, 30)];
            [self.categoryLabel setFrame:CGRectMake(125, 46, 199, 37)];
            [_mainMenuScroll setFrame:CGRectMake(0, 93, 414, 600)];
            [self.categoryView setFrame:CGRectMake(66, 84, 283, 460)];
            [self.btnAcademic setFrame:CGRectMake(60, 8, 208, 35)];
            [self.btnCampusDining setFrame:CGRectMake(60, 44, 192, 54)];
            [self.btnCampusInformation setFrame:CGRectMake(60, 101, 209, 30)];
            [self.btnCampusNewsAndEvents setFrame:CGRectMake(60, 146, 209, 30)];
            [self.btnCampusPolice setFrame:CGRectMake(60, 191, 199, 30)];
            [self.btnGreekLife setFrame:CGRectMake(60, 236, 192, 30)];
            [self.btnNightlife setFrame:CGRectMake(60, 281, 190, 30)];
            [self.btnParkingAndTransportation setFrame:CGRectMake(60, 325, 197, 30)];
            [self.btnSportsAndFitness setFrame:CGRectMake(60, 371, 199, 30)];
            [self.btnStudentHealth setFrame:CGRectMake(60, 412, 199, 40)];
            [academicIcon setFrame:CGRectMake(14, 11, 30, 30)];
            [diningIcon setFrame:CGRectMake(14, 56, 30, 30)];
            [informationIcon setFrame:CGRectMake(14, 101, 30, 30)];
            [newsIcon setFrame:CGRectMake(14, 146, 30, 30)];
            [policeIcon setFrame:CGRectMake(14, 191, 30, 30)];
            [greeklifeIcon setFrame:CGRectMake(14, 236, 30, 30)];
            [nightlifeIcon setFrame:CGRectMake(14, 281, 30, 30)];
            [parkingIcon setFrame:CGRectMake(14, 325, 30, 30)];
            [sportsIcon setFrame:CGRectMake(14, 370, 30, 30)];
            [studentHealthIcon setFrame:CGRectMake(14, 415, 30, 30)];
            [self.settingsView setFrame:CGRectMake(255, 28, 150, 163)];
            [btnInformation setFrame:CGRectMake(5, 5, 140, 30)];
            [btnFeedback setFrame:CGRectMake(5, 45, 140, 30)];
            [self.btnRemoveAds setFrame:CGRectMake(5, 85, 140, 30)];
            [self.btnRestorePurchase setFrame:CGRectMake(5, 125, 134, 30)];
            
            [divider1 setFrame:CGRectMake(3, 38, 145, 1)];
            [divider2 setFrame:CGRectMake(3, 80, 145, 1)];
            [divider3 setFrame:CGRectMake(3, 118, 145, 1)];
            
            [firstTimeMessage setFrame:CGRectMake(0, 0, 414, 593)];
            
            [iapLoading setFrame:CGRectMake(142, 303, 130, 130)];
            
            [btnInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17]];
            [btnFeedback.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17]];
            [btnRemoveAdsSetting.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17]];
            [btnRestorePurchases.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17]];
            
            [self.categoryLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnAcademic.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnCampusDining.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnCampusInformation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnCampusNewsAndEvents.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnCampusPolice.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnGreekLife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnNightlife.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnParkingAndTransportation.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnSportsAndFitness.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
            [self.btnStudentHealth.titleLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];

        }
    }
    
    btnCloseDropdown.hidden = YES;
    
    self.categoryView.hidden = YES;
    self.settingsView.hidden = YES;
    btnCloseSettings.hidden = YES;
    iapLoading.hidden = YES;
    
    areAdsRemoved = [[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //this will load wether or not they bought the in-app purchase
    
    if(areAdsRemoved){
        [self doRemoveAds];
    }
    
}



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

-(void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    [UIView animateWithDuration:0.5 animations:^{
        bannerView.alpha = 1.0;
    }];
    
        bannerIsVisible = YES;
        NSLog(@"VISIBLE");
        areAdsRemoved = NO;
    
    self.btnRemoveAds.hidden = NO;
    self.btnRemoveAds.enabled = YES;
    self.btnRestorePurchase.hidden = NO;
    self.btnRestorePurchase.enabled = YES;
    divider2.hidden = NO;
    divider3.hidden = NO;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            [self.settingsView setFrame:CGRectMake(193, 28, 121, 155)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            [self.settingsView setFrame:CGRectMake(190, 28, 122, 163)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
        {
            [self.settingsView setFrame:CGRectMake(255, 28, 150, 163)];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
        {
            [self.settingsView setFrame:CGRectMake(217, 28, 150, 163)];

        }
    }
    
    if ([self.categoryLabel.text isEqualToString:@"Academics"]) {
        [self showAcademicButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus Dining"]) {
        [self showCampusDiningButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus Information"]) {
        [self showCampusInformationButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus News & Events"]) {
        [self showCampusNewsAndEventButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus Police"]) {
        [self showCampusPoliceButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Greeklife"]) {
        [self showGreekLifeButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Nightlife"]) {
        [self showNightLifeButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Parking & Transportation"]) {
        [self showParkingAndTransportationButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Sports & Fitness"]) {
        [self showSportsAndFitnessButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Student Health"]) {
        [self showStudentHealthButtons];
    }
}

-(void)viewWillAppear:(BOOL)animated
{   [self loadCategory];
    
    
    if ([self.categoryLabel.text isEqualToString:@""]) {
        self.categoryLabel.text = @"Academics";
    }
    
    
    if ([self.categoryLabel.text isEqualToString:@"Academics"]) {
        [self showAcademicButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus Dining"]) {
        [self showCampusDiningButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus Information"]) {
        [self showCampusInformationButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus News & Events"]) {
        [self showCampusNewsAndEventButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Campus Police"]) {
        [self showCampusPoliceButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Greeklife"]) {
        [self showGreekLifeButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Nightlife"]) {
        [self showNightLifeButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Parking & Transportation"]) {
        [self showParkingAndTransportationButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Sports & Fitness"]) {
        [self showSportsAndFitnessButtons];
    }
    else if ([self.categoryLabel.text isEqualToString:@"Student Health"]) {
        [self showStudentHealthButtons];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self saveCategory];
}

-(IBAction)selectSettings:(id)sender
{
    self.settingsView.hidden = NO;
    self.categoryView.hidden = YES;
    btnCloseSettings.hidden = NO;
    btnSettings.hidden = YES;
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    
    
    if (areAdsRemoved) {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            self.settingsView.frame = CGRectMake(193, 28, 121, 80);
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
        {
           self.settingsView.frame = CGRectMake(217, 28, 150, 80);
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            self.settingsView.frame = CGRectMake(190, 28, 122, 85);
            
        self.btnRemoveAds.hidden = YES;
        self.btnRemoveAds.enabled = NO;
        self.btnRestorePurchase.hidden = YES;
        self.btnRestorePurchase.enabled = NO;
    }
    }
}

-(void)saveCategory
{
    NSString *saveCategory = self.categoryLabel.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:saveCategory forKey:@"categoryChoice"];
    [defaults synchronize];
}

-(void)loadCategory
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loadString = [defaults objectForKey:@"categoryChoice"];
    [self.categoryLabel setText:loadString];
}

-(IBAction)closeSettings:(id)sender
{
    self.settingsView.hidden = YES;
    btnSettings.hidden = NO;
    btnCloseSettings.hidden = YES;
}

-(IBAction)closeDropdown:(id)sender
{
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    self.categoryView.hidden = YES;
}

-(void)showAcademicButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    
    self.categoryView.hidden = YES;
    btnCloseDropdown.hidden = YES;
    self.categoryLabel.text = @"Academics";
    self.categoryIcon.image = [UIImage imageNamed:@"academic_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Academic" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"StateCollege"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *abingtonAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *abAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [abAcademicButton setImage:[UIImage imageNamed:abingtonAcademic] forState:UIControlStateNormal];
        [abAcademicButton setTag:i];
        [abAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
        
                abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                abAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }

        }
        
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
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
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                 else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                     //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 5)];
                }
            }
        }
        
    }
}

-(void)showCampusDiningButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    
    self.categoryView.hidden = YES;
    self.categoryLabel.text = @"Campus Dining";
    self.categoryIcon.image = [UIImage imageNamed:@"campus_dining_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusDining" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *abingtonAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *abAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [abAcademicButton setImage:[UIImage imageNamed:abingtonAcademic] forState:UIControlStateNormal];
        abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
        [abAcademicButton setTag:i];
        [abAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                abAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
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
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
            }
        }
        }
    }

-(void)showCampusInformationButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    
    self.categoryView.hidden = YES;
    self.categoryLabel.text = @"Campus Information";
    self.categoryIcon.image = [UIImage imageNamed:@"campus_information_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusInformation" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *abingtonAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *abAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [abAcademicButton setImage:[UIImage imageNamed:abingtonAcademic] forState:UIControlStateNormal];
        abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
        [abAcademicButton setTag:i];
        [abAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                abAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
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
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 5)];
                }
            }
            }
            
        }
    }

-(void)showCampusNewsAndEventButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    
    self.categoryView.hidden = YES;
    self.categoryLabel.text = @"Campus News & Events";
    self.categoryIcon.image = [UIImage imageNamed:@"campus_news_and_events_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusNewsAndEvents" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *abingtonAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *abAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [abAcademicButton setImage:[UIImage imageNamed:abingtonAcademic] forState:UIControlStateNormal];
        abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
        [abAcademicButton setTag:i];
        [abAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                abAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
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
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 5)];
                }
            }
            }
            
        }
        
    }

-(void)showCampusPoliceButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    
    self.categoryView.hidden = YES;
    self.categoryLabel.text = @"Campus Police";
    self.categoryIcon.image = [UIImage imageNamed:@"campus_police_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CampusPolice" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *abingtonAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *abAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [abAcademicButton setImage:[UIImage imageNamed:abingtonAcademic] forState:UIControlStateNormal];
        abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
        [abAcademicButton setTag:i];
        [abAcademicButton addTarget:self action:@selector(openCampusPoliceLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                abAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
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
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 5)];
                }
            }
            }
            
        }
        
    }

-(void)showGreekLifeButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    
    self.categoryView.hidden = YES;
    self.categoryLabel.text = @"Greeklife";
    self.categoryIcon.image = [UIImage imageNamed:@"greek_life_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Greeklife" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *abingtonAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *abAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [abAcademicButton setImage:[UIImage imageNamed:abingtonAcademic] forState:UIControlStateNormal];
        abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
        [abAcademicButton setTag:i];
        [abAcademicButton addTarget:self action:@selector(openGreekLifeLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                abAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
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
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 5)];
                }
            }
            }
            
        }
        
    }

-(void)showNightLifeButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    
    self.categoryView.hidden = YES;
    self.categoryLabel.text = @"Nightlife";
    self.categoryIcon.image = [UIImage imageNamed:@"nightlife_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Nightlife" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *abingtonAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *abAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [abAcademicButton setImage:[UIImage imageNamed:abingtonAcademic] forState:UIControlStateNormal];
        abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
        [abAcademicButton setTag:i];
        [abAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                abAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
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
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 5)];
                }
            }
            }
            
        }
        
    }

-(void)showParkingAndTransportationButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    
    self.categoryView.hidden = YES;
    self.categoryLabel.text = @"Parking & Transportation";
    self.categoryIcon.image = [UIImage imageNamed:@"parking_and_transportation_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ParkingAndTransportation" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *abingtonAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *abAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [abAcademicButton setImage:[UIImage imageNamed:abingtonAcademic] forState:UIControlStateNormal];
        abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
        [abAcademicButton setTag:i];
        [abAcademicButton addTarget:self action:@selector(openParkingTransportationLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                abAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 115)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
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
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 5)];
                }
            }
            }
            
        }
        
    }

-(void)showSportsAndFitnessButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    
    self.categoryView.hidden = YES;
    self.categoryLabel.text = @"Sports & Fitness";
    self.categoryIcon.image = [UIImage imageNamed:@"sports_and_fitness_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SportsAndFitness" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *abingtonAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *abAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [abAcademicButton setImage:[UIImage imageNamed:abingtonAcademic] forState:UIControlStateNormal];
        abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
        [abAcademicButton setTag:i];
        [abAcademicButton addTarget:self action:@selector(openLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                abAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
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
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 5)];
                }
            }
            }
            
        }
    }

-(void)showStudentHealthButtons
{
    for (UIView *subview in _mainMenuScroll.subviews) {
        [subview removeFromSuperview];
    }
    
    btnCloseDropdown.hidden = YES;
    self.btnSelectCategory.hidden = NO;
    
    self.categoryView.hidden = YES;
    self.categoryLabel.text = @"Student Health";
    self.categoryIcon.image = [UIImage imageNamed:@"student_health_icon.png"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"StudentHealth" ofType:@"plist"]];
    NSArray *buttonsArray = [dictionary objectForKey:@"UniversityPark"];
    
    int positionX = 13;
    
    for (int i = 0; i < [buttonsArray count] ; i++) {
        
        MainMenu *abingtonAcademic = [buttonsArray objectAtIndex:i];
        
        UIButton *abAcademicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [abAcademicButton setImage:[UIImage imageNamed:abingtonAcademic] forState:UIControlStateNormal];
        abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
        [abAcademicButton setTag:i];
        [abAcademicButton addTarget:self action:@selector(openStudentHealthLinks:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
            {
                //IPHONE 6
                
                abAcademicButton.frame = CGRectMake(10, positionX, 355, 55);
                positionX +=67;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
            {
                //IPHONE 5/5s/5c
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
            {
                //IPHONE 4s
                abAcademicButton.frame = CGRectMake(10, positionX, 300, 50);
                positionX += 60;
            }
            else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
            {
                //IPHONE 6 Plus
                abAcademicButton.frame = CGRectMake(10, positionX, 395, 65);
                positionX += 79;
            }
            
        }
        
        [self.mainMenuScroll addSubview:abAcademicButton];
        
        if (areAdsRemoved) {
            //ADS ARE REMOVED
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
                {
                    //IPHONE 6
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 110)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 200)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //IPHONE 6 PLUS
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 30)];
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
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 75)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
                {
                    //IPHONE 5/5s/5c
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 163)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
                {
                    //IPHONE 4
                    [_mainMenuScroll setContentSize:CGSizeMake(320, positionX + 245)];
                }
                else if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
                {
                    //Iphone 6 Plus
                    [_mainMenuScroll setContentSize:CGSizeMake(375, positionX + 5)];
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
    else if (button.tag ==55) {
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
    
}

-(void)openCampusPoliceLinks:(id)sender
{
    UIButton *button=sender;
    
    if (button.tag ==0) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148631111"]];
    }
    else if (button.tag == 2) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148658164"]];
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

-(void)openParkingTransportationLinks:(id)sender
{
    UIButton *button=sender;
    
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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148651436"]];
    }
    else if (button.tag ==38) {
        [self performSegueWithIdentifier:@"openWebView" sender:sender];
    }
    else if (button.tag ==40) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8142318294"]];
    }
    else if (button.tag ==41) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8142377433"]];
    }
    else if (button.tag ==42) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8143555555"]];
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

-(IBAction)selectCategory:(id)sender
{
    self.categoryView.hidden = NO;
    self.settingsView.hidden = YES;
    self.btnSelectCategory.hidden = YES;
    btnCloseDropdown.hidden = NO;
}

- (IBAction)categoryAcademic:(id)sender
{
    [self showAcademicButtons];
    [self saveCategory];
}


- (IBAction)categoryCampusDining:(id)sender
{
    [self showCampusDiningButtons];
    [self saveCategory];
}

-(IBAction)campusInformation:(id)sender
{
    [self showCampusInformationButtons];
    [self saveCategory];
}

- (IBAction)campusNewsAndEvents:(id)sender
{
    [self showCampusNewsAndEventButtons];
    [self saveCategory];
}
- (IBAction)campusPolice:(id)sender
{
    [self showCampusPoliceButtons];
    [self saveCategory];
}

- (IBAction)categoryParkingAndTransportation:(id)sender
{
    [self showParkingAndTransportationButtons];
    [self saveCategory];
}

- (IBAction)categoryNightlife:(id)sender
{
    [self showNightLifeButtons];
    [self saveCategory];
}
- (IBAction)categorySportsAndFitness:(id)sender
{
    [self showSportsAndFitnessButtons];
    [self saveCategory];
}
- (IBAction)categoryStudentHealth:(id)sender
{
    [self showStudentHealthButtons];
    [self saveCategory];
}

- (IBAction)categoryGreeklife:(id)sender
{
    [self showGreekLifeButtons];
    [self saveCategory];
}

- (IBAction)settingInformation:(id)sender
{
    self.settingsView.hidden = YES;
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"information"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)settingFeedback:(id)sender
{
    self.settingsView.hidden = YES;
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"feedback"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LinksWebView *webView = [segue destinationViewController];
    
    UIButton *button = sender;
    
        if ([self.categoryLabel.text isEqualToString:@"Academics"]) {
            
            if (button.tag == 0) {
                webView.loadUrl = @"https://cms.psu.edu/";
            }
            else if (button.tag == 1) {
                webView.loadUrl = @"https://webmail.psu.edu/";
            }
            else if (button.tag == 2) {
                webView.loadUrl = @"https://elion.psu.edu/";
            }
            else if (button.tag == 3) {
                webView.loadUrl = @"https://www.absecom.psu.edu/eliving/student_pages/student_main.cfm";
            }
            else if (button.tag == 4) {
                webView.loadUrl = @"https://www.absecom.psu.edu/ONLINE_CARD_OFFICE/USER_PAGES/PSU_USER_MENU_WIN.cfm";
            }
            else if (button.tag == 5) {
                webView.loadUrl = @"https://psu.app.box.com/login";
            }
            else if (button.tag == 6) {
                webView.loadUrl = @"https://psu.instructure.com/";
            }
            else if (button.tag == 7) {
                webView.loadUrl = @"http://schedule.psu.edu/";
            }
            else if (button.tag == 8) {
                webView.loadUrl = @"http://www.psu.edu/";
            }
            else if (button.tag == 9) {
                webView.loadUrl = @"http://www.worldcampus.psu.edu/";
            }
            else if (button.tag == 10) {
                webView.loadUrl = @"http://registrar.psu.edu/academic_calendar/calendar_index.cfm";
            }
            else if (button.tag == 11) {
                webView.loadUrl = @"http://www.libraries.psu.edu/psul/hours.html";
            }
            else if (button.tag == 12) {
                webView.loadUrl = @"http://m.psu.edu/library/?db=true";
            }
            else if (button.tag == 13) {
                webView.loadUrl = @"http://cat.libraries.psu.edu/uhtbin/patroninfo.exe";
            }
            else if (button.tag == 14) {
                webView.loadUrl = @"http://m.psu.edu/labs/index.php?campus=UP";
            }
            else if (button.tag == 15) {
                webView.loadUrl = @"http://clc.its.psu.edu/printing";
            }
            else if (button.tag == 16) {
                webView.loadUrl = @"https://advising.psu.edu/";
            }
            else if (button.tag == 17) {
                webView.loadUrl = @"http://studentaffairs.psu.edu/career/";
            }
            else if (button.tag == 18) {
                webView.loadUrl = @"http://testing.psu.edu/";
            }
            else if (button.tag == 19) {
                webView.loadUrl = @"http://m.psu.edu/people/";
            }
            else if (button.tag == 20) {
                webView.loadUrl = @"http://pennstatelearning.psu.edu/";
            }
            else if (button.tag == 21) {
                webView.loadUrl = @"http://www.psuknowhow.com/";
            }
            else if (button.tag == 22) {
                webView.loadUrl = @"http://www.liontutors.com/";
            }
        }
        else if ([self.categoryLabel.text isEqualToString:@"Campus Dining"]) {
            
            if (button.tag == 0) {
                webView.loadUrl = @"http://www.hfs.psu.edu/FoodServices/Hours.cfm";
            }
            else if (button.tag == 1) {
                webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=11&locationName=Findlay+Dining+Commons&naFlag=1";
            }
            else if (button.tag == 2) {
                webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=17&locationName=North+Food+District&naFlag=1";
            }
            else if (button.tag == 3) {
                webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=14&locationName=Pollock+Dining+Commons+&naFlag=1";
            }
            else if (button.tag == 4) {
                webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=13&locationName=South+Food+District&naFlag=1";
            }
            else if (button.tag == 5) {
                webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=16&locationName=West+Food+District&naFlag=1";
            }
            else if (button.tag == 6) {
                webView.loadUrl = @"http://menu.hfs.psu.edu/shortmenu.asp?sName=Penn+State+Housing+and+Food+Services&locationNum=24&locationName=The+Mix+at+Pollock&naFlag=1";
            }
            else if (button.tag == 7) {
                webView.loadUrl = @"http://www.hubdining.psu.edu/HUBDining/Dining-Options.cfm";
            }
            else if (button.tag == 8) {
                webView.loadUrl = @"http://www.hfs.psu.edu/FoodServices/CampusDiningOptions/au-bon-pain.cfm";
            }
            else if (button.tag == 9) {
                webView.loadUrl = @"http://www.bluechipbistro.psu.edu/";
            }
            else if (button.tag == 10) {
                webView.loadUrl = @"http://www.cafelaura.psu.edu/";
            }
            else if (button.tag == 11) {
                webView.loadUrl = @"http://creamery.psu.edu/";
            }
        }
        else if ([self.categoryLabel.text isEqualToString:@"Campus Information"]) {
            
            if (button.tag == 0) {
                webView.loadUrl = @"http://www.psu.edu/";
            }
            else if (button.tag == 1) {
                webView.loadUrl = @"http://www.psumap.com/";
            }
            else if (button.tag == 2) {
                webView.loadUrl = @"http://studentaffairs.psu.edu/hub/studentorgs/orgdirectory/";
            }
            else if (button.tag == 3) {
                webView.loadUrl = @"http://rescom.psu.edu/contact-us";
            }
            else if (button.tag == 4) {
                webView.loadUrl = @"http://psu.bncollege.com/webapp/wcs/stores/servlet/BNCBHomePage?catalogId=10001&storeId=18555&langId=-1";
            }
            else if (button.tag == 5) {
                webView.loadUrl = @"http://www.housing.psu.edu/housing/housing/residence-areas/index.cfm";
            }
            else if (button.tag == 6) {
                webView.loadUrl = @"http://www.housing.psu.edu/housing/housing/channel-list.cfm";
            }
            else if (button.tag == 7) {
                webView.loadUrl = @"http://www.housing.psu.edu/housing/housing/commons.cfm";
            }
        }
        else if ([self.categoryLabel.text isEqualToString:@"Campus News & Events"]) {
            
            if (button.tag == 0) {
                webView.loadUrl = @"http://events.psu.edu/";
            }
            else if (button.tag == 1) {
                webView.loadUrl = @"http://php.scripts.psu.edu/clubs/up/pennstatespa/";
            }
            else if (button.tag == 2) {
                webView.loadUrl = @"http://cpa.psu.edu/events";
            }
            else if (button.tag == 3) {
                webView.loadUrl = @"http://news.psu.edu/campus/university-park";
            }
            else if (button.tag == 4) {
                webView.loadUrl = @"http://news.psu.edu/";
            }
            else if (button.tag == 5) {
                webView.loadUrl = @"http://onwardstate.com/";
            }
            else if (button.tag == 6) {
                webView.loadUrl = @"http://www.collegian.psu.edu/";
            }
        }
        else if ([self.categoryLabel.text isEqualToString:@"Campus Police"]) {
            
            if (button.tag == 0) {
                webView.loadUrl = @"http://www.police.psu.edu/up-police/";
            }
            else if (button.tag == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148631111"]];
            }
            else if (button.tag == 2) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148658164"]];
            }
            else if (button.tag == 3) {
                webView.loadUrl = @"http://www.police.psu.edu/psu-police/report-crime.cfm";
            }
            else if (button.tag == 4) {
                webView.loadUrl = @"http://www.police.psu.edu/up-police/services/index.cfm";
            }
            else if (button.tag == 5) {
                webView.loadUrl = @"http://www.police.psu.edu/up-police/safety/emergency-telephones.cfm";
            }
            else if (button.tag == 6) {
                webView.loadUrl = @"http://m.psu.edu/emergency/";
            }
        }
        else if ([self.categoryLabel.text isEqualToString:@"Greeklife"]) {
            if (button.tag == 1)
                webView.loadUrl = @"https://batchgeo.com/map/97327dcccd12d1bb598f39c2fa552570";
            
            if (button.tag == 3) {
                webView.loadUrl = @"http://psuacacia.acaciaconnect.org/";
            }
            else if (button.tag == 4) {
                webView.loadUrl = @"http://www.alphachirho.org/?";
            }
            else if (button.tag == 5) {
                webView.loadUrl = @"http://www.aepi.org/";
            }
            else if (button.tag == 6) {
                webView.loadUrl = @"http://agrgamma.chapterspot.com/";
            }
            else if (button.tag == 7) {
                webView.loadUrl = @"http://pennstateifc.wix.com/pennstateifc#!alpha-kappa-lambda/c171a";
            }
            else if (button.tag == 8) {
                webView.loadUrl = @"http://pennstatealphas.wix.com/home";
            }
            else if (button.tag == 9) {
                webView.loadUrl = @"http://www.apd.org/";
            }
            else if (button.tag == 10) {
                webView.loadUrl = @"http://www.apxpennstate.com/";
            }
            else if (button.tag == 11) {
                webView.loadUrl = @"http://alphasigmaphi.org/";
            }
            else if (button.tag == 12) {
                webView.loadUrl = @"http://www.ato.org/default.aspx";
            }
            else if (button.tag == 13) {
                webView.loadUrl = @"http://www.alphazeta.org/dnn/default.aspx";
            }
            else if (button.tag == 14) {
                webView.loadUrl = @"http://www.betasigmabeta.com/";
            }
            else if (button.tag == 15) {
                webView.loadUrl = @"https://betapsu.2stayconnected.com/";
            }
            else if (button.tag == 16) {
                webView.loadUrl = @"https://www.chiphi.org/";
            }
            else if (button.tag == 17) {
                webView.loadUrl = @"http://www.chipsi.org/";
            }
            else if (button.tag == 18) {
                webView.loadUrl = @"http://deltachi.org/";
            }
            else if (button.tag == 19) {
                webView.loadUrl = @"http://phirhodke.dekeunited.org/";
            }
            else if (button.tag == 20) {
                webView.loadUrl = @"http://www.deltaphifraternity.org/?";
            }
            else if (button.tag == 21) {
                webView.loadUrl = @"https://psudelts.2stayconnected.com/";
            }
            else if (button.tag == 22) {
                webView.loadUrl = @"http://dtsbeta.org/";
            }
            else if (button.tag == 23) {
                webView.loadUrl = @"http://www.deltau.org/Home";
            }
            else if (button.tag == 24) {
                webView.loadUrl = @"http://www.kdr.com/";
            }
            else if (button.tag == 25) {
                webView.loadUrl = @"https://kappasigpsu.2stayconnected.com/";
            }
            else if (button.tag == 26) {
                webView.loadUrl = @"http://pennstateifc.wix.com/pennstateifc#!lambda-chi-alpha/c1ql5";
            }
            else if (button.tag == 27) {
                webView.loadUrl = @"http://www.pennstatelambdas.com/";
            }
            else if (button.tag == 28) {
                webView.loadUrl = @"http://www.lambda1975.org/";
            }
            else if (button.tag == 29) {
                webView.loadUrl = @"http://www.pennstatefiji.org/";
            }
            else if (button.tag == 30) {
                webView.loadUrl = @"http://www.phideltatheta.org/";
            }
            else if (button.tag == 31) {
                webView.loadUrl = @"http://www.phipsipsu.com/";
            }
            else if (button.tag == 32) {
                webView.loadUrl = @"http://www.phikappatau.org/";
            }
            else if (button.tag == 33) {
                webView.loadUrl = @"http://www.phikaps.org/";
            }
            else if (button.tag == 34) {
                webView.loadUrl = @"http://phimudelta.publishpath.com/";
            }
            else if (button.tag == 35) {
                webView.loadUrl = @"http://www.phisigmakappa.org/gc-home";
            }
            else if (button.tag == 36) {
                webView.loadUrl = @"https://www.pikes.org/";
            }
            else if (button.tag == 37) {
                webView.loadUrl = @"http://www.pikapp.org/";
            }
            else if (button.tag == 38) {
                webView.loadUrl = @"http://www.pilam-psu.com/";
            }
            else if (button.tag == 39) {
                webView.loadUrl = @"http://www.sae.net/";
            }
            else if (button.tag == 40) {
                webView.loadUrl = @"http://sam.org/";
            }
            else if (button.tag == 41) {
                webView.loadUrl = @"http://www.sigmachi.org/";
            }
            else if (button.tag == 42) {
                webView.loadUrl = @"http://www.greeks.psu.edu/ifc/slb/";
            }
            else if (button.tag == 43) {
                webView.loadUrl = @"http://sigmanupennstate.org/";
            }
            else if (button.tag == 44) {
                webView.loadUrl = @"http://www.sigep-pennstate.org/";
            }
            else if (button.tag == 45) {
                webView.loadUrl = @"http://sigmapi.org/";
            }
            else if (button.tag == 46) {
                webView.loadUrl = @"http://sigtaupsu.weebly.com/";
            }
            else if (button.tag == 47) {
                webView.loadUrl = @"http://www.taudelt.net/";
            }
            else if (button.tag == 48) {
                webView.loadUrl = @"http://psutkes.webs.com/";
            }
            else if (button.tag == 49) {
                webView.loadUrl = @"http://www.tauphidelta.org/";
            }
            else if (button.tag == 50) {
                webView.loadUrl = @"http://www.thetadeltachi.net/";
            }
            else if (button.tag == 51) {
                webView.loadUrl = @"http://www.thetachi.org/";
            }
            else if (button.tag == 52) {
                webView.loadUrl = @"http://www.psutriangle.org/";
            }
            else if (button.tag == 53) {
                webView.loadUrl = @"http://www.zbt.org/";
            }
            else if (button.tag == 54) {
                webView.loadUrl = @"http://www.pisigmazetes.org/";
            }
            else if (button.tag == 56) {
                webView.loadUrl = @"https://www.alphachiomega.org/";
            }
            else if (button.tag == 57) {
                webView.loadUrl = @"http://www.alphadeltapipsu.com/";
            }
            else if (button.tag == 58) {
                webView.loadUrl = @"http://www.aka1908.com/";
            }
            else if (button.tag == 59) {
                webView.loadUrl = @"http://www.akdphi.org/";
            }
            else if (button.tag == 60) {
                webView.loadUrl = @"http://www.alphaomicronpi.org/";
            }
            else if (button.tag == 61) {
                webView.loadUrl = @"https://www.alphaphi.org/Home";
            }
            else if (button.tag == 62) {
                webView.loadUrl = @"http://www.alphasigmaalpha.org/Home";
            }
            else if (button.tag == 63) {
                webView.loadUrl = @"http://www.alphaxidelta.org/";
            }
            else if (button.tag == 64) {
                webView.loadUrl = @"http://www.chiomega.com/";
            }
            else if (button.tag == 65) {
                webView.loadUrl = @"http://www.tridelta.org/Home";
            }
            else if (button.tag == 66) {
                webView.loadUrl = @"https://www.deltagamma.org/";
            }
            else if (button.tag == 67) {
                webView.loadUrl = @"http://www.deltazeta.org/Home";
            }
            else if (button.tag == 68) {
                webView.loadUrl = @"http://www.gammaphibeta.org/Home";
            }
            else if (button.tag == 69) {
                webView.loadUrl = @"http://www.kappaalphatheta.org/";
            }
            else if (button.tag == 70) {
                webView.loadUrl = @"http://www.kappadelta.org/";
            }
            else if (button.tag == 71) {
                webView.loadUrl = @"https://www.kappakappagamma.org/kappa/";
            }
            else if (button.tag == 72) {
                webView.loadUrl = @"https://www.pibetaphi.org/pibetaphi/";
            }
            else if (button.tag == 73) {
                webView.loadUrl = @"http://www.phimu.org/Home";
            }
            else if (button.tag == 74) {
                webView.loadUrl = @"https://sigmadeltatau.org/";
            }
            else if (button.tag == 75) {
                webView.loadUrl = @"http://www.angelfire.com/pa5/kapparho/";
            }
            else if (button.tag == 76) {
                webView.loadUrl = @"http://www.sigmakappa.org/";
            }
            else if (button.tag == 77) {
                webView.loadUrl = @"http://www.sigmalambdagamma.com/";
            }
            else if (button.tag == 78) {
                webView.loadUrl = @"http://www.sigmalambdaupsilon.org/";
            }
            else if (button.tag == 79) {
                webView.loadUrl = @"http://national.sigmaomicronpi.com/";
            }
            else if (button.tag == 80) {
                webView.loadUrl = @"http://www.trisigma.org/Home.mvc";
            }
            else if (button.tag == 81) {
                webView.loadUrl = @"http://www.zphib1920.org/";
            }
            else if (button.tag == 82) {
                webView.loadUrl = @"https://www.zetataualpha.org/cms400min/";
            }
        }
        else if ([self.categoryLabel.text isEqualToString:@"Nightlife"]) {
            
            if (button.tag == 0) {
                webView.loadUrl = @"http://www.yelp.com/search?cflt=restaurants&find_loc=State+College%2C+PA";
            }
            else if (button.tag == 1) {
                webView.loadUrl = @"http://www.statecollege.com/business/b/bars---nightclubs,30/";
            }
            else if (button.tag == 2) {
                webView.loadUrl = @"http://www.statecollege.com/bartour/";
            }
            else if (button.tag == 3) {
                webView.loadUrl = @"http://shopnittanymall.com/";
            }
            else if (button.tag == 4) {
                webView.loadUrl = @"https://www.uecmovies.com/theatres/details/1012";
            }
            else if (button.tag == 5) {
                webView.loadUrl = @"https://www.uecmovies.com/theatres/details/1011";
            }
            else if (button.tag == 6) {
                webView.loadUrl = @"http://thestatetheatre.org/";
            }
            else if (button.tag == 7) {
                webView.loadUrl = @"http://www.statecollege.com/outdoor-guide/";
            }
            else if (button.tag == 8) {
                webView.loadUrl = @"http://www.statecollege.com/performances/";
            }
            else if (button.tag == 9) {
                webView.loadUrl = @"http://www.northlandbowl.com/";
            }
        }
        else if ([self.categoryLabel.text isEqualToString:@"Parking & Transportation"]) {
            
            if (button.tag == 1) {
                webView.loadUrl = @"http://www.catabus.com/";
            }
            else if (button.tag == 2) {
                webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/System%20Map/index.html";
            }
            else if (button.tag == 4) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=1";
            }
            else if (button.tag == 5) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=2";
            }
            else if (button.tag == 6) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=3";
            }
            else if (button.tag == 7) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=4";
            }
            else if (button.tag == 8) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=19";
            }
            else if (button.tag == 9) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=20";
            }
            else if (button.tag == 10) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=21";
            }
            else if (button.tag == 11) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=22";
            }
            else if (button.tag == 12) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=23";
            }
            else if (button.tag == 13) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=24";
            }
            else if (button.tag == 14) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=25";
            }
            else if (button.tag == 15) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=26";
            }
            else if (button.tag == 16) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=27";
            }
            else if (button.tag == 17) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=28";
            }
            else if (button.tag == 18) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=29";
            }
            else if (button.tag == 19) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=30";
            }
            else if (button.tag == 20) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=48";
            }
            else if (button.tag == 21) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=49";
            }
            else if (button.tag == 22) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=31";
            }
            else if (button.tag == 23) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=32";
            }
            else if (button.tag == 24) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=33";
            }
            else if (button.tag == 25) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=34";
            }
            else if (button.tag == 26) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=52";
            }
            else if (button.tag == 27) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=35";
            }
            else if (button.tag == 28) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=54";
            }
            else if (button.tag == 29) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=39";
            }
            else if (button.tag == 30) {
                webView.loadUrl = @"http://m.psu.edu/shuttleschedule/?busid=40";
            }
            else if (button.tag == 31) {
                webView.loadUrl = @"http://www.catabus.com/ServiceSchedules/CATABUS/CommunityService/FootballShuttle/index.html";
            }
            else if (button.tag == 33) {
                webView.loadUrl = @"http://www.transportation.psu.edu/transportation/maps/parking-maps/index.cfm";
            }
            else if (button.tag == 34) {
                webView.loadUrl = @"http://www.transportation.psu.edu/transportation/parking/students/register-vehicle.cfm";
            }
            else if (button.tag == 35) {
                webView.loadUrl = @"http://www.transportation.psu.edu/transportation/parking/students/student-permits.cfm";
            }
            else if (button.tag == 36) {
                webView.loadUrl = @"http://www.transportation.psu.edu/transportation/parking/students/student-motorcycles.cfm";
            }
            else if (button.tag == 38) {
                webView.loadUrl = @"https://downtownstatecollege.com/pages/parking#ParkingGarages";
            }
        }
        else if ([self.categoryLabel.text isEqualToString:@"Sports & Fitness"]) {
            
            if (button.tag == 0) {
                webView.loadUrl = @"https://teamexchange.ticketmaster.com/html/eventlist.htmI?l=EN&team=psustud";
            }
            else if (button.tag == 1) {
                webView.loadUrl = @"http://www.gopsusports.com/";
            }
            else if (button.tag == 2) {
                webView.loadUrl = @"http://www.gopsusports.com/calendar/events/";
            }
            else if (button.tag == 3) {
                webView.loadUrl = @"http://www.athletics.psu.edu/psustrength/index.asp";
            }
            else if (button.tag == 4) {
                webView.loadUrl = @"http://www.athletics.psu.edu/fitness/classes.html";
            }
            else if (button.tag == 5) {
                webView.loadUrl = @"http://sites.psu.edu/clubsports/";
            }
            else if (button.tag == 6) {
                webView.loadUrl = @"http://www.athletics.psu.edu/imsports/";
            }
        }
        else if ([self.categoryLabel.text isEqualToString:@"Student Health"]) {
            
            if (button.tag == 0) {
                webView.loadUrl = @"http://studentaffairs.psu.edu/health/";
            }
            else if (button.tag == 1) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148634463"]];
            }
            else if (button.tag == 2) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8148630074"]];
            }
            else if (button.tag == 3) {
                webView.loadUrl = @"http://www.mountnittany.org/medical-facilities/mount-nittany-medical-center/";
            }
            else if (button.tag == 4) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:8142317000"]];
            }
        }
}


@end
