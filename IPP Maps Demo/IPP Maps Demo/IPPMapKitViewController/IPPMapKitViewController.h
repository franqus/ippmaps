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
	NSMutableArray* directionsArray;
	NSMutableArray* directionsAnnotationArray;
//	UIView* controlContainerView;
//	UISegmentedControl* mapTypeControl;
//	UISwitch* scrollControl;
//	UISwitch* zoomControl;
//	UISwitch* rotationControl;
//	UISwitch* pitchControl;
//	UISwitch* buildingsControl;
//	UISwitch* poisControl;
//	UISwitch* userLocationControl;
//	UISwitch* annotationControl;
//	UISwitch* customAnnotationControl;
//	UISwitch* overlaysControl;
	UIButton* goToRandomLocationControl;
	UITextView* randomLocationTextView;
//
//	UITextField* searchTextfield;
	
	IPPMapKitAnnotation* randomLocationAnnot;
	
	
	NSMutableArray* universityAnnotationsArray;
	NSMutableArray* companyAnnotationsArray;
	NSMutableArray* overlaysArray;
	NSMutableArray* randomLocationsArray;
	
	IPPCampus* campus;
}

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) UILabel *detailDescriptionLabel;
@end
