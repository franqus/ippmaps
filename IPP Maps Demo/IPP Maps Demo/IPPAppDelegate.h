//
//  IPPAppDelegate.h
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 15.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPPMapKitViewController.h"

#import "IPPMapControlsViewController.h"



@interface IPPAppDelegate : UIResponder <UIApplicationDelegate>
{
    IPPMapControlsViewController* controlVC;
	IPPMapKitViewController* mapKitVC;
}
@property (strong, nonatomic) UIWindow *window;

@end
