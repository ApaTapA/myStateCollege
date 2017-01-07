#import "SampleAppViewController.h"
#import "SampleApp2ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface SampleAppViewController () {
    int yCoordinateControl;
}

@property (nonatomic, strong)RevMobFullscreen *fullscreen;

@property (strong, nonatomic) UIScrollView *scroll;

- (UIImage *)imageWithColor:(UIColor *)color;
- (void)createButtonWithName:(NSString *)name andSelector:(SEL)selector;
- (void)addVerticalSpace;


@end

@implementation SampleAppViewController

- (id)init {
    self = [super init];
    if (self) {
        yCoordinateControl = 10;
        _scroll = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    }
    return self;
}

#pragma mark App Layout Methods

- (void)createButtonWithName:(NSString *)name andSelector:(SEL)selector {
    UIButton *button = [[[UIButton alloc] initWithFrame:CGRectMake(10, yCoordinateControl, 300, 40)] autorelease];

    [button setTitle:name forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];

    UIImage *background1 = [self imageWithColor:[UIColor grayColor]];
    UIImage *background2 = [self imageWithColor:[UIColor lightGrayColor]];
    [button setBackgroundImage:background1 forState:UIControlStateNormal];
    [button setBackgroundImage:background2 forState:UIControlStateSelected];

    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;

    [self.scroll addSubview:button];
    yCoordinateControl += 50;
}

- (void)addVerticalSpace {
    yCoordinateControl += 20;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startSampleAppSession];
    self.view.backgroundColor = [UIColor whiteColor];

#ifdef __IPHONE_7_0
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        CGRect statusBar, frame;
        CGRectDivide(self.view.bounds, &statusBar, &frame, 20, CGRectMinYEdge);
        self.scroll.frame = frame;
    } else {
        self.scroll.frame = self.view.bounds;
    }
#else
    self.scroll.frame = self.view.bounds;
#endif

    self.scroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.scroll];

    [self createButtonWithName:@"Next example" andSelector:@selector(goToSampleApp2)];
    [self createButtonWithName:@"Try again" andSelector:@selector(startSampleAppSession)];
    
    [self.scroll setBackgroundColor:[UIColor whiteColor]];
    self.scroll.contentSize = CGSizeMake(320,yCoordinateControl);
}

#pragma mark RevMob Methods

- (void) startSampleAppSession {
    [RevMobAds startSessionWithAppID:REVMOB_ID
     withSuccessHandler:^{
         NSLog(@"Session started with block");
         [[RevMobAds session] showFullscreen];
     } andFailHandler:^(NSError *error) {
         NSLog(@"Session failed to start with block");
         [[RevMobAds session] printEnvironmentInformation];
     }];
}

- (void)printEnvironmentInformation {
    [[RevMobAds session] printEnvironmentInformation];
}


#pragma mark - Others

- (void) goToSampleApp2{
    UIViewController *sample2=[[SampleApp2ViewController alloc] init];
    [self.navigationController pushViewController:sample2 animated:YES];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    NSLog(@"should auto rotate to interface orientation");
    // Test with all orientations
    return YES;
    
    // Test only with Portrait mode
    //    return (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
    
    // Test only with Landscape mode
    //return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)dealloc {
    [_scroll release], _scroll = nil;

    [super dealloc];
}

@end
