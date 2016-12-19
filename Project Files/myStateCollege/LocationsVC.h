//
//  LocationsVC.h
//  myStateCollege
//
//  Created by Thomas Diffendal on 8/2/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationsVC : UIViewController

{
    IBOutlet UILabel *campusLabel;
    
    IBOutlet UIImageView *btnAbington;
    IBOutlet UIImageView *btnAltoona;
    IBOutlet UIImageView *btnBeaver;
    IBOutlet UIImageView *btnBerks;
    IBOutlet UIImageView *btnBrandywine;
    IBOutlet UIImageView *btnCarlisle;
    IBOutlet UIImageView *btnDubois;
    IBOutlet UIImageView *btnErie;
    IBOutlet UIImageView *btnFayette;
    IBOutlet UIImageView *btnGreatValley;
    IBOutlet UIImageView *btnGreaterAllegheny;
    IBOutlet UIImageView *btnHarrisburg;
    IBOutlet UIImageView *btnHazelton;
    IBOutlet UIImageView *btnHershey;
    IBOutlet UIImageView *btnLehighValley;
    IBOutlet UIImageView *btnMontAlto;
    IBOutlet UIImageView *btnNewKensington;
    IBOutlet UIImageView *btnSchuylkill;
    IBOutlet UIImageView *btnShenango;
    IBOutlet UIImageView *btnWilkesBarre;
    IBOutlet UIImageView *btnWorthingtonScranton;
    IBOutlet UIImageView *btnYork;

    IBOutlet UIButton *btnUniversityPark;

}

@property (strong, nonatomic) NSString *categoryType;

-(IBAction)selectUniversityPark:(id)sender;

@end
