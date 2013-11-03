//
//  IPPCampusOverlayView.m
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 20.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import "IPPCampusOverlayView.h"

@interface IPPCampusOverlayView()

@property (nonatomic, strong) UIImage *overlayImage;

@end

@implementation IPPCampusOverlayView

- (instancetype)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(UIImage *)overlayImage {
    self = [super initWithOverlay:overlay];
    if (self) {
        overlayImage = overlayImage;
    }
	
    return self;
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {
    CGImageRef imageReference = self.overlayImage.CGImage;
	
    MKMapRect theMapRect = self.overlay.boundingMapRect;
    CGRect theRect = [self rectForMapRect:theMapRect];
	
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -theRect.size.height);
    CGContextDrawImage(context, theRect, imageReference);
}

@end