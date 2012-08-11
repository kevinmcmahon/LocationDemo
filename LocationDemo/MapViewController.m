//
//  MapViewController.m
//  LocationDemo
//
//  Created by Kevin McMahon on 5/9/12.
//  Copyright (c) 2012 Kevin McMahon. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "RegionsViewController.h"

#define MILE_IN_METERS 1609

@implementation MapViewController

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
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];

    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 419, 280, 21)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor blackColor];
    _label.shadowColor = [UIColor lightGrayColor];
    _label.shadowOffset = CGSizeMake(0, 2.0);
    _label.textAlignment = UITextAlignmentCenter;
    _label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
    
    _button = [UIButton buttonWithType:UIButtonTypeInfoDark];
    _button.frame = CGRectMake(260, 10, 40, 40);
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.purpose = @"CCC 12 : Please let me track you!";
    _locationManager.delegate = self;
}

- (void)initLocationManager {

//    self.locationManager.delegate = self;

    if ([CLLocationManager locationServicesEnabled]) {
        LogDebug(@"Location services enabled.");

        if (CLLocationManager.regionMonitoringAvailable && CLLocationManager.regionMonitoringEnabled) {
            LogDebug(@"Region monitoring available and enabled.");
            [self registerRegions];
        }

        [self.locationManager startMonitoringSignificantLocationChanges];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initLocationManager];
   
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 41.88209;
    zoomLocation.longitude = -87.62784;
    
    self.mapView.region = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*1609, 0.5*1609);
    self.mapView.showsUserLocation = YES;
    
    [self.button addTarget:self action:@selector(showRegionInfo) forControlEvents:UIControlEventTouchUpInside];

    [self.mapView addSubview:self.button];
    [self.mapView addSubview:self.label];
    [self.view addSubview:self.mapView];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.label = nil;
    self.mapView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) showRegionInfo {
    RegionsViewController *rvc = [[RegionsViewController alloc]init];
    rvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:rvc animated:YES];
}

- (void) showAlert:(NSString *)alertText forRegion:(NSString *)regionIdentifier {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:alertText
                                                      message:[NSString stringWithFormat:@"%@",regionIdentifier]
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

- (void)registerRegions {

    LogDebug(@"Number of regions monitored : %d",[self.locationManager.monitoredRegions count]);
    for(CLRegion *region in self.locationManager.monitoredRegions) {
        LogDebug(@"%@",region.identifier);
    }

    for(CLRegion *region in self.locationManager.monitoredRegions) {
        LogDebug(@"Stopping Monitoring : %@", region.identifier);
        [self.locationManager stopMonitoringForRegion:region];
    }

    CLLocationCoordinate2D theBean = CLLocationCoordinate2DMake(41.882669, -87.623297);
    CLRegion *beanRegion = [[CLRegion alloc] initCircularRegionWithCenter:theBean
                                                                   radius:25.0f
                                                               identifier:@"Cloud Gate"];
    [self.locationManager startMonitoringForRegion:beanRegion];

    CLLocationCoordinate2D theFountain = CLLocationCoordinate2DMake(41.88148, -87.62373);
    CLRegion *fountainRegion = [[CLRegion alloc] initCircularRegionWithCenter:theFountain
                                                                       radius:25.0f
                                                                   identifier:@"Crown Fountain"];
    [self.locationManager startMonitoringForRegion:fountainRegion];

    LogDebug(@"Montioring %d Regions", [self.locationManager.monitoredRegions count]);
    for(CLRegion *region in self.locationManager.monitoredRegions) {
            LogDebug(@"%@",region.identifier);
    }
}

#pragma CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    LogDebug(@"%@", error);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    LogDebug(@"Starting to monitor : %@", region.identifier);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    LogDebug(@"Entered Region - %@", region.identifier);
    [self showAlert:@"Entering Region" forRegion:region.identifier];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    LogDebug(@"Exited Region - %@", region.identifier);
    [self showAlert:@"Exiting Region" forRegion:region.identifier];
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    LogDebug(@"%@ failed with:\n%@", region.identifier, error);
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    _label.text = [NSString stringWithFormat:@"%f, %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude];
    
    self.mapView.region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 0.5*MILE_IN_METERS, 0.5*MILE_IN_METERS);

//    for(CLRegion *region in manager.monitoredRegions) {
//        if ([region containsCoordinate:newLocation.coordinate] && ![region containsCoordinate:oldLocation.coordinate]) {
//            LogDebug(@"Entered %@",region.identifier);
//            [self locationManager:manager didEnterRegion:region];
//        } else if (![region containsCoordinate:newLocation.coordinate] && [region containsCoordinate:oldLocation.coordinate]) {
//            LogDebug(@"Exited %@",region.identifier);
//            [self locationManager:manager didExitRegion:region];
//        }
//    }
}

@end