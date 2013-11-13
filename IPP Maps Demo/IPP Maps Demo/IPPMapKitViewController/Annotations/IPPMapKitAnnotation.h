//
//  IPPMapKitAnnotation.h
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 17.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface IPPMapKitAnnotation : NSObject<MKAnnotation>
{
	
}

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

- (id)initWithCLLocationCoordinate2D:(CLLocationCoordinate2D)aCoord andTitle:(NSString*) aTitle;

@end
