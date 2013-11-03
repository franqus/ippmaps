//
//  IPPMainViewController.m
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 15.10.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import "IPPMainViewController.h"


@interface IPPMainViewController ()

@end

@implementation IPPMainViewController

- (id)init
{
    self = [super init];
    if (self) {
		self.title = @"MainVC";
		[self.view setBackgroundColor:[UIColor whiteColor]];
    
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
