//
//  MapViewController.h
//  LocationDemo
//
//  Created by Kevin McMahon on 5/9/12.
//  Copyright (c) 2012 Kevin McMahon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate> {
    MKMapView *_mapView;
    UILabel *_label;
    CLLocationManager *_locationManager;
    UIButton *_infoButton;
}

@property(nonatomic, strong) MKMapView *mapView;
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) UIButton *button;

@end
