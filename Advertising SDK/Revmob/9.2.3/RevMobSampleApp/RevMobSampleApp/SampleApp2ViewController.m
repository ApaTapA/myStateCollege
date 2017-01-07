#import "SampleApp2ViewController.h"
#import "SampleApp3ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface SampleApp2ViewController () {
    int yCoordinateControl;
    
    RevMobFullscreen *fullscreen;
    //You could also declare it this way:
    //@property (nonatomic, strong)RevMobFullscreen *fullscreen;
}

@property (strong, nonatomic) UIScrollView *scroll;

- (UIImage *)imageWithColor:(UIColor *)color;
- (void)createButtonWithName:(NSString *)name andSelector:(SEL)selector;
- (void)addVerticalSpace;


@end

@implementation SampleApp2ViewController

- (id)init {
    self = [super init];
    if (self) {
        yCoordinateControl = 10;
        _scroll = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    }
    return self;
}

#pragma mark Layout methods

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
    [self startSampleApp2Session];
    
    //[self startingAds] is the same method that is called on the withSuccessHandler of our startSessionWithAppID
    //We'll call it here to emulate withSuccessHandler's behaviour on our App, since the session's already started in the first SampleAppViewController.
    //You can remove [self startingAds] from here and use it on startSessionWithAppID:withSuccessHandler
    [self startingAds];
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
    
    [self createButtonWithName:@"Next example" andSelector:@selector(goToSampleApp3)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Try Start Session again" andSelector:@selector(startSampleApp2Session)];
    [self createButtonWithName:@"Show loaded Fullscreen" andSelector:@selector(showPreLoadedFullscreen)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Click to open ad Link" andSelector:@selector(openAdLink)];
    [self createButtonWithName:@"Click to show a Pop Up ad" andSelector:@selector(showPopup)];
    [self createButtonWithName:@"Create an ad Button" andSelector:@selector(addAdButton)];
    [self addVerticalSpace];
    
    [self.scroll setBackgroundColor:[UIColor whiteColor]];
    
    self.scroll.contentSize = CGSizeMake(320,yCoordinateControl);
}


#pragma mark RevMob methods

- (void)startSampleApp2Session {
    [RevMobAds startSessionWithAppID:REVMOB_ID
                  withSuccessHandler:^{
                      NSLog(@"Session started with block");
                      [self startingAds];
                  } andFailHandler:^(NSError *error) {
                      NSLog(@"Session failed to start with block");
                      [self printEnvironmentInformation];
                  }];
}

- (void) startingAds {
    [self loadFullscreen];
    [self showBanner];
}

- (void)loadFullscreen {
    fullscreen = [[RevMobAds session] fullscreen];
    [fullscreen loadAd];
}

- (void)showPreLoadedFullscreen{
    if (fullscreen) [fullscreen showAd];
}

- (void)showBanner {
    [[RevMobAds session] showBanner];
}

- (void)showPopup {
    [[RevMobAds session] showPopup];
}

- (void)openAdLink {
    [[RevMobAds session] openLink];
}

- (void)addAdButton {
    RevMobButton *button = [[RevMobAds session] buttonUnloaded];
    
    [button setFrame:CGRectMake(10, yCoordinateControl, 300, 40)];
    [self.scroll addSubview:button];
    [button setTitle:@"More Games" forState:UIControlStateNormal];
    yCoordinateControl += 50;
    self.scroll.contentSize = CGSizeMake(320,yCoordinateControl);
}

- (void)printEnvironmentInformation {
    [[RevMobAds session] printEnvironmentInformation];
}


#pragma mark - Others

- (void) goToSampleApp3{
    [[RevMobAds session] hideBanner];
    UIViewController *sample3=[[SampleApp3ViewController alloc] init];
    [self.navigationController pushViewController:sample3 animated:YES];
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
