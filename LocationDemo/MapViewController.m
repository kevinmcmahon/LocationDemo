//
//  MapViewController.m
//  LocationDemo
//
//  Created by Kevin McMahon on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView = _mapView;

- (id)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    // Do Init
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 360)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.mapView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.mapView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    LogDebug(@"Entered Region - %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    LogDebug(@"Exited Region - %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    LogDebug(@"%@ Registered.", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    LogDebug(@"Location manager failed with an error\n%@", [error localizedDescription]);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    LogDebug(@"location updated");
}
@end
