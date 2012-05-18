//
//  LocationManager.m
//  LocationDemo
//
//  Created by Kevin McMahon on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

-(id)init {
    self = [super init];
    if(self) {
        self.distanceFilter = 10;
        self.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.delegate = self;
    }
    return self;
}

#pragma CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    LogDebug(@"%@", error.localizedFailureReason);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    LogDebug(@"starting to monitor for %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    LogDebug(@"Entered Region - %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    LogDebug(@"Exited Region - %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    LogDebug(@"%@ failed with:\n%@", region.identifier, error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    LogDebug(@"Location : %f,%f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    for(CLRegion *region in manager.monitoredRegions) {
        if ([region containsCoordinate:newLocation.coordinate] && ![region containsCoordinate:oldLocation.coordinate]) {            
            LogDebug(@"Entered %@",region.identifier);
        } else if (![region containsCoordinate:newLocation.coordinate] && [region containsCoordinate:oldLocation.coordinate]) {            
            LogDebug(@"Exited %@",region.identifier);
        }
    }
}

@end
