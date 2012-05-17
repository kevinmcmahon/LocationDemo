//
//  MapViewController.m
//  LocationDemo
//
//  Created by Kevin McMahon on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "RMMapBoxSource.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView = _mapView;

static int METERS_PER_MILE = 1609;

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
    _mapView = [[RMMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 400) andTilesource:[[RMMapBoxSource alloc] initWithReferenceURL:[NSURL URLWithString:@"http://a.tiles.mapbox.com/v3/kevinmcmahon.map-ceoj9351.jsonp"]] centerCoordinate:CLLocationCoordinate2DMake(41.88209,-87.62784) zoomLevel:15 maxZoomLevel:17 minZoomLevel:14 backgroundImage:[UIImage imageNamed:@"background"]];
    _mapView.adjustTilesForRetinaDisplay = YES;
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.distanceFilter = 50.0;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    _locationManager.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    [self.view addSubview:self.mapView];

    if ([CLLocationManager locationServicesEnabled]) {
        LogDebug(@"Location services enabled.");
        CLLocationCoordinate2D theBean = CLLocationCoordinate2DMake(41.882669, -87.623297);
        CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:theBean radius:1600.0 identifier:@"Cloud Gate"];
        [_locationManager startMonitoringForRegion:region];
        [_locationManager startUpdatingLocation];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 41.88209;
    zoomLocation.longitude = -87.62784;

//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation,
//            0.5 * METERS_PER_MILE,
//            0.5 * METERS_PER_MILE);
//
//    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
//
//    [self.mapView setRegion:adjustedRegion animated:YES];
//    [self.mapView setShowsUserLocation:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    LogDebug(@"%@ failed with:\n%@", region.identifier, error);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    LogDebug(@"starting to monitor for %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    LogDebug(@"Entered Region - %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    LogDebug(@"%@", error.localizedFailureReason);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    LogDebug(@"Location : %f,%f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
}

@end
