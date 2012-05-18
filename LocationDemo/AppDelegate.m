//
//  AppDelegate.m
//  LocationDemo
//
//  Created by Kevin McMahon on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"
#import "LocationManager.h"

@implementation AppDelegate {
    MapViewController *mvc;
    LocationManager *locationManager;
}

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (getenv("NSZombieEnabled"))
        NSLog(@"NSZombieEnabled!");
    else if (getenv("NSAutoreleaseFreedObjectCheckEnabled"))
        NSLog(@"NSAutoreleaseFreedObjectCheckEnabled enabled!");
    LogDebug(@"Scale : %f",[[UIScreen mainScreen] scale]);
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self initLocationManager];
    
    mvc = [[MapViewController alloc] init];
    [self.window addSubview:mvc.view];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)initLocationManager {
    
    if ([CLLocationManager locationServicesEnabled]) {
        LogDebug(@"Location services enabled.");
        locationManager = [[LocationManager alloc] init];
        if(CLLocationManager.regionMonitoringAvailable && CLLocationManager.regionMonitoringEnabled) {
            LogDebug(@"Region monitoring available and enabled.");
            [self registerRegions];
        }
        [locationManager startUpdatingLocation];
    }
}

-(void)registerRegions {
    CLLocationCoordinate2D theBean = CLLocationCoordinate2DMake(41.882669, -87.623297);
    CLRegion *beanRegion = [[CLRegion alloc] initCircularRegionWithCenter:theBean radius:20.0 identifier:@"Cloud Gate"];
    [locationManager startMonitoringForRegion:beanRegion];
    
    CLLocationCoordinate2D theFountain = CLLocationCoordinate2DMake(41.88148, -87.62373);
    CLRegion *fountainRegion = [[CLRegion alloc] initCircularRegionWithCenter:theFountain radius:100.0 identifier:@"Crown Fountain"];
    [locationManager startMonitoringForRegion:fountainRegion];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
