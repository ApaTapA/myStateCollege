#import "SampleApp3ViewController.h"
#import "SampleAppFullViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface SampleApp3ViewController () {
    int yCoordinateControl;
    
    RevMobBanner *banner;
}

@property (nonatomic, strong) RevMobFullscreen *fullscreen,*video;
@property (strong, nonatomic) UIScrollView *scroll;

- (UIImage *)imageWithColor:(UIColor *)color;
- (void)createButtonWithName:(NSString *)name andSelector:(SEL)selector;
- (void)addVerticalSpace;


@end

@implementation SampleApp3ViewController

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
    [self startSampleApp3Session];
    
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

    [self createButtonWithName:@"Next example" andSelector:@selector(goToSampleAppFull)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Try Start Session again" andSelector:@selector(startSampleApp3Session)];
    
    [self createButtonWithName:@"Show loaded Fullscreen" andSelector:@selector(showPreLoadedFullscreen)];
    [self createButtonWithName:@"Show loaded video" andSelector:@selector(showVideo)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Click to open ad Link" andSelector:@selector(openAdLink)];
    [self createButtonWithName:@"Click to show a Pop Up ad" andSelector:@selector(showPopup)];
    [self createButtonWithName:@"Create an ad Button" andSelector:@selector(addAdButton)];
    [self addVerticalSpace];
    [self.scroll setBackgroundColor:[UIColor whiteColor]];

    self.scroll.contentSize = CGSizeMake(320,yCoordinateControl);
}


- (void)fillUserInfo
{
    RevMobAds *revmob = [RevMobAds session];
    revmob.userGender = RevMobUserGenderFemale;
    revmob.userAgeRangeMin = 18;
    revmob.userAgeRangeMax = 21;
    revmob.userBirthday = [NSDate dateWithTimeIntervalSince1970:0];
    revmob.userPage = @"twitter.com/revmob";
    revmob.userInterests = @[@"mobile", @"iPhone", @"apps"];
    // The code below is just to trigger authorization for Location Services
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager setDistanceFilter: kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy: kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
    [locationManager stopUpdatingLocation];

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


#pragma mark RevMob methods

- (void)startSampleApp3Session {
    [RevMobAds startSessionWithAppID:REVMOB_ID
     withSuccessHandler:^{
         NSLog(@"Session started with block");
     } andFailHandler:^(NSError *error) {
         NSLog(@"Session failed to start with block");
     }];
}

- (void) startingAds {
    [self showBanner];
    [self loadFullscreen];
    [self loadVideo];
}

- (void)printEnvironmentInformation {
    [[RevMobAds session] printEnvironmentInformation];
}

- (void)showBanner {
    //Creating the banner with delegate
    banner = [[RevMobAds session] banner];
    banner.delegate = self;
    [banner showAd];
}

- (void)openAdLink {
    [[RevMobAds session] openAdLinkWithDelegate:self];
}

- (void)loadFullscreen {
    self.fullscreen = [[RevMobAds session] fullscreen];
    self.fullscreen.delegate = self;
    [self.fullscreen loadAd];
}

- (void)showPreLoadedFullscreen{
    if (self.fullscreen) [self.fullscreen showAd];
}

-(void) loadVideo {
    self.video = [[RevMobAds session] fullscreen];
    self.video.delegate = self;
    [self.video loadVideo];
}

-(void) showVideo{
    if(self.video) [self.video showVideo];
}

- (void)showPopup {
    [[RevMobAds session] showPopup];
}

- (void)addAdButton {
    RevMobButton *button = [[RevMobAds session] buttonUnloaded];
    
    [button setFrame:CGRectMake(10, yCoordinateControl, 300, 40)];
    [self.scroll addSubview:button];
    [button setTitle:@"Free Games" forState:UIControlStateNormal];
    yCoordinateControl += 50;
    self.scroll.contentSize = CGSizeMake(320,yCoordinateControl);
}

#pragma mark - RevMobAdsDelegate methods


/////Fullscreen Listeners/////

-(void) revmobUserDidClickOnFullscreen:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] User clicked in the Fullscreen.");
}
-(void) revmobFullscreenDidReceive:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Fullscreen loaded.");
}
-(void) revmobFullscreenDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Fullscreen failed: %@. ID: %@", error, placementId);
}
-(void) revmobFullscreenDidDisplay:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Fullscreen displayed.");
}
-(void) revmobUserDidCloseFullscreen:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] User closed the fullscreen.");
}

///Banner Listeners///

-(void) revmobUserDidClickOnBanner:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] User clicked in the Banner.");
}
-(void) revmobBannerDidReceive:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Banner loaded.");
}
-(void) revmobBannerDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Banner failed: %@. ID: %@", error, placementId);
}
-(void) revmobBannerDidDisplay:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Banner displayed.");
}


/////Video Listeners/////
-(void)revmobVideoDidLoad:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Video loaded. ID: %@", placementId);
}

-(void)revmobVideoNotCompletelyLoaded:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Video not completely loaded. ID: %@", placementId);
}

-(void)revmobVideoDidStart:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Video started. ID: %@", placementId);
}

-(void)revmobVideoDidFinish:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Video started. ID: %@", placementId);
}

#pragma mark - Others

- (void) goToSampleAppFull{
    [banner hideAd];
    UIViewController *sampleFull=[[SampleAppFullViewController alloc] init];
    [self.navigationController pushViewController:sampleFull animated:YES];
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

- (void)dealloc {
    [_scroll release], _scroll = nil;

    [super dealloc];
}

@end
