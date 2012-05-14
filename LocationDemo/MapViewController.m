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

static int METERS_PER_MILE = 1609;

- (id) init {
    self = [super init];
    if(self) {
       [self initialize];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       [self initialize];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;    
}

- (void) initialize {
    // Do Init
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320 , 360)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.mapView];
}

- (void) viewWillAppear:(BOOL)animated {

    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 41.88209;
    zoomLocation.longitude = -87.62784;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];                

    [self.mapView setRegion:adjustedRegion animated:YES];
    [self.mapView setShowsUserLocation:YES];
    
    
    CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:    CLLocationCoordinate2DMake(41.882664, -87.623291) radius:200.0 identifier:@"Cloud Gate"];
    
    [[self locationManager] startUpdatingLocation];
    [[self locationManager] startMonitoringForRegion:region];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mapView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (CLLocationManager *)locationManager {
    
    if (_locationManager != nil) {
        return _locationManager;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.purpose = @"Get notifications when you are near attractions.";
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.delegate = self;
    
    return _locationManager;
}


#pragma CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    LogDebug(@"Entered Region - %@", region.identifier);
}

-(void) locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    LogDebug(@"%@ Region Registered.", region.identifier);
}
@end
