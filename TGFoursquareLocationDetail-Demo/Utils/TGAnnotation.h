//
//  TGAnnotation.h
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 19/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>

@interface TGAnnotation : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, assign, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)paramCoordinates;

@end
