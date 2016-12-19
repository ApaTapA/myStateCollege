//
//  SlideCustomCell.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/31/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "SlideCustomCell.h"

//Create Properties in .m file to Protect These
@interface SlideCustomCell ()

//@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
//@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;


@end

@implementation SlideCustomCell



@synthesize iconImage = _iconImage, categoryLabel = _categoryLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    UIView * selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:94.0/255.0 green:96.0/255.0 blue:115.0/255.0 alpha:1.0]];
    [self setSelectedBackgroundView:selectedBackgroundView];
}

@end
