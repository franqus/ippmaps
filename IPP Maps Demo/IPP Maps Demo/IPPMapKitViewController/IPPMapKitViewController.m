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

@interface IPPMapKitViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation IPPMapKitViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        // Custom initialization
		[self setTitle:@"IPP Maps"];
		[self.tabBarItem setImage:[UIImage imageNamed:@"MapKit_Logo"]];
		[self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"MapKit_Logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
				
		UIBarButtonItem *popoverBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Direction" style:UIBarButtonItemStylePlain target:self action:@selector(directionsPopoverBtn_tapped:)];
		//initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(goBack)];
		
		[self.navigationItem setRightBarButtonItem:popoverBarButtonItem animated:YES];
		//[[UIBarButtonItem alloc] initWithCustomView:popOverButton] animated:YES];
		
		self->directionRequest = [[MKDirectionsRequest alloc] init];

		
		self->mapView = [[MKMapView alloc] initWithFrame: self.view.frame];
		
		//init mapView with location of Mannheim
		CLLocationCoordinate2D coord = {.latitude =  49.470843, .longitude =  8.480973};
        
//		MKCoordinateSpan span = {.latitudeDelta =  0.01, .longitudeDelta =  0.001};
		MKCoordinateSpan span = {.latitudeDelta =  100, .longitudeDelta =  100};

		MKCoordinateRegion region = {coord, span};
		[self->mapView setRegion:region];
		[self->mapView setDelegate:self];
		[self.view addSubview:self->mapView];
		
		// Some default annotations
		IPPMapKitAnnotation *hsMannheimAnnot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(49.469268,8.483334) andTitle:@"HS Mannheim"];
		[self->mapView addAnnotation:hsMannheimAnnot];
		
		IPPMapKitAnnotation *stanfordAnnot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(37.427774,-122.169642) andTitle:@"Stanford University"];
		[self->mapView addAnnotation:stanfordAnnot];
		
		IPPMapKitAnnotation *mitAnnot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(42.358924,-71.093774) andTitle:@"Massachusetts Institute of Technology"];
		[self->mapView addAnnotation:mitAnnot];
		
		IPPMapKitAnnotation *cambridgeAnnot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(52.205503,0.117073) andTitle:@"University of Cambridge"];
		[self->mapView addAnnotation:cambridgeAnnot];
		
		self->universityAnnotationsArray = [[NSMutableArray alloc] initWithObjects:hsMannheimAnnot, stanfordAnnot, mitAnnot, cambridgeAnnot, nil];
		
		
		// Some custom annotations
		IPPMapKitCustomAnnotation *hollywoodSign = [[IPPMapKitCustomAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(34.133973,-118.32177) andTitle:@"Hollywood" andImage:[UIImage imageNamed:@"LosAngeles"]];
		[self->mapView addAnnotation:hollywoodSign];
		
		IPPMapKitCustomAnnotation *mannheimPalace = [[IPPMapKitCustomAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(49.483447,8.462228) andTitle:@"Mannheim Palace" andImage:[UIImage imageNamed:@"Mannheim"]];
		[self->mapView addAnnotation:mannheimPalace];
		
		IPPMapKitCustomAnnotation *statueOfLiberty = [[IPPMapKitCustomAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(40.689197,-74.044572) andTitle:@"Liberty Island" andImage:[UIImage imageNamed:@"NewYork"]];
		[self->mapView addAnnotation:statueOfLiberty];
		
		IPPMapKitCustomAnnotation *cristoRedentor = [[IPPMapKitCustomAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(-22.951922,-43.210492) andTitle:@"Cristo Redentor" andImage:[UIImage imageNamed:@"RioDeJaneiro"]];
		[self->mapView addAnnotation:cristoRedentor];
		
		IPPMapKitCustomAnnotation *operaHouse = [[IPPMapKitCustomAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(-33.856821,151.215101) andTitle:@"Opera House" andImage:[UIImage imageNamed:@"Sydney"]];
		[self->mapView addAnnotation:operaHouse];
		
		IPPMapKitCustomAnnotation *tajMahal = [[IPPMapKitCustomAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(27.175133,78.042065) andTitle:@"Taj Mahal" andImage:[UIImage imageNamed:@"Agra"]];
		[self->mapView addAnnotation:tajMahal];
		
		IPPMapKitCustomAnnotation *pyramids = [[IPPMapKitCustomAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(29.977632,31.132804) andTitle:@"Pyramids Of Gizah" andImage:[UIImage imageNamed:@"Gizah"]];
		[self->mapView addAnnotation:pyramids];
		
		IPPMapKitCustomAnnotation *basiliusCathedral = [[IPPMapKitCustomAnnotation alloc] initWithCLLocationCoordinate2D: CLLocationCoordinate2DMake(55.752517,37.623098) andTitle:@"St. Basil's Cathedral" andImage:[UIImage imageNamed:@"Moscow"]];
		[self->mapView addAnnotation:basiliusCathedral];
				
		self->companyAnnotationsArray = [[NSMutableArray alloc] initWithObjects:hollywoodSign, mannheimPalace, statueOfLiberty, cristoRedentor, operaHouse, tajMahal, pyramids, basiliusCathedral, nil];
		
		self->campus = [[IPPCampus alloc] initWithFilename:@"Campus"];
		
		IPPCampusOverlay* campusOverlay = [[IPPCampusOverlay alloc] initWithCampus:self->campus];
		self->overlaysArray = [[NSMutableArray alloc] initWithObjects:campusOverlay, nil];
		
		[self->mapView addOverlay:campusOverlay];

	
		//MKPolygon over Colrado
		CLLocationCoordinate2D points[4];
		points[0] = CLLocationCoordinate2DMake(41.00064,-109.05005);
		points[1] = CLLocationCoordinate2DMake(41.00235,-102.05169);
		points[2] = CLLocationCoordinate2DMake(36.99311,-102.04220);
		points[3] = CLLocationCoordinate2DMake(36.99907,-109.04545);

		MKPolygon* poly = [MKPolygon polygonWithCoordinates:points count:4];
		poly.title = @"Colorado";
		[self->mapView addOverlay:poly];
		
		[self->overlaysArray addObject:poly];
		
		
		self->randomLocationsArray = [[NSMutableArray alloc] init];
		
		self->directionsArray = [[NSMutableArray alloc] init];
		
	
	}
    return self;
}

-(void)directionsPopoverBtn_tapped:(UIBarButtonItem*)sender{
	
	self->popoverVC = [[IPPMapKitPopverViewController alloc] init];
	[self->popoverVC setDelegate:self];
	
	self->directionsPopoverController = [[UIPopoverController alloc] initWithContentViewController:self->popoverVC];
	[self->directionsPopoverController setDelegate:self];
	[self->directionsPopoverController setPopoverContentSize:CGSizeMake(240, 120) animated:YES];
	[self->directionsPopoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [self->mapView
		 addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
	if([overlay isKindOfClass:[IPPCampusOverlay class]]){
		return nil;
	}
	
	if([overlay isKindOfClass:[MKPolygon class]]){
		return nil;
	}
	
	MKPolylineRenderer *renderer =
	[[MKPolylineRenderer alloc] initWithOverlay:overlay];
	renderer.strokeColor = [UIColor colorWithRed:0/255.0f green:38/255.0f blue:255/255.0f alpha:1.0f];
	renderer.lineWidth = 3.0;
	return renderer;
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
		[self->mapView addOverlays:self->directionsArray];
	}else if(![sender isOn]){
		[self->mapView removeOverlays:self->overlaysArray];
		[self->mapView removeOverlays:self->directionsArray];
	}
}

-(void)goToRandomLocation:(UIButton*)sender withTextView:(UITextView *)textView{
	
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
			NSDictionary* addressDict = [placemark addressDictionary];
			NSLog(@"addressDict = %@", addressDict);

			if ([addressDict objectForKey:@"City"]) {
				self->randomLocationAnnot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D:coord andTitle:[placemark name]];
				
				[self->mapView setRegion:region animated:YES];
				[self->mapView addAnnotation:self->randomLocationAnnot];
				[self->randomLocationsArray addObject:self->randomLocationAnnot];

				
				[textView setText: [NSString stringWithFormat:@"City = %@\nCountry = %@\nCountryCode = %@\nName = %@\nState = %@\nSubAdministrativeArea = %@\nSubLocality = %@\nZIP = %@",
									[addressDict objectForKey:@"City"],
									[addressDict objectForKey:@"Country"],
									[addressDict objectForKey:@"CountryCode"],
									[addressDict objectForKey:@"Name"],
									[addressDict objectForKey:@"State"],
									[addressDict objectForKey:@"SubAdministrativeArea"],
									[addressDict objectForKey:@"SubLocality"],
									[addressDict objectForKey:@"ZIP"]
									]];
			}else{
				[self goToRandomLocation:self->goToRandomLocationControl withTextView:textView];
			}
		}else{
			[textView setText:@"The Internet connection appears to be offline."];
		}
		
	}];
	

}

-(BOOL)goToLocation:(NSString*)search withTextView:(UITextView *)textView{
	__block BOOL result = NO;
    MKLocalSearchRequest* searchReq = [[MKLocalSearchRequest alloc] init];
    searchReq.naturalLanguageQuery = search;
    searchReq.region = self->mapView.region;
    
    MKLocalSearch* localSearch = [[MKLocalSearch alloc] initWithRequest:searchReq];
    
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        for (MKMapItem* item in response.mapItems) {
            NSLog(@"item = %@", item);
            IPPMapKitAnnotation* annot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D:[[[item placemark] location] coordinate] andTitle:[[[item placemark] addressDictionary] objectForKey:@"Name"]];
            MKCoordinateSpan span = {.latitudeDelta =  0.5, .longitudeDelta =  0.5};
            MKCoordinateRegion region = {[[[item placemark] location] coordinate], span};
            
            [self->mapView setRegion:region];
            [self->mapView addAnnotation:annot];
			
			NSDictionary* addressDict = [[item placemark] addressDictionary];
			NSLog(@"addressDict = %@", addressDict);
			[textView setText: [NSString stringWithFormat:@"City = %@\nCountry = %@\nCountryCode = %@\nName = %@\nState = %@\nSubAdministrativeArea = %@\nSubLocality = %@\nZIP = %@",
								[addressDict objectForKey:@"City"],
								[addressDict objectForKey:@"Country"],
								[addressDict objectForKey:@"CountryCode"],
								[addressDict objectForKey:@"Name"],
								[addressDict objectForKey:@"State"],
								[addressDict objectForKey:@"SubAdministrativeArea"],
								[addressDict objectForKey:@"SubLocality"],
								[addressDict objectForKey:@"ZIP"]
								]];

        }
    }];
//	CLGeocoder* geocoder = [[CLGeocoder alloc] init];
//	[geocoder geocodeAddressString:search completionHandler:^(NSArray *placemarks, NSError *error) {
//		NSLog(@"placemarks = %@", placemarks);
//		if(placemarks){
//            for (CLPlacemark* placemark in placemarks) {
//                
//                IPPMapKitAnnotation* resultAnnot = [[IPPMapKitAnnotation alloc] initWithCLLocationCoordinate2D:[[placemark location] coordinate] andTitle:[[placemark addressDictionary] objectForKey:@"City"]];
//                
//                
//                MKCoordinateSpan span = {.latitudeDelta =  50, .longitudeDelta =  50};
//                MKCoordinateRegion region = {[[placemark location] coordinate], span};
//                
//                [self->mapView setRegion:region animated:YES];
//                [self->mapView addAnnotation:resultAnnot];
//    //				[self->randomLocationsArray addObject:resultAnnot];
//                
//                [textView setText:[NSString stringWithFormat:@"name = %@\ncountry = %@\nadministrativeArea = %@\nlocality = %@\npostalCode = %@\nthoroughfare = %@\nareasOfInterest = %@", placemark.name, placemark.country, placemark.administrativeArea, placemark.locality, placemark.postalCode, placemark.thoroughfare, placemark.areasOfInterest]];
//            }
//			result = YES;
//		}else{
//			[textView setText:@"The Internet connection appears to be offline."];
//		}
//		
//	}];
	
	return result;
	
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


#pragma mark -
#pragma mark MKMapViewDelegate methods
-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
	[self->randomLocationTextView setText:@""];
	[self->mapView removeAnnotations:self->randomLocationsArray];
	[self->randomLocationsArray removeAllObjects];
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
	if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    else if ([annotation isKindOfClass:[IPPMapKitCustomAnnotation class]])
    {
		IPPMapKitCustomAnnotation* resultAnnot = (IPPMapKitCustomAnnotation*)annotation;
        static NSString * const identifier = @"CustomAnnotation";
		
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
		
        annotationView.image = resultAnnot.image;
        annotationView.canShowCallout = YES;
		[annotationView setBackgroundColor:[UIColor clearColor]];

		[annotationView.layer setBorderColor:[UIColor whiteColor].CGColor];
		[annotationView.layer setBorderWidth:5];
		
		[annotationView.layer setShadowColor:[UIColor blackColor].CGColor];
		[annotationView.layer setShadowOpacity:0.5f];
		[annotationView.layer setShadowRadius:5.0f];
		[annotationView.layer setShadowOffset:CGSizeMake(3, -3)];
		
        return annotationView;
    }
	
    return nil;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
	if ([overlay isKindOfClass:[MKPolygon class]])
	{
		MKPolygonView *polyView = [[MKPolygonView alloc] initWithPolygon:(MKPolygon*)overlay];
		polyView.fillColor = [[UIColor orangeColor] colorWithAlphaComponent:0.2];
		polyView.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
		polyView.lineWidth = 1;
		return polyView;
	}
	
    if ([overlay isKindOfClass:IPPCampusOverlay.class]) {
        UIImage *magicMountainImage = [UIImage imageNamed:@"Campus_ov"];
        IPPCampusOverlayView *overlayView = [[IPPCampusOverlayView alloc] initWithOverlay:overlay overlayImage:magicMountainImage];
		
        return overlayView;
    }
	
    return nil;

}


#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
	
        [self configureView];
    }
	
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
	if (self.detailItem) {
	    self.detailDescriptionLabel.text = [self.detailItem description];
	}
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Map Controls", @"Map controls split view button");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];

	self.masterPopoverController = popoverController;
	
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark -
#pragma mark IPPMapKitPopoverViewControllerDelegate

-(void)setTravelMode:(UISegmentedControl *)sender{
	switch (sender.selectedSegmentIndex) {
		case 0:
			self->directionRequest.transportType = MKDirectionsTransportTypeWalking;
			break;
		
		case 1:
			self->directionRequest.transportType = MKDirectionsTransportTypeAutomobile;
			break;
			
//		case 2:
//			self->directionRequest.transportType = MKDirectionsTransportTypeAny;
//			break;
			
		default:
			break;
	}
	
}

-(void)setSource:(UITextField *)sender{
	//source
	MKLocalSearchRequest* searchReq = [[MKLocalSearchRequest alloc] init];
    searchReq.naturalLanguageQuery = sender.text;
    searchReq.region = self->mapView.region;
    
    MKLocalSearch* sourceSearch = [[MKLocalSearch alloc] initWithRequest:searchReq];
    
    [sourceSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
		self->directionRequest.source = [response.mapItems firstObject];
    }];

}

-(void)setDestination:(UITextField *)sender{
	//destination
	MKLocalSearchRequest* searchReq = [[MKLocalSearchRequest alloc] init];
    searchReq.naturalLanguageQuery = sender.text;
    searchReq.region = self->mapView.region;
    
    MKLocalSearch* destinationSearch = [[MKLocalSearch alloc] initWithRequest:searchReq];
    [destinationSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
		self->directionRequest.destination = [response.mapItems firstObject];
    }];
}

-(void)triggerDirection:(UIButton*)sender{// withSource:(UITextField*)sourceField andDestination:(UITextField*)destinationField{
	

	[self->mapView removeOverlays:self->directionsArray];
	[self->directionsArray removeAllObjects];
	[self->directionsPopoverController dismissPopoverAnimated:YES];
	
	NSLog(@"self->directionRequest = %@",self->directionRequest);

	MKDirections *directions =
	[[MKDirections alloc] initWithRequest:self->directionRequest];
	
	[directions calculateDirectionsWithCompletionHandler:
	 ^(MKDirectionsResponse *response, NSError *error) {
		 if (error) {
			 // Handle Error
			 NSLog(@"The Internet connection appears to be offline.");
		 } else {
			 for (MKRoute *route in response.routes)
			 {
				 [self->mapView
				  addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
				 [self->directionsArray addObject:route.polyline];
			 }
		 }
	 }];

}

@end
