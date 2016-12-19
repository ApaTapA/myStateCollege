//
//  TestURL.m
//  myStateCollege
//
//  Created by Thomas Diffendal on 7/23/16.
//  Copyright © 2016 ApaTapA. All rights reserved.
//

#import "TestURL.h"

@interface TestURL ()

@end

@implementation TestURL

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *ImageArray = [[NSMutableArray alloc]initWithObjects:@"http://www.joomlaworks.net/images/demos/galleries/abstract/7.jpg",@"http://www.last-video.com/wp-content/uploads/2013/11/superbe-image-de-poissons-sous-l-eau.jpg", nil];
    
    //Getting Images from Url
    for(int i = 0; i < [ImageArray count]; i++)
    {
        UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                  [NSURL URLWithString:[ImageArray objectAtIndex:i]]]];
        
        //After converted, replace the same array with the new UIImage Object
        [ImageArray replaceObjectAtIndex:i withObject: image];
    }
    
    //Load images on ImageView
    int positionX = 13;

    for (int k=0; k<[ImageArray count]; k++)
    {
        UIButton *upAcademic = [[UIButton alloc]initWithFrame:CGRectMake(15, positionX, 355, 55)];
        [upAcademic setImage:[ImageArray objectAtIndex:k] forState:UIControlEventTouchUpInside];
        [self.view addSubview:upAcademic];
        positionX +=67;
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
