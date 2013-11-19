//
//  IPPMapKitPopverViewController.m
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 19.11.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//


#define IPPMapKitPopverViewControllerSourceTextfieldTag 1
#define IPPMapKitPopverViewControllerDestinationTextfieldTag 2

#import "IPPMapKitPopverViewController.h"

@interface IPPMapKitPopverViewController ()

@end

@implementation IPPMapKitPopverViewController
@synthesize delegate;
- (id)init
{
    self = [super init];
    if (self) {
		
		self->travelModeSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Foot", @"Car"]];
		[self->travelModeSegmentedControl setFrame:CGRectMake(10, 10, 160, 30)];
		[self->travelModeSegmentedControl setSelectedSegmentIndex:1];
		[self.view addSubview:self->travelModeSegmentedControl];
		
		self->triggerDirectionButton = [[UIButton alloc] initWithFrame:CGRectMake(self->travelModeSegmentedControl.frame.origin.x+self->travelModeSegmentedControl.frame.size.width+10, self->travelModeSegmentedControl.frame.origin.y, 50, 30)];
		[self->triggerDirectionButton setTitle:@"Go" forState:UIControlStateNormal];
		[self->triggerDirectionButton setTitleColor:[UIColor colorWithRed:9/255.f green:92/255.f blue:255/255.f alpha:1.0] forState:UIControlStateNormal];
		[self->triggerDirectionButton addTarget:self action:@selector(triggerDirection:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:self->triggerDirectionButton];
		
		self->sourceTextfield = [[UITextField alloc] initWithFrame:CGRectMake(self->travelModeSegmentedControl.frame.origin.x, self->travelModeSegmentedControl.frame.origin.y + self->travelModeSegmentedControl.frame.size.height + 5, 220, 30)];
		[self->sourceTextfield setText:@"From..."];
		[self->sourceTextfield setBackgroundColor:[UIColor whiteColor]];
		[self->sourceTextfield setTextAlignment:NSTextAlignmentCenter];
		self->sourceTextfield.layer.cornerRadius = 5.0;
		self->sourceTextfield.layer.borderColor = [UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1.0f].CGColor;
		[self->sourceTextfield setTextColor:[UIColor blackColor]];
		self->sourceTextfield.layer.borderWidth = 1.0f;
		self->sourceTextfield.returnKeyType = UIReturnKeySearch;
		self->sourceTextfield.delegate = self;
		self->sourceTextfield.tag = IPPMapKitPopverViewControllerSourceTextfieldTag;
		[self.view addSubview:self->sourceTextfield];
		
		self->destinationTextfield = [[UITextField alloc] initWithFrame:CGRectMake(self->sourceTextfield.frame.origin.x, self->sourceTextfield.frame.origin.y + self->sourceTextfield.frame.size.height + 5, self->sourceTextfield.frame.size.width, 30)];
		[self->destinationTextfield setText:@"To..."];
		[self->destinationTextfield setBackgroundColor:[UIColor whiteColor]];
		[self->destinationTextfield setTextAlignment:NSTextAlignmentCenter];
		self->destinationTextfield.layer.cornerRadius = 5.0;
		self->destinationTextfield.layer.borderColor = [UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1.0f].CGColor;
		[self->destinationTextfield setTextColor:[UIColor blackColor]];
		self->destinationTextfield.layer.borderWidth = 1.0f;
		self->destinationTextfield.returnKeyType = UIReturnKeySearch;
		self->destinationTextfield.delegate = self;
		self->destinationTextfield.tag = IPPMapKitPopverViewControllerDestinationTextfieldTag;
		[self.view addSubview:self->destinationTextfield];


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

-(void)setTravelMode:(UISegmentedControl*)sender{
	[delegate setTravelMode:sender];
}

-(void)setSource:(UITextField*)sender{
	[delegate setSource:sender];
}

-(void)setDestination:(UITextField*)sender{
	[delegate setDestination:sender];
}

-(void)triggerDirection:(UIButton*)sender{
	[delegate triggerDirection:sender];// withSource:self->sourceTextfield andDestination:self->destinationTextfield];
}


#pragma mark -
#pragma mark UITextFielDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
	textField.text = @"";
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
	if ([textField.text isEqualToString:@""] && textField.tag == IPPMapKitPopverViewControllerSourceTextfieldTag) {
		textField.text = @"From";
	}else if ([textField.text isEqualToString:@""] && textField.tag == IPPMapKitPopverViewControllerDestinationTextfieldTag) {
		textField.text = @"To";
	}
	else{
		if(textField.tag == IPPMapKitPopverViewControllerSourceTextfieldTag){
			[self setSource:self->sourceTextfield];
		}else if(textField.tag == IPPMapKitPopverViewControllerDestinationTextfieldTag){
			[self setDestination:self->destinationTextfield];
		}
	}
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField endEditing:YES];
	return [textField resignFirstResponder];
}


@end
