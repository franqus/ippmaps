//
//  IPPCampusOverlay.h
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 20.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class IPPCampus;
@interface IPPCampusOverlay : NSObject<MKOverlay>

- (instancetype)initWithCampus:(IPPCampus*)campus;

@end
