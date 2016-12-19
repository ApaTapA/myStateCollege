////
////  ViewController.m
////  myStateCollege
////
////  Created by Thomas Diffendal on 7/28/15.
////  Copyright (c) 2015 ApaTapA. All rights reserved.
////
//
#import "ViewController.h"
#import <Firebase/Firebase.h>
#import "SWRevealViewController.h"

@import FirebaseStorage;

@interface ViewController ()
{
    NSMutableArray *universityParkAcademic;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) FIRStorageReference *storageRef;

@end



@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.openSlideOut setTarget: self.revealViewController];
        [self.openSlideOut setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    
//    NSMutableArray *ImageArray = [[NSMutableArray alloc]initWithObjects:
//                                   @"https://firebasestorage.googleapis.com/v0/b/project-2429635295109282119.appspot.com/o/link_button_images%2Flink_angel.png?alt=media&token=10c5364d-e73a-436d-9cfb-9e0bf58d6bea"
//                                  ,@"https://firebasestorage.googleapis.com/v0/b/project-2429635295109282119.appspot.com/o/link_button_images%2Flink_canvas.png?alt=media&token=fd967196-e1e9-4a72-83ef-e6fc0dac8205"
//                                  ,@"https://firebasestorage.googleapis.com/v0/b/project-2429635295109282119.appspot.com/o/link_button_images%2Flink_webmail.png?alt=media&token=42e26ca0-9b5f-40bb-8ef8-ddf1c1834789"
//                                  ,@"https://firebasestorage.googleapis.com/v0/b/project-2429635295109282119.appspot.com/o/link_button_images%2Flink_elion.png?alt=media&token=1a9be097-3d26-45a2-93b4-edd8a6afa6e4"
//                                  ,@"https://firebasestorage.googleapis.com/v0/b/project-2429635295109282119.appspot.com/o/link_button_images%2Flink_lionpath.png?alt=media&token=a789c540-dc34-4eab-af25-b2d8be75150a"
//                                  ,@"https://firebasestorage.googleapis.com/v0/b/project-2429635295109282119.appspot.com/o/link_button_images%2Flink_eliving.png?alt=media&token=bfcbcd93-e05a-4fc5-a975-e5a1adf15af4"
//                                  ,@"https://firebasestorage.googleapis.com/v0/b/project-2429635295109282119.appspot.com/o/link_button_images%2Flink_id_card.png?alt=media&token=1432b803-b769-4372-a284-81be2e555663"
//                                  ,@"https://firebasestorage.googleapis.com/v0/b/project-2429635295109282119.appspot.com/o/link_button_images%2Flink_box.png?alt=media&token=b60bb24c-bfb3-45cc-ae97-06e7fe971a1b",nil];

    
//    //Getting Images from Url
//    for(int i = 0; i < [ImageArray count]; i++)
//    {
//        UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
//                                                  [NSURL URLWithString:[ImageArray objectAtIndex:i]]]];
//        
//        //After converted, replace the same array with the new UIImage Object
//        [ImageArray replaceObjectAtIndex:i withObject: image];
//    }
//    
//    int positionX = 13;
//    
//    //Load images on ImageView
//    int XX=0;
//    for (int k=0; k<[ImageArray count]; k++)
//    {
//        UIImageView *imgVw=[[UIImageView alloc]initWithFrame:CGRectMake(10, positionX, 355, 55)];
//        [imgVw setImage:[ImageArray objectAtIndex:k]];
//        [self.view addSubview:imgVw];
//        
//        positionX =+ 67;
//    
//    }
    
//    int positionX= 13;
//    
//    for (int i = 0; i < [universityParkAcademic count] ; i++) {
//        
//        ViewController *universityPark = [universityParkAcademic objectAtIndex:i];
//        
//        UIButton *universityParkButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [universityParkButton setImage:[UIImage imageNamed:universityPark] forState:UIControlStateNormal];
//        [universityParkButton setTag:i];
//        
//        universityParkButton.frame = CGRectMake(10, positionX, 355, 55);
//        positionX +=67;
//
//    
    
    NSURL * imageURL = [NSURL URLWithString:@"https://firebasestorage.googleapis.com/v0/b/project-2429635295109282119.appspot.com/o/link_button_images%2Flink_angel.png?alt=media&token=10c5364d-e73a-436d-9cfb-9e0bf58d6bea"];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    
    
    [_trialButton setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    _angelImage.image = image;
        
    
//    // Load image url on a Mutable Array.
//    NSMutableArray *ImageArray = [[NSMutableArray alloc]initWithObjects:@"http://www.joomlaworks.net/images/demos/galleries/abstract/7.jpg",@"http://www.last-video.com/wp-content/uploads/2013/11/superbe-image-de-poissons-sous-l-eau.jpg", nil];
//    
//    //Getting Images from Url
//    for(int i = 0; i < [ImageArray count]; i++)
//    {
//        UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
//                                                  [NSURL URLWithString:[ImageArray objectAtIndex:i]]]];
//        
//        //After converted, replace the same array with the new UIImage Object
//        [ImageArray replaceObjectAtIndex:i withObject: image];
//    }
//    
//    //Load images on ImageView
//    int XX=0;
//    for (int k=0; k<[ImageArray count]; k++)
//    {
//        UIImageView *imgVw=[[UIImageView alloc]initWithFrame:CGRectMake(XX, 0, 200, 300)];
//        [imgVw setImage:[ImageArray objectAtIndex:k]];
//        [self.view addSubview:imgVw];
//        XX=XX+200;
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
