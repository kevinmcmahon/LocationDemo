//
//  KMMapView.m
//  LocationDemo
//
//  Created by Kevin McMahon on 5/17/12.
//  Copyright (c) 2012 Kevin McMahon. All rights reserved.
//

#import "KMMapView.h"
#import "RMMapBoxSource.h"

@implementation KMMapView

- (id)init {
    self = [super init];
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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTilesource:(id <RMTileSource>)newTilesource {
    self = [super initWithFrame:frame andTilesource:newTilesource];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andTilesource:(id <RMTileSource>)newTilesource centerCoordinate:(CLLocationCoordinate2D)initialCenterCoordinate zoomLevel:(float)initialZoomLevel maxZoomLevel:(float)maxZoomLevel minZoomLevel:(float)minZoomLevel backgroundImage:(UIImage *)backgroundImage {

    self = [super initWithFrame:frame
                  andTilesource:newTilesource
               centerCoordinate:initialCenterCoordinate
                      zoomLevel:initialZoomLevel
                   maxZoomLevel:maxZoomLevel
                   minZoomLevel:minZoomLevel
                backgroundImage:backgroundImage];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andCoordinate:(CLLocationCoordinate2D)coordinate {
    NSString *tileJsonUrl = ([[UIScreen mainScreen] scale] == 2.0) ? @"http://a.tiles.mapbox.com/v3/kevinmcmahon.map-ceoj9351.jsonp" : @"http://a.tiles.mapbox.com/v3/kevinmcmahon.map-tfit1fwc.jsonp";

    return [self initWithFrame:frame
                 andTilesource:[[RMMapBoxSource alloc] initWithReferenceURL:[NSURL URLWithString:tileJsonUrl]]
            centerCoordinate:coordinate
                   zoomLevel:14
                maxZoomLevel:16
                minZoomLevel:12
             backgroundImage:[UIImage imageNamed:@"loading"]];
}

- (void)initialize {
    [self setAdjustTilesForRetinaDisplay:NO];
    [self setShowsUserLocation:YES];
    [self setUserTrackingMode:RMUserTrackingModeFollow];
}

@end
