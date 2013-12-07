//
//  IPPMapKitViewController.h
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 15.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "IPPMapKitAnnotation.h"
#import "IPPMapKitCustomAnnotation.h"
#import "IPPCampus.h"
#import "IPPMapControlsViewController.h"
#import "IPPMapKitPopverViewController.h"


@interface IPPMapKitViewController : UIViewController<MKMapViewDelegate, UITextFieldDelegate, UISplitViewControllerDelegate, IPPMapControlsViewControllerDelegate, UIPopoverControllerDelegate, IPPMapKitPopverViewControllerDelegate>
{
	MKMapView* mapView;
	
	IPPMapKitPopverViewController* popoverVC;
	UIPopoverController* directionsPopoverController;
	MKDirectionsRequest* directionRequest;

	IPPMapKitAnnotation* randomLocationAnnot;
	IPPCampus* campus;

	NSMutableArray* directionsArray;
	NSMutableArray* directionsAnnotationArray;
	NSMutableArray* universityAnnotationsArray;
	NSMutableArray* companyAnnotationsArray;
	NSMutableArray* overlaysArray;
	NSMutableArray* randomLocationsArray;
	CLGeocoder* geocoder;

}

//@property (strong, nonatomic) id detailItem;
//@property (weak, nonatomic) UILabel *detailDescriptionLabel;
@end
