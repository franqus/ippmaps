//
//  IPPAppDelegate.h
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 15.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPPMainViewController.h"
#import "IPPMapKitViewController.h"
#import "IPPGoogleMapsViewController.h"
#import "IPPBingMapsViewController.h"


@interface IPPAppDelegate : UIResponder <UIApplicationDelegate>
{
	IPPMainViewController* mainVC;
	IPPMapKitViewController* mapKitVC;
	IPPGoogleMapsViewController* googleMapsVC;
	IPPBingMapsViewController* bingMapsVC;
}
@property (strong, nonatomic) UIWindow *window;

@end
