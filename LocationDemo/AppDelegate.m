//
//  AppDelegate.m
//  LocationDemo
//
//  Created by Kevin McMahon on 5/9/12.
//  Copyright (c) 2012 Kevin McMahon. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"

@implementation AppDelegate {
    MapViewController *mvc;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    id location = [launchOptions valueForKey:UIApplicationLaunchOptionsLocationKey];
    if (location) {
        [self scheduleNotificationForLocationUpdate];
    }

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    mvc = [[MapViewController alloc] init];
    [self.window addSubview:mvc.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)scheduleNotificationForLocationUpdate {
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.fireDate = [NSDate date];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];

    localNotif.alertBody = [NSString stringWithFormat:@"Region Crossed"];
    localNotif.alertAction = @"Ok";

    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;

    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}
@end
