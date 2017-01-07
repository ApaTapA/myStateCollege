#import "SampleAppFullViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface SampleAppFullViewController () {
    int yCoordinateControl;
}

@property (nonatomic, strong)RevMobFullscreen *fullscreen, *video, *rewardedVideo ;
@property (nonatomic, strong)RevMobBannerView *bannerView;
@property (nonatomic, strong)RevMobBanner *banner,*bannerCompletionBlock;
@property (nonatomic, strong)RevMobAdLink *link;
@property (nonatomic, strong)UIButton *preRollButton;

@property (strong, nonatomic) UIScrollView *scroll;

- (UIImage *)imageWithColor:(UIColor *)color;
- (void)createButtonWithName:(NSString *)name andSelector:(SEL)selector;
- (void)addVerticalSpace;


@end

@implementation SampleAppFullViewController

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
    
    [self startSession];
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
    
    [self createButtonWithName:@"Start Session" andSelector:@selector(startSession)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Print Env Info" andSelector:@selector(printEnvironmentInformation)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Basic Usage: Fullscreen" andSelector:@selector(basicUsageShowFullscreen)];
    [self createButtonWithName:@"Basic Usage: Banner" andSelector:@selector(basicUsageShowBanner)];
    [self createButtonWithName:@"Basic Usage: Hide banner" andSelector:@selector(basicUsageHideBanner)];
    [self createButtonWithName:@"Basic Usage: Release banner" andSelector:@selector(basicUsageReleaseBanner)];
    [self createButtonWithName:@"Basic Usage: Popup" andSelector:@selector(basicUsageShowPopup)];
    [self createButtonWithName:@"Basic Usage: Link" andSelector:@selector(basicUsageOpenAdLink)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Show Fullscreen with delegate" andSelector:@selector(showFullscreenWithDelegate)];
    [self createButtonWithName:@"Pre Load Fullscreen" andSelector:@selector(loadFullscreen)];
    [self createButtonWithName:@"Show pre-loaded fullscreen" andSelector:@selector(showPreLoadedFullscreen)];
    [self createButtonWithName:@"Pre Load Video" andSelector:@selector(loadVideo)];
    [self createButtonWithName:@"Show Video" andSelector:@selector(showVideo)];
    [self createButtonWithName:@"Pre Load Rewarded Video" andSelector:@selector(loadRewardedVideo)];
    [self createButtonWithName:@"Show Rewarded Video" andSelector:@selector(showRewardedVideo)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Load Video with completion block" andSelector:@selector(loadVideoCompletionBlock)];
    [self createButtonWithName:@"Load Rewarded Video with completion block" andSelector:@selector(loadRewardedVideoCompletionBlock)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Show Banner with custom frame" andSelector:@selector(showBannerWithCustomFrame)];
    [self createButtonWithName:@"Hide Banner with custom frame" andSelector:@selector(hideBannerWithCustomFrame)];
    
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Show Banner With Completion Block" andSelector:@selector(showBannerWithCompletionBlock)];
    [self createButtonWithName:@"Hide Banner With Completion Block" andSelector:@selector(hideBannerWithCompletionBlock)];
    [self createButtonWithName:@"Release Banner With Completion Block" andSelector:@selector(releaseBannerWithCompletionBlock)];
    
    [self createButtonWithName:@"Preload Banner" andSelector:@selector(preloadBanner)];
    [self createButtonWithName:@"Show Preloaded Banner" andSelector:@selector(showPreloadedBanner)];
    [self createButtonWithName:@"Hide Preloaded Banner" andSelector:@selector(hidePreloadedBanner)];
    [self createButtonWithName:@"Release Preloaded Banner" andSelector:@selector(releasePreloadedBanner)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Open Ad Link" andSelector:@selector(openAdLink)];
    [self createButtonWithName:@"Load Ad Link" andSelector:@selector(loadAdLink)];
    [self createButtonWithName:@"Open Loaded Ad Link" andSelector:@selector(openLoadedAdLink)];
    [self createButtonWithName:@"Add Ad Button" andSelector:@selector(addAdButton)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Show Popup" andSelector:@selector(showPopup)];
    [self addVerticalSpace];
    
    [self createButtonWithName:@"Close Sample App" andSelector:@selector(closeSampleApp)];
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

#pragma mark Methods to test RevMob Ads

- (void)startSession {
    [RevMobAds startSessionWithAppID:REVMOB_ID
                  withSuccessHandler:^{
                      NSLog(@"Session started with block");
                  } andFailHandler:^(NSError *error) {
                      NSLog(@"Session failed to start with block");
                  }];
}

- (void)printEnvironmentInformation {
    [[RevMobAds session] printEnvironmentInformation];
}

#pragma mark - Basic Usage -

- (void)basicUsageShowFullscreen {
    [[RevMobAds session] showFullscreen];
}

- (void)basicUsageShowBanner {
    [[RevMobAds session] showBanner];
}

- (void)basicUsageHideBanner {
    [[RevMobAds session] hideBanner];
}

-(void)basicUsageReleaseBanner{
    [[RevMobAds session] releaseBanner];
}

- (void)basicUsageShowPopup {
    [[RevMobAds session] showPopup];
}

- (void)basicUsageOpenAdLink {
    [[RevMobAds session] openAdLinkWithDelegate:self];
}

#pragma mark - Advanced mode -


#pragma mark Fullscreen

- (void)showFullscreenWithDelegate {
    RevMobFullscreen *fs = [[RevMobAds session] fullscreen];
    fs.delegate = self;
    [fs showAd];
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

-(void) loadRewardedVideo{
    self.rewardedVideo = [[RevMobAds session] fullscreen];
    self.rewardedVideo.delegate = self;
    [self.rewardedVideo loadRewardedVideo];
}

-(void) showRewardedVideo{
    if(self.rewardedVideo) [self.rewardedVideo showRewardedVideo];
}

-(void) loadVideoCompletionBlock{
    self.video = [[RevMobAds session] fullscreen];
    
    [self.video loadVideoWithSuccessHandler:^(RevMobFullscreen *fs) {
        [self revmobVideoDidLoad:NULL];
        [self.video showVideo];
        [self revmobRewardedVideoDidStart:NULL];
    } andLoadFailHandler:^(RevMobFullscreen *fs, NSError *error) {
        [self revmobVideoDidFailWithError:error onPlacement:NULL];
     } onClickHandler:^{
        [self revmobUserDidClickOnVideo:NULL];
     } onCloseHandler:^{
        [self revmobUserDidCloseVideo:NULL];
     }];
}

-(void) loadRewardedVideoCompletionBlock{
    self.rewardedVideo = [[RevMobAds session] fullscreen];
    [self.rewardedVideo loadRewardedVideoWithSuccessHandler:^(RevMobFullscreen *fs) {
        [self revmobRewardedVideoDidLoad:NULL];
        [self.rewardedVideo showVideo];
        
        [self revmobRewardedVideoDidStart:NULL];
    } andLoadFailHandler:^(RevMobFullscreen *fs, NSError *error) {
        [self revmobRewardedVideoDidFailWithError:error onPlacement:NULL];
    } onCompleteHandler:^{
        [self revmobRewardedVideoDidComplete:NULL];
    }];
}


#pragma mark Banner

- (void)showBannerWithCustomFrame {
    self.bannerView = [[RevMobAds session] bannerView];
    self.bannerView.delegate = self;
    [self.bannerView loadWithSuccessHandler:^(RevMobBannerView *bannerV) {
        //     You can handle it yourself - Beware: this won't call the revmobBannerDidDisplay delegate
        CGFloat width = self.view.bounds.size.width;
        CGFloat height = self.view.bounds.size.height;
        bannerV.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        bannerV.frame = CGRectMake(0, height - 50, width, 50);
        [self.view addSubview:bannerV];
        
        //     Or you can simply use our pre-defined params
        //     [self.bannerView showAd];
    } andLoadFailHandler:^(RevMobBannerView *banner, NSError *error) {
        //Banner failed
    } onClickHandler:^(RevMobBannerView *banner) {
        //Banner clicked
    }];
    
}

- (void)hideBannerWithCustomFrame {
    [self.bannerView removeFromSuperview];
}

-(void) showBannerWithCompletionBlock{
    self.bannerCompletionBlock = [[RevMobAds session] banner];
    [self.bannerCompletionBlock loadWithSuccessHandler:^(RevMobBanner *banner) {
        [banner showAd];
        [self revmobBannerDidReceive:NULL];
    } andLoadFailHandler:^(RevMobBanner *banner, NSError *error) {
        [self revmobBannerDidFailWithError:error onPlacement:NULL];
    } onClickHandler:^(RevMobBanner *banner) {
        [self revmobUserDidClickOnBanner:NULL];
    }];

}

-(void) hideBannerWithCompletionBlock{
    [self.bannerCompletionBlock hideAd];
}

-(void) releaseBannerWithCompletionBlock{
    [self.bannerCompletionBlock releaseAd];
}


#pragma mark Banner Window

- (void)showPreloadedBanner {
    [self.banner showAd];
}

-(void) preloadBanner{
    self.banner = [[RevMobAds session] banner];
    self.banner.delegate = self;
    [self.banner loadAd];
}


- (void)hidePreloadedBanner{
    [self.banner hideAd];
}

-(void) releasePreloadedBanner{
    [self.banner releaseAd];
}


#pragma mark Link

- (void)loadAdLink {
    self.link = [[RevMobAds session] adLink];
    self.link.delegate = self;
    [self.link loadAd];
    
}

- (void)openLoadedAdLink {
    if (self.link) [self.link openLink];
}

- (void)openAdLink {
    [[RevMobAds session] openAdLinkWithDelegate:self];
}

- (void)addAdButton {
    
    RevMobButton *button = [[RevMobAds session] buttonUnloaded];
    
    if(button != nil){
        [button setFrame:CGRectMake(10, yCoordinateControl, 300, 40)];
        [self.scroll addSubview:button];
        [button setTitle:@"Free Games" forState:UIControlStateNormal];
        yCoordinateControl += 50;
        self.scroll.contentSize = CGSizeMake(320,yCoordinateControl);
    }
}

#pragma mark Popup

- (void)showPopup {
     RevMobPopup *popup = [[RevMobAds session] popup];
    popup.delegate = self;
    [popup loadWithSuccessHandler:^(RevMobPopup *popup) {
        [popup showAd];
        //Pop up received
    } andLoadFailHandler:^(RevMobPopup *popup, NSError *error) {
        //Pop up failed to load
    } onClickHandler:^(RevMobPopup *popup) {
        //Pop up clicked
    }];
}

#pragma mark - RevMobAdsDelegate methods



/////Session Listeners/////
- (void)revmobSessionDidStart {
    [self fillUserInfo];
    NSLog(@"[RevMob Sample App] Session started with delegate.");
}

- (void)revmobSessionDidNotStart:(NSError *)error {
    NSLog(@"[RevMob Sample App] Session not started with error: %@", error);
}

/////Native ads Listeners/////

-(void) revmobUserDidClickOnNative:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] User clicked on Native: %@", placementId);
}
-(void) revmobNativeDidReceive:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Native loaded: %@", placementId);
}
-(void) revmobNativeDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Native failed: %@. ID: %@", error, placementId);
}


/////Fullscreen Listeners/////

-(void) revmobUserDidClickOnFullscreen:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] User clicked in the Fullscreen: %@", placementId);
}
-(void) revmobFullscreenDidReceive:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Fullscreen loaded: %@", placementId);
}
-(void) revmobFullscreenDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Fullscreen failed: %@. ID: %@", error, placementId);
}
-(void) revmobFullscreenDidDisplay:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Fullscreen displayed: %@", placementId);
}
-(void) revmobUserDidCloseFullscreen:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] User closed the fullscreen: %@", placementId);
}


///Banner Listeners///

-(void) revmobUserDidClickOnBanner:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] User clicked in the Banner: %@", placementId);
}
-(void) revmobBannerDidReceive:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Banner loaded: %@", placementId);
}
-(void) revmobBannerDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Banner failed: %@. ID: %@", error, placementId);
}
-(void) revmobBannerDidDisplay:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Banner displayed: %@", placementId);
}

/////Video Listeners/////
-(void)revmobVideoDidLoad:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Video loaded: %@", placementId);
}

-(void) revmobVideoDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId{
    NSLog(@"[RevMob Sample App) Video failed with error: %@", error.localizedDescription);
}

-(void)revmobVideoNotCompletelyLoaded:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Video not completely loaded: %@", placementId);
}

-(void)revmobVideoDidStart:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Video started: %@", placementId);
}

-(void)revmobVideoDidFinish:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Video finished: %@", placementId);
}

-(void) revmobUserDidCloseVideo:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Video closed: %@", placementId);
}

-(void) revmobUserDidClickOnVideo:(NSString *)placementId{
    NSLog(@"[RevMob Sample App] Video clicked: %@", placementId);
}



/////Rewarded Video Listeners/////
-(void)revmobRewardedVideoDidLoad:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Rewarded Video loaded: %@", placementId);
}

-(void)revmobRewardedVideoDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Rewarded Video failed to load: %@ with error: %@", placementId, error);
}

-(void)revmobRewardedVideoNotCompletelyLoaded:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Rewarded Video not completely loaded: %@", placementId);
}

-(void)revmobRewardedVideoDidStart:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Rewarded Video started: %@", placementId);
}

-(void)revmobRewardedVideoDidComplete:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Rewarded Video completed: %@", placementId);
}




/////Pop Up Listeners/////

-(void)revmobPopUpDidDisplay:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Pop Up displayed: %@", placementId);
}

-(void)revmobPopUpDidFailWithError:(NSError *)error onPlacement:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Pop Up failed: %@ with error: %@.", placementId, error);
}

-(void)revmobPopUpDidReceive:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Pop Up received: %@", placementId);
}

-(void)revmobUserDidClickOnPopUp:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Pop Up clicked: %@", placementId);
}

-(void)revmobUserDidClosePopUp:(NSString *)placementId {
    NSLog(@"[RevMob Sample App] Pop Up closed: %@", placementId);
}



#pragma mark - Others

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

- (void)closeSampleApp {
    exit(0);
}

@end
