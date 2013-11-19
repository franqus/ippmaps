//
//  IPPMapKitPopverViewController.h
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 19.11.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IPPMapKitPopverViewController;
@protocol IPPMapKitPopverViewControllerDelegate <NSObject>

-(void)setTravelMode:(UISegmentedControl*)sender;
-(void)setSource:(UITextField*)sender;
-(void)setDestination:(UITextField*)sender;
-(void)triggerDirection:(UIButton*)sender;// withSource:(UITextField*)sourceField andDestination:(UITextField*)destinationField;

@end

@interface IPPMapKitPopverViewController : UIViewController <UITextFieldDelegate>
{
	UISegmentedControl* travelModeSegmentedControl;
	UITextField* sourceTextfield;
	UITextField* destinationTextfield;
	UIButton* triggerDirectionButton;
}
@property (nonatomic, weak) id <IPPMapKitPopverViewControllerDelegate> delegate;

@end
