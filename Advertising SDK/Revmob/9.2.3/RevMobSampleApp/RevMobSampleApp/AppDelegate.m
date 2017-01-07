#import "AppDelegate.h"
#import "SampleAppViewController.h"
#import "SampleApp2ViewController.h"
#import "SampleApp3ViewController.h"
#import "SampleAppFullViewController.h"
#import <RevMobAds/RevMobAds.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize navigationController = _navigationController;

- (void)dealloc {
    [_window release];
    [_viewController release];
    [_navigationController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIViewController *myViewController = [[SampleAppViewController alloc] init];
    _navigationController = [[UINavigationController alloc]
                            initWithRootViewController:myViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = _navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    
//    self.viewController = [[[SampleAppViewController alloc] init] autorelease];
//    [self.window setRootViewController:self.viewController];
//    
//    [self.window makeKeyAndVisible];
//    
//    return YES;
//}

@end
