//
//  IPPCampusOverlay.m
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 20.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import "IPPCampusOverlay.h"
#import "IPPCampus.h"

@implementation IPPCampusOverlay
@synthesize coordinate;
@synthesize boundingMapRect;

- (instancetype)initWithCampus:(IPPCampus *)campus {
    self = [super init];
    if (self) {
        self->boundingMapRect = campus.overlayBoundingMapRect;
        self->coordinate = campus.midCoordinate;
    }
	
    return self;
}
@end
