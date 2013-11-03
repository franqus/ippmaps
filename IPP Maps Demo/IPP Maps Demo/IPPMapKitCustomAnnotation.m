//
//  IPPMapKitCustomAnnotation.m
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 17.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import "IPPMapKitCustomAnnotation.h"

@implementation IPPMapKitCustomAnnotation
@synthesize coordinate;
@synthesize title;
@synthesize image;

- (id)initWithCLLocationCoordinate2D:(CLLocationCoordinate2D)aCoord andTitle:(NSString*)aTitle andImage:(UIImage*)aImage{
    self = [self init];
    
    if (self != nil) {
        self->coordinate = aCoord;
        self->title = aTitle;
		self->image = aImage;
    }
	
    return self;
}


@end