//
//  IPPMapKitAnnotation.m
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 17.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import "IPPMapKitAnnotation.h"

@implementation IPPMapKitAnnotation
@synthesize coordinate;
@synthesize title;

- (id)initWithCLLocationCoordinate2D:(CLLocationCoordinate2D)aCoord andTitle:(NSString*) aTitle {
    self = [self init];
    
    if (self != nil) {
        self->coordinate = aCoord;
        self->title = aTitle;
    }
	
    return self;
}


@end
