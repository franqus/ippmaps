//
//  IPPCampusOverlayView.h
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 20.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface IPPCampusOverlayView : MKOverlayView

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(UIImage *)overlayImage;

@end
