//
//  LocationsVC.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 8/2/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "LocationsVC.h"
#import "AcademicVC.h"
#import "SWRevealViewController.h"

@interface LocationsVC ()

@end

@implementation LocationsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
        {
            //IPHONE 5/5s/5c
            
            [campusLabel setFrame:CGRectMake(85, 30, 155, 21)];
            [btnAbington setFrame:CGRectMake(57, 63, 65, 65)];
            [btnAltoona setFrame:CGRectMake(127, 63, 65, 65)];
            [btnBeaver setFrame:CGRectMake(197, 63, 65, 65)];
            [btnBerks setFrame:CGRectMake(23, 126, 65, 65)];
            [btnBrandywine setFrame:CGRectMake(93, 126, 65, 65)];
            [btnCarlisle setFrame:CGRectMake(163, 126, 65, 65)];
            [btnDubois setFrame:CGRectMake(233, 126, 65, 65)];
            [btnErie setFrame:CGRectMake(57, 190, 65, 65)];
            [btnFayette setFrame:CGRectMake(127, 190, 65, 65)];
            [btnGreatValley setFrame:CGRectMake(197, 190, 65, 65)];
            [btnGreaterAllegheny setFrame:CGRectMake(23, 253, 65, 65)];
            [btnHarrisburg setFrame:CGRectMake(93,253, 65, 65)];
            [btnHazelton setFrame:CGRectMake(163, 253, 65, 65)];
            [btnHershey setFrame:CGRectMake(233, 253, 65, 65)];
            [btnLehighValley setFrame:CGRectMake(57, 317, 65, 65)];
            [btnMontAlto setFrame:CGRectMake(127, 317, 65, 65)];
            [btnNewKensington setFrame:CGRectMake(197, 317, 65, 65)];
            [btnSchuylkill setFrame:CGRectMake(23, 380, 65, 65)];
            [btnShenango setFrame:CGRectMake(93, 380, 65, 65)];
            [btnUniversityPark setFrame:CGRectMake(163, 380, 65, 65)];
            [btnWilkesBarre setFrame:CGRectMake(233, 380, 65, 65)];
            [btnWorthingtonScranton setFrame:CGRectMake(57, 444, 65, 65)];
            [btnYork setFrame:CGRectMake(197, 444, 65, 65)];
            
            [campusLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:17.0]];
        }
        else if ((int) [[UIScreen mainScreen] bounds].size.height == 736)
        {
            //IPHONE 6/6s Plus
            
            [campusLabel setFrame:CGRectMake(120, 30, 184, 21)];
            [btnAbington setFrame:CGRectMake(67, 73, 90, 90)];
            [btnAltoona setFrame:CGRectMake(167, 73, 90, 90)];
            [btnBeaver setFrame:CGRectMake(267, 73, 90, 90)];
            [btnBerks setFrame:CGRectMake(13, 156, 90, 90)];
            [btnBrandywine setFrame:CGRectMake(113, 156, 90, 90)];
            [btnCarlisle setFrame:CGRectMake(213, 156, 90, 90)];
            [btnDubois setFrame:CGRectMake(313, 156, 90, 90)];
            [btnErie setFrame:CGRectMake(67, 243, 90, 90)];
            [btnFayette setFrame:CGRectMake(167, 243, 90, 90)];
            [btnGreatValley setFrame:CGRectMake(267, 243, 90, 90)];
            [btnGreaterAllegheny setFrame:CGRectMake(13, 333, 90, 90)];
            [btnHarrisburg setFrame:CGRectMake(113,333, 90, 90)];
            [btnHazelton setFrame:CGRectMake(213, 333, 90, 90)];
            [btnHershey setFrame:CGRectMake(313, 333, 90, 90)];
            [btnLehighValley setFrame:CGRectMake(67, 424, 90, 90)];
            [btnMontAlto setFrame:CGRectMake(167, 424, 90, 90)];
            [btnNewKensington setFrame:CGRectMake(267, 424, 90, 90)];
            [btnSchuylkill setFrame:CGRectMake(13, 522, 90, 90)];
            [btnShenango setFrame:CGRectMake(113, 522, 90, 90)];
            [btnUniversityPark setFrame:CGRectMake(213, 522, 90, 90)];
            [btnWilkesBarre setFrame:CGRectMake(313, 522, 90, 90)];
            [btnWorthingtonScranton setFrame:CGRectMake(67, 614, 90, 90)];
            [btnYork setFrame:CGRectMake(267, 614, 90, 90)];
            
            [campusLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:20.0]];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
        {
            //IPHONE 4
            
            [campusLabel setFrame:CGRectMake(92, 30, 142, 21)];
            [btnAbington setFrame:CGRectMake(76, 63, 55, 55)];
            [btnAltoona setFrame:CGRectMake(136, 63, 55, 55)];
            [btnBeaver setFrame:CGRectMake(196, 63, 55, 55)];
            [btnBerks setFrame:CGRectMake(43, 118, 55, 55)];
            [btnBrandywine setFrame:CGRectMake(103, 118, 55, 55)];
            [btnCarlisle setFrame:CGRectMake(163, 118, 55, 55)];
            [btnDubois setFrame:CGRectMake(223, 118, 55, 55)];
            [btnErie setFrame:CGRectMake(76, 173, 55, 55)];
            [btnFayette setFrame:CGRectMake(136, 173, 55, 55)];
            [btnGreatValley setFrame:CGRectMake(196, 173, 55, 55)];
            [btnGreaterAllegheny setFrame:CGRectMake(43, 228, 55, 55)];
            [btnHarrisburg setFrame:CGRectMake(103,228, 55, 55)];
            [btnHazelton setFrame:CGRectMake(163, 228, 55, 55)];
            [btnHershey setFrame:CGRectMake(223, 228, 55, 55)];
            [btnLehighValley setFrame:CGRectMake(76, 283, 55, 55)];
            [btnMontAlto setFrame:CGRectMake(136, 283, 55, 55)];
            [btnNewKensington setFrame:CGRectMake(196, 283, 55, 55)];
            [btnSchuylkill setFrame:CGRectMake(43, 338, 55, 55)];
            [btnShenango setFrame:CGRectMake(103, 338, 55, 55)];
            [btnUniversityPark setFrame:CGRectMake(163, 338, 55, 55)];
            [btnWilkesBarre setFrame:CGRectMake(223, 338, 55, 55)];
            [btnWorthingtonScranton setFrame:CGRectMake(76, 393, 55, 55)];
            [btnYork setFrame:CGRectMake(196, 393, 55, 55)];
            
            [campusLabel setFont:[UIFont fontWithName:@"Hoefler Text" size:15.0]];
        }
        else if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
        {
            //IPHONE 6/6S
            [campusLabel setFrame:CGRectMake(95, 31, 184, 21)];
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
    // Dispose of any resources that can be recreated.
}

-(IBAction)selectUniversityPark:(id)sender
{
    if ([_categoryType isEqualToString:@"Academic"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"academic"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([_categoryType isEqualToString:@"campusDining"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"campusDining"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([_categoryType isEqualToString:@"campusInformation"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"campusInformation"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([_categoryType isEqualToString:@"newsEvents"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"newsEvents"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([_categoryType isEqualToString:@"campusPolice"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"campusPolice"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([_categoryType isEqualToString:@"greeklife"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"greeklife"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([_categoryType isEqualToString:@"nightlife"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"nightlife"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([_categoryType isEqualToString:@"parkingTransportation"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"parkingTransportation"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([_categoryType isEqualToString:@"sportsFitness"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"sportsFitness"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
    else if ([_categoryType isEqualToString:@"studentHealth"])
    {
        NSString * storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"studentHealth"];
        [self.revealViewController pushFrontViewController:vc animated:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AcademicVC *academic = [segue destinationViewController];
    
    UIButton *button = sender;
    
    if (button.tag == 20) {
        academic.campusLocation = @"UP";
    }
}

@end
