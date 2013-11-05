//
//  IPPMapKitViewController.m
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 15.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import "IPPMapKitViewController.h"
#import	"IPPCampusOverlay.h"
#import "IPPCampusOverlayView.h"

#define SwitchFrameWidth 20;
#define SwitchFrameHeight 20;





@implementation IPPMapKitViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
		[self setTitle:@"MapKit"];
		[self.tabBarItem setImage:[UIImage imageNamed:@"MapKit_Logo"]];
		[self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"MapKit_Logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
		
		self->mapView = [[MKMapView alloc] initWithFrame: CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width)];
		
		//init mapView with location of Mannheim //{49.470843,8.480973}
		CLLocationCoordinate2D coord = {.latitude =  49.470843, .longitude =  8.480973};
		//34.4248,-118.5971
		//49.469268,8.483334
		MKCoordinateSpan span = {.latitudeDelta =  0.01, .longitudeDelta =  0.001};
		MKCoordinateRegion region = {coord, span};
		[self->mapView setRegion:region];
		[self->mapView setDelegate:self];
		[self.view addSubview:self->mapView];
		
		self->controlContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 768)];
		[self->controlContainerView setBackgroundColor:[UIColor whiteColor]];
		[self->controlContainerView setAlpha:0.95];
		
		[self.view addSubview:self->controlContainerView];
		
		NSArray* mapTypes = @[@"Standard",@"Hybrid",@"Satellite"];
		self->mapTypeControl = [[UISegmentedControl alloc] initWithItems:mapTypes];
		[self->mapTypeControl setFrame:CGRectMake(self->controlContainerView.frame.size.width/2-100, 10, 200, 30)];
		[self->mapTypeControl addTarget:self action:@selector(changeMapType:) forControlEvents:UIControlEventValueChanged];
		[self->mapTypeControl setSelectedSegmentIndex:0];
		[self->controlContainerView addSubview:self->mapTypeControl];
		
		UILabel* zoomControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self->mapTypeControl.frame.origin.y+self->mapTypeControl.frame.size.height+10, 147, 31)];
		[zoomControlLabel setFont:[UIFont systemFontOfSize:22]];
		[zoomControlLabel setText:@"Zoom:"];
		[self->controlContainerView addSubview:zoomControlLabel];
		
		self->zoomControl = [[UISwitch alloc] initWithFrame:CGRectMake(self->controlContainerView.frame.size.width-61, zoomControlLabel.frame.origin.y, 50, 31)];
		[self->zoomControl setOn:[self->mapView isZoomEnabled]];
		[self->zoomControl addTarget:self action:@selector(toggleZoom:) forControlEvents:UIControlEventValueChanged];
		[self->controlContainerView addSubview:self->zoomControl];
		
		UILabel* scrollControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self->zoomControl.frame.origin.y+self->zoomControl.frame.size.height+10, 147, 31)];
		[scrollControlLabel setFont:[UIFont systemFontOfSize:22]];
		[scrollControlLabel setText:@"Scroll:"];
		[self->controlContainerView addSubview:scrollControlLabel];
		
		self->scrollControl = [[UISwitch alloc] initWithFrame:CGRectMake(self->controlContainerView.frame.size.width-61, scrollControlLabel.frame.origin.y, 50, 31)];
		[self->scrollControl setOn:[self->mapView isScrollEnabled]];
		[self->scrollControl addTarget:self action:@selector(toggleScroll:) forControlEvents:UIControlEventValueChanged];
		[self->controlContainerView addSubview:self->scrollControl];
		
		UILabel* rotationControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self->scrollControl.frame.origin.y+self->scrollControl.frame.size.height+10, 147, 31)];
		[rotationControlLabel setFont:[UIFont systemFontOfSize:22]];
		[rotationControlLabel setText:@"Rotate:"];
		[self->controlContainerView addSubview:rotationControlLabel];
		
		self->rotationControl = [[UISwitch alloc] initWithFrame:CGRectMake(self->controlContainerView.frame.size.width-61, rotationControlLabel.frame.origin.y, 50, 31)];
		[self->rotationControl setOn:[self->mapView isRotateEnabled]];
		[self->rotationControl addTarget:self action:@selector(toggleRotate:) forControlEvents:UIControlEventValueChanged];
		[self->controlContainerView addSubview:self->rotationControl];
		
		UILabel* pitchControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, rotationControlLabel.frame.origin.y+rotationControlLabel.frame.size.height+10, 147, 31)];
		[pitchControlLabel setFont:[UIFont systemFontOfSize:22]];
		[pitchControlLabel setText:@"Pitch:"];
		[self->controlContainerView addSubview:pitchControlLabel];
		
		self->pitchControl = [[UISwitch alloc] initWithFrame:CGRectMake(self->controlContainerView.frame.size.width-61, pitchControlLabel.frame.origin.y, 50, 31)];
		[self->pitchControl setOn:[self->mapView isPitchEnabled]];
		[self->pitchControl addTarget:self action:@selector(togglePitch:) forControlEvents:UIControlEventValueChanged];
		[self->controlContainerView addSubview:self->pitchControl];
		
		UILabel* buildingsControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, pitchControlLabel.frame.origin.y+pitchControl.frame.size.height+10, 147, 31)];
		[buildingsControlLabel setFont:[UIFont systemFontOfSize:22]];
		[buildingsControlLabel setText:@"Buildings:"];
		[self->controlContainerView addSubview:buildingsControlLabel];
		
		self->buildingsControl = [[UISwitch alloc] initWithFrame:CGRectMake(self->controlContainerView.frame.size.width-61, buildingsControlLabel.frame.origin.y, 50, 31)];
		[self->buildingsControl setOn:[self->mapView showsBuildings]];
		[self->buildingsControl addTarget:self action:@selector(toggleBuildings:) forControlEvents:UIControlEventValueChanged];
		[self->controlContainerView addSubview:self->buildingsControl];
		
		UILabel* poisControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, buildingsControlLabel.frame.origin.y+buildingsControlLabel.frame.size.height+10, 147, 31)];
		[poisControlLabel setFont:[UIFont systemFontOfSize:22]];
		[poisControlLabel setText:@"POIs:"];
		[self->controlContainerView addSubview:poisControlLabel];
		
		self->poisControl = [[UISwitch alloc] initWithFrame:CGRectMake(self->controlContainerView.frame.size.width-61, poisControlLabel.frame.origin.y, 50, 31)];
		[self->poisControl setOn:[self->mapView showsPointsOfInterest]];
		[self->poisControl addTarget:self action:@selector(togglePOIS:) forControlEvents:UIControlEventValueChanged];
		[self->controlContainerView addSubview:self->poisControl];
		
		UILabel* userLocationControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, poisControlLabel.frame.origin.y+poisControlLabel.frame.size.height+10, 147, 31)];
		[userLocationControlLabel setFont:[UIFont systemFontOfSize:22]];
		[userLocationControlLabel setText:@"User Location:"];
		[self->controlContainerView addSubview:userLocationControlLabel];
		
		self->userLocationControl = [[UISwitch alloc] initWithFrame:CGRectMake(self->controlContainerView.frame.size.width-61, userLocationControlLabel.frame.origin.y, 50, 31)];
		[self->userLocationControl setOn:[self->mapView showsUserLocation]];
		[self->userLocationControl addTarget:self action:@selector(toggleUserLocation:) forControlEvents:UIControlEventValueChanged];
		[self->controlContainerView addSubview:self->userLocationControl];
		
		UILabel* annotationControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, userLocationControlLabel.frame.origin.y+userLocationControlLabel.frame.size.height+10, 147, 31)];
		[annotationControlLabel setFont:[UIFont systemFontOfSize:22]];
		[annotationControlLabel setText:@"Map Pins:"];
		[self->controlContainerView addSubview:annotationControlLabel];
		
		self->annotationControl = [[UISwitch alloc] initWithFrame:CGRectMake(self->controlContainerView.frame.size.width-61, annotationControlLabel.frame.origin.y, 50, 31)];
		[self->annotationControl setOn:YES];
		[self->annotationControl addTarget:self action:@selector(toggleAnnotation:) forControlEvents:UIControlEventValueChanged];
		[self->controlContainerView addSubview:self->annotationControl];
		
		UILabel* customAnnotationControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, annotationControlLabel.frame.origin.y+annotationControlLabel.frame.size.height+10, 147, 31)];
		[customAnnotationControlLabel setFont:[UIFont systemFontOfSize:22]];
		[customAnnotationControlLabel setText:@"Annotation:"];
		[self->controlContainerView addSubview:customAnnotationControlLabel];
		
		self->customAnnotationControl = [[UISwitch alloc] initWithFrame:CGRectMake(self->controlContainerView.frame.size.width-61, customAnnotationControlLabel.frame.origin.y, 50, 31)];
		[self->customAnnotationControl setOn:YES];
		[self->customAnnotationControl addTarget:self action:@selector(toggleCustomAnnotation:) forControlEvents:UIControlEventValueChanged];
		[self->controlContainerView addSubview:self->customAnnotationControl];
		
		UILabel* overlaysControlLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, customAnnotationControlLabel.frame.origin.y+customAnnotationControlLabel.frame.size.height+10, 147, 31)];
		[overlaysControlLabel setFont:[UIFont systemFontOfSize:22]];
		[overlaysControlLabel setText:@"Overlays:"];
		[self->controlContainerView addSubview:overlaysControlLabel];
		
		self->overlaysControl = [[UISwitch alloc] initWithFrame:CGRectMake(self->controlContainerView.frame.size.width-61, overlaysControlLabel.frame.origin.y, 50, 31)];
		[self->overlaysControl setOn:YES];
		[self->overlaysControl addTarget:self action:@selector(toggleOverlays:) forControlEvents:UIControlEventValueChanged];
		[self->controlContainerView addSubview:self->overlaysControl];
		
		self->goToRandomLocationControl = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[self->goToRandomLocationControl setBackgroundColor:[UIColor clearColor]];
		[self->goToRandomLocationControl.layer setBorderWidth:1.0f];
		[self->goToRandomLocationControl.layer setBorderColor:[UIColor colorWithRed:9/255.f green:92/255.f blue:255/255.f alpha:1.0]
		 .CGColor];
		[self->goToRandomLocationControl.layer setCornerRadius:5.0f];
		
		[self->goToRandomLocationControl setFrame:CGRectMake(self->controlContainerView.frame.size.width/2-100, self->overlaysControl.frame.origin.y+self->overlaysControl.frame.size.height+10, 200, 30)];
		[self->goToRandomLocationControl setTitle:@"Random Location" forState:UIControlStateNormal];
		[self->goToRandomLocationControl addTarget:self action:@selector(goToRandomLocation:) forControlEvents:UIControlEventTouchUpInside];
		[self->controlContainerView addSubview:self->goToRandomLocationControl];
		
		self->randomLocationTextView = [[UITextView alloc] initWithFrame:CGRectMake(self->controlContainerView.frame.size.width/2-100, self->goToRandomLocationControl.frame.origin.y+self->goToRandomLocationControl.frame.size.height+5, 200, 200)];
		[self->controlContainerView addSubview:self->randomLocationTextView];
				
		IPPMapKitAnnotation *hsMannheimAnnot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(49.469268,8.483334) andTitle:@"HS Mannheim"];
		[self->mapView addAnnotation:hsMannheimAnnot];
		
		IPPMapKitAnnotation *stanfordAnnot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(37.427774,-122.169642) andTitle:@"Stanford University"];
		[self->mapView addAnnotation:stanfordAnnot];
		
		IPPMapKitAnnotation *mitAnnot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(42.358924,-71.093774) andTitle:@"Massachusetts Institute of Technology"];
		[self->mapView addAnnotation:mitAnnot];
		
		IPPMapKitAnnotation *cambridgeAnnot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(52.205503,0.117073) andTitle:@"University of Cambridge"];
		[self->mapView addAnnotation:cambridgeAnnot];
		
		self->universityAnnotationsArray = [[NSMutableArray alloc] initWithObjects:hsMannheimAnnot, stanfordAnnot, mitAnnot, cambridgeAnnot, nil];
		
		
		IPPMapKitCustomAnnotation *appleAnnot = [[IPPMapKitCustomAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(37.331812,-122.029567) andTitle:@"Apple Inc." andImage:[UIImage imageNamed:@"Company_Apple"]];
		[self->mapView addAnnotation:appleAnnot];
		
		IPPMapKitCustomAnnotation *googleAnnot = [[IPPMapKitCustomAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(37.422134,-122.083962) andTitle:@"Google Inc." andImage:[UIImage imageNamed:@"Company_Google"]];
		[self->mapView addAnnotation:googleAnnot];
		
		IPPMapKitCustomAnnotation *microsoftAnnot = [[IPPMapKitCustomAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(47.641957,-122.142391) andTitle:@"Microsoft Corporation" andImage:[UIImage imageNamed:@"Company_Microsoft"]];
		[self->mapView addAnnotation:microsoftAnnot];
				
		self->companyAnnotationsArray = [[NSMutableArray alloc] initWithObjects:appleAnnot, googleAnnot, microsoftAnnot, nil];
		
		
		self->campus = [[IPPCampus alloc] initWithFilename:@"Campus"];
		
//		MKCircle *circle = [MKCircle circleWithCenterCoordinate:coord radius:200];
//		[self->mapView addOverlay:circle];
		
		IPPCampusOverlay* campusOverlay = [[IPPCampusOverlay alloc] initWithCampus:self->campus];
		self->overlaysArray = [[NSMutableArray alloc] initWithObjects:campusOverlay, nil];
		
		[self->mapView addOverlay:campusOverlay];

		
		CLLocationCoordinate2D  points[4];
		points[0] = CLLocationCoordinate2DMake(49.47366,8.473957);
		points[1] = CLLocationCoordinate2DMake(49.474538,8.481445);
		points[2] = CLLocationCoordinate2DMake(49.468766,8.483205);
		points[3] = CLLocationCoordinate2DMake(49.469491,8.472004);
		MKPolygon* polygon = [MKPolygon polygonWithCoordinates:points count:4];
		polygon.title = @"Leeds";
//		[self->mapView addOverlay:polygon];
	}
    return self;
}


-(void)changeMapType:(UISegmentedControl*)sender{
	switch (sender.selectedSegmentIndex) {
		case 0:
			[self->mapView setMapType:MKMapTypeStandard];
			break;
		case 1:
			[self->mapView setMapType:MKMapTypeHybrid];
			break;
		case 2:
			[self->mapView setMapType:MKMapTypeSatellite];
			break;
		default:
			break;
	}
}

-(void)toggleZoom:(UISwitch*)sender{
	[self->mapView setZoomEnabled:[sender isOn]];
}

-(void)toggleScroll:(UISwitch*)sender{
	[self->mapView setScrollEnabled:[sender isOn]];
}

-(void)toggleRotate:(UISwitch*)sender{
	[self->mapView setRotateEnabled:[sender isOn]];
}

-(void)togglePitch:(UISwitch*)sender{
	[self->mapView setPitchEnabled:[sender isOn]];
}

-(void)toggleBuildings:(UISwitch*)sender{
	[self->mapView setShowsBuildings:[sender isOn]];
}

-(void)togglePOIS:(UISwitch*)sender{
	[self->mapView setShowsPointsOfInterest:[sender isOn]];
}

-(void)toggleUserLocation:(UISwitch*)sender{
	[self->mapView setShowsUserLocation:[sender isOn]];
}

-(void)toggleAnnotation:(UISwitch*)sender{
	if([sender isOn]){
		[self->mapView addAnnotations:self->universityAnnotationsArray];
	}
	else if(![sender isOn]){
		[self->mapView removeAnnotations:self->universityAnnotationsArray];
	}
}

-(void)toggleCustomAnnotation:(UISwitch*)sender{
	if([sender isOn]){
		[self->mapView addAnnotations:self->companyAnnotationsArray];
	}
	else if(![sender isOn]){
		[self->mapView removeAnnotations:self->companyAnnotationsArray];
	}
}

-(void)toggleOverlays:(UISwitch*)sender{
	if([sender isOn]){
		[self->mapView addOverlays:self->overlaysArray];
	}else if(![sender isOn]){
		[self->mapView removeOverlays:self->overlaysArray];
	}
}

-(void)goToRandomLocation:(UIButton*)sender{
	
	CLGeocoder* geocoder = [[CLGeocoder alloc] init];
	
	float lat_low_bound = -90;
	float lat_high_bound = 90;
	float lat_rndValue = (((float)arc4random()/0x100000000)*(lat_high_bound-lat_low_bound)+lat_low_bound);
	
	float lon_low_bound = -180;
	float lon_high_bound = 180;
	float lon_rndValue = (((float)arc4random()/0x100000000)*(lon_high_bound-lon_low_bound)+lon_low_bound);
	
	CLLocationCoordinate2D coord = {.latitude = lat_rndValue, .longitude = lon_rndValue};
	MKCoordinateSpan span = {.latitudeDelta =  50, .longitudeDelta =  50};
	MKCoordinateRegion region = {coord, span};
	
	CLLocation* location = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
	[geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
		if(placemarks){
			CLPlacemark* placemark = [[CLPlacemark alloc] initWithPlacemark:[placemarks firstObject]];
			if ([[placemark name] rangeOfString:@"Ocean"].location == NSNotFound && [[placemark name] rangeOfString:@"Sea"].location == NSNotFound) {
				self->randomLocationAnnot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D:coord andTitle:[placemark name]];
				
				[self->mapView setRegion:region animated:YES];
				[self->mapView addAnnotation:self->randomLocationAnnot];

				[self->randomLocationTextView setText:[NSString stringWithFormat:@"name = %@\ncountry = %@\nadministrativeArea = %@\nlocality = %@\npostalCode = %@\nthoroughfare = %@\nareasOfInterest = %@", placemark.name, placemark.country, placemark.administrativeArea, placemark.locality, placemark.postalCode, placemark.thoroughfare, placemark.areasOfInterest]];
			}else{
				[self goToRandomLocation:self->goToRandomLocationControl];
			}
		}else{
			[self->randomLocationTextView setText:@"The Internet connection appears to be offline."];
		}
		
	}];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)addOverlay {
//    IPPCampusOverlay* overlay = [[IPPCampusOverlay alloc] initWithCampus:self->campus];
//    [self->mapView addOverlay:overlay];
//}

//- (void)loadSelectedOptions {
////    [self->mapView removeAnnotations:self->mapView.annotations];
////    [self->mapView removeOverlays:self->mapView.overlays];
//    for (NSNumber *option in self->selectedOptions) {
//        switch ([option integerValue]) {
//            case 0:
//                [self addOverlay];
//                break;
//            default:
//                break;
//        }
//    }
//}

#pragma mark -
#pragma mark MKMapViewDelegate methods
-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
	[self->randomLocationTextView setText:@""];
	[self->mapView removeAnnotation:self->randomLocationAnnot];
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
	if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    else if ([annotation isKindOfClass:[IPPMapKitCustomAnnotation class]])
    {
		IPPMapKitCustomAnnotation* resultAnnot = (IPPMapKitCustomAnnotation*)annotation;
        static NSString * const identifier = @"MyCustomAnnotation";
		
        MKAnnotationView* annotationView = [self->mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
		
        if (annotationView)
        {
            annotationView.annotation = resultAnnot;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:resultAnnot
                                                          reuseIdentifier:identifier];
        }
		
        // set your annotationView properties
		
        annotationView.image = resultAnnot.image;
        annotationView.canShowCallout = YES;
		[annotationView setBackgroundColor:[UIColor clearColor]];
        // if you add QuartzCore to your project, you can set shadows for your image, too
        //
		[annotationView.layer setShadowColor:[UIColor whiteColor].CGColor];
		[annotationView.layer setShadowOpacity:1.0f];
		[annotationView.layer setShadowRadius:5.0f];
		[annotationView.layer setShadowOffset:CGSizeMake(0, 0)];
//		[annotationView setClipsToBounds:YES];
//		[annotationView setBackgroundColor:[UIColor whiteColor]];
		
        return annotationView;
    }
	
    return nil;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
	if ([overlay isKindOfClass:[MKPolygon class]])
	{
		MKPolygonView *polyView = [[MKPolygonView alloc] initWithPolygon:(MKPolygon*)overlay];
		polyView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:0.2];
		polyView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
		polyView.lineWidth = 3;
//		UIImageView* ivTest = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Campus_ov"]];
//		[polyView addSubview:ivTest];
		[polyView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Campus_ov"] ]];
		return polyView;
	}
	
    if ([overlay isKindOfClass:IPPCampusOverlay.class]) {
        UIImage *magicMountainImage = [UIImage imageNamed:@"Campus_ov"];
        IPPCampusOverlayView *overlayView = [[IPPCampusOverlayView alloc] initWithOverlay:overlay overlayImage:magicMountainImage];
		
        return overlayView;
    }
	
    return nil;

//	MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
//    circleView.strokeColor = [UIColor redColor];
//    circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
//    return circleView;
}

@end
