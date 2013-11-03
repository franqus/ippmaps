//
//  IPPGoogleMapsViewController.m
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 15.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import "IPPGoogleMapsViewController.h"

@interface IPPGoogleMapsViewController ()

@end

@implementation IPPGoogleMapsViewController

- (id)init
{
    self = [super init];
    if (self) {
		[self setTitle:@"Google Maps"];
		[self.tabBarItem setImage:[UIImage imageNamed:@"Google_Logo"]];
		[self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"Google_Logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

		
		GMSCameraPosition *myCam = [GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(0, 0) zoom:0];
		
		self->googleMapView = [GMSMapView mapWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) camera:myCam];
		
		[self.view addSubview:self->googleMapView];
	
	}
    return self;
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

@end
