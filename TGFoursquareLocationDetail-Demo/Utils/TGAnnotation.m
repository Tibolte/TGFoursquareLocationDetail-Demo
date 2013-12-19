//
//  TGAnnotation.m
//  TGFoursquareLocationDetail-Demo
//
//  Created by Thibault Guégan on 19/12/2013.
//  Copyright (c) 2013 Thibault Guégan. All rights reserved.
//

#import "TGAnnotation.h"

@implementation TGAnnotation

@synthesize coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)paramCoordinates{
    self = [super init];
    if (self) {
        coordinate = paramCoordinates;
    }
    return self;
}

@end
