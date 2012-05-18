//
//  MapViewController.h
//  LocationDemo
//
//  Created by Kevin McMahon on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KMMapView.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate> {
    KMMapView *_mapView;
}

@property(nonatomic, strong) KMMapView *mapView;

@end
