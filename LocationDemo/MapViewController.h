//
//  MapViewController.h
//  LocationDemo
//
//  Created by Kevin McMahon on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate> {
    RMMapView *_mapView;
    CLLocationManager *_locationManager;
}

@property(nonatomic, strong) RMMapView *mapView;

@end
