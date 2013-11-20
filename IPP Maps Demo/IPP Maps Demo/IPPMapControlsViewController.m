//
//  IPPMapControlsViewController.m
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 07.11.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import "IPPMapControlsViewController.h"
#import "IPPMapKitViewController.h"

typedef enum MapControl : NSUInteger {
	Search,
    MapType,
    Scroll,
    Zoom,
	Rotation,
	Pitch,
	Buildings,
	POIs,
	UserLocation,
	MapPins,
	CustomAnnotations,
	Overlays,
	RandomLocation,
	LocationInfo
} MapControl;

@interface IPPMapControlsViewController (){
	NSMutableArray *_objects;
	UITextView* locationTextView;

	
}

@end

@implementation IPPMapControlsViewController
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
		self.clearsSelectionOnViewWillAppear = NO;
		self.detailViewController = (IPPMapKitViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
        
        
		// TableView data
        if (!_objects) {
            _objects = [[NSMutableArray alloc] init];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [_objects addObject:@"Search Location"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
		
        [_objects addObject:@"MapType"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

        [_objects addObject:@"Scroll"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

        [_objects addObject:@"Zoom"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [_objects addObject:@"Rotation"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [_objects addObject:@"Pitch"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [_objects addObject:@"Buildings"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [_objects addObject:@"POIs"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [_objects addObject:@"User Location"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [_objects addObject:@"Map Pins"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [_objects addObject:@"Custom Annotations"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [_objects addObject:@"Overlays"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [_objects addObject:@"Random Location"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
 
        [_objects addObject:@"LocationInfo"];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

		[_objects addObject:@""];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

		
		self.tableView.scrollEnabled = NO;
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

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifierSegmentedControl = @"SegmentedControlCell";
    static NSString *cellIdentifierSwitch = @"SwitchCell";
    static NSString *cellIdentifierTextfield = @"TextfieldCell";
    static NSString *cellIdentifierButton = @"ButtonCell";
    static NSString *cellIdentifierTextview = @"TextviewCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];

    switch( [indexPath row] ) {
        case MapType: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSegmentedControl];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSArray* mapTypes = @[@"Standard",@"Hybrid",@"Satellite"];
                UISegmentedControl* mapTypeControl = [[UISegmentedControl alloc] initWithItems:mapTypes];
                [mapTypeControl setFrame:CGRectMake(cell.contentView.frame.size.width-215, cell.contentView.frame.size.height/2-15, 200, 30)];
                [mapTypeControl addTarget:self action:@selector(changeMapType:) forControlEvents:UIControlEventValueChanged];
                [mapTypeControl setSelectedSegmentIndex:0];
                [cell.contentView addSubview:mapTypeControl];
                
            }
            return cell;
        }
        case Scroll: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSwitch];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                [switchView setOn:YES animated:NO];
                [switchView addTarget:self action:@selector(toggleScroll:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
            
        case Zoom: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSwitch];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                [switchView setOn:YES animated:NO];
                [switchView addTarget:self action:@selector(toggleZoom:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
            
        case Rotation: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSwitch];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                [switchView setOn:YES animated:NO];
                [switchView addTarget:self action:@selector(toggleRotate:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
            
            
        case Pitch: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSwitch];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                [switchView setOn:YES animated:NO];
                [switchView addTarget:self action:@selector(togglePitch:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
            
        case Buildings: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSwitch];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                [switchView setOn:YES animated:NO];
                [switchView addTarget:self action:@selector(toggleBuildings:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
            
        case POIs: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSwitch];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                [switchView setOn:YES animated:NO];
                [switchView addTarget:self action:@selector(togglePOIS:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
            
        case UserLocation: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSwitch];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                [switchView setOn:NO animated:NO];
                [switchView addTarget:self action:@selector(toggleUserLocation:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
            
        case MapPins: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSwitch];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                [switchView setOn:YES animated:NO];
                [switchView addTarget:self action:@selector(toggleAnnotation:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
            
        case CustomAnnotations: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSwitch];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                [switchView setOn:YES animated:NO];
                [switchView addTarget:self action:@selector(toggleCustomAnnotation:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
            
        case Overlays: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSwitch];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                [switchView setOn:YES animated:NO];
                [switchView addTarget:self action:@selector(toggleOverlays:) forControlEvents:UIControlEventValueChanged];
            }
            return cell;
        }
            
        case RandomLocation: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierButton];
                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UIButton* goToRandomLocationControl = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [goToRandomLocationControl setBackgroundColor:[UIColor clearColor]];
                [goToRandomLocationControl.layer setBorderWidth:1.0f];
                [goToRandomLocationControl.layer setBorderColor:[UIColor colorWithRed:9/255.f green:92/255.f blue:255/255.f alpha:1.0].CGColor];
                [goToRandomLocationControl.layer setCornerRadius:5.0f];
                [goToRandomLocationControl setFrame:CGRectMake(cell.contentView.frame.size.width-67, cell.contentView.frame.size.height/2-15, 53, 30)];
                [goToRandomLocationControl setTitle:@"Go" forState:UIControlStateNormal];
                [goToRandomLocationControl addTarget:self action:@selector(goToRandomLocation:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:goToRandomLocationControl];

            }
            return cell;
        }
            
        case Search: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierTextfield];
//                cell.textLabel.text = [_objects objectAtIndex:[indexPath row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                UITextField* searchTextfield = [[UITextField alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width/2-145, cell.contentView.frame.size.height/2-15, 290, 30)];
                [searchTextfield setText:@"Search..."];
                [searchTextfield setDelegate:self];
                [searchTextfield setBackgroundColor:[UIColor whiteColor]];
                [searchTextfield setTextAlignment:NSTextAlignmentCenter];
                searchTextfield.layer.cornerRadius = 5.0;
                searchTextfield.layer.borderColor = [UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1.0f].CGColor;
                [searchTextfield setTextColor:[UIColor blackColor]];
                searchTextfield.layer.borderWidth = 1.0f;
                searchTextfield.returnKeyType = UIReturnKeySearch;
                [cell.contentView addSubview:searchTextfield];
                
                
            }
            return cell;
        }
            
        case LocationInfo: {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierSwitch];
            if( cell == nil ) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierTextview];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
				
				self->locationTextView = [[UITextView alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width/2-145, 0, 290, 150)];
				[self->locationTextView setText:@""];
				[self->locationTextView setFont: [UIFont systemFontOfSize:13]];
                [self->locationTextView setScrollEnabled:NO];
				[self->locationTextView setEditable:NO];
                
                [cell.contentView addSubview:self->locationTextView];
                
            }
            return cell;
        }
            
    }
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierSwitch];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	if([indexPath indexAtPosition:1] == LocationInfo){
		return 150;
	}else{
		return tableView.rowHeight;
	}
}

-(void)changeMapType:(UISegmentedControl*)sender{
    [delegate changeMapType:sender];
}

-(void)toggleZoom:(UISwitch*)sender{
    [delegate toggleZoom:sender];
}

-(void)toggleScroll:(UISwitch*)sender{
    [delegate toggleScroll:sender];
}

-(void)toggleRotate:(UISwitch*)sender{
    [delegate toggleRotate:sender];
}

-(void)togglePitch:(UISwitch*)sender{
    [delegate togglePitch:sender];
}

-(void)toggleBuildings:(UISwitch*)sender{
    [delegate toggleBuildings:sender];
}

-(void)togglePOIS:(UISwitch*)sender{
    [delegate togglePOIS:sender];
}

-(void)toggleUserLocation:(UISwitch*)sender{
    [delegate toggleUserLocation:sender];
}

-(void)toggleAnnotation:(UISwitch*)sender{
    [delegate toggleAnnotation:sender];
}

-(void)toggleCustomAnnotation:(UISwitch*)sender{
    [delegate toggleCustomAnnotation:sender];
}

-(void)toggleOverlays:(UISwitch*)sender{
    [delegate toggleOverlays:sender];
}

-(void)goToRandomLocation:(UIButton*)sender{
    [delegate goToRandomLocation:sender withTextView:self->locationTextView];
}


#pragma mark -
#pragma mark UITextFieldDelegate methods
-(void)textFieldDidBeginEditing:(UITextField *)textField{
	textField.text = @"";
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
	if ([textField.text isEqualToString:@""]) {
		textField.text = @"Search...";
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
	return [delegate goToLocation:textField.text withTextView:self->locationTextView];
}

@end