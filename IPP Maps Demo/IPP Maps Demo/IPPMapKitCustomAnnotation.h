//
//  IPPMapKitCustomAnnotation.h
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 17.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface IPPMapKitCustomAnnotation : NSObject<MKAnnotation>
{
	UIImage* image;
}

@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, readwrite) UIImage* image;

- (id)initWithCLLocationCoordinate2D:(CLLocationCoordinate2D)aCoord andTitle:(NSString*)aTitle andImage:(UIImage*)aImage;

@end
