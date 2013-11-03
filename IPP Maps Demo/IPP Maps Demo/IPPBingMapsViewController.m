//
//  IPPBingMapsViewController.m
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 15.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import "IPPBingMapsViewController.h"

@interface IPPBingMapsViewController ()

@end

@implementation IPPBingMapsViewController

- (id)init
{
    self = [super init];
    if (self) {
		[self setTitle:@"Bing Maps"];
		[self.tabBarItem setImage:[UIImage imageNamed:@"Bing_Logo"]];
		[self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"Bing_Logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

		
		self->bingMapView = [[BMMapView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width)];
		
		//adding the mapView to superview's subviews
		[self.view addSubview:self->bingMapView];
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
