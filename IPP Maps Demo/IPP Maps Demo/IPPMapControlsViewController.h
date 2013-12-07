//
//  IPPMapControlsViewController.h
//  IPP Maps Demo
//
//  Created by Frank Schmitt on 07.11.13.
//  Copyright (c) 2013 HS Mannheim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IPPMapKitViewController;
@protocol IPPMapControlsViewControllerDelegate <NSObject>

-(void)changeMapType:(UISegmentedControl*)sender;
-(void)toggleZoom:(UISwitch*)sender;
-(void)toggleScroll:(UISwitch*)sender;
-(void)toggleRotate:(UISwitch*)sender;
-(void)togglePitch:(UISwitch*)sender;
-(void)toggleBuildings:(UISwitch*)sender;
-(void)togglePOIS:(UISwitch*)sender;
-(void)toggleUserLocation:(UISwitch*)sender;
-(void)toggleAnnotation:(UISwitch*)sender;
-(void)toggleCustomAnnotation:(UISwitch*)sender;
-(void)toggleOverlays:(UISwitch*)sender;
-(void)goToRandomLocation:(UIButton*)sender withTextView:(UITextView*)textView;
-(BOOL)goToLocation:(NSString*)search withTextView:(UITextView*)textView;

@end

@interface IPPMapControlsViewController : UITableViewController <UISplitViewControllerDelegate, UITextFieldDelegate>

@property (nonatomic, weak) id <IPPMapControlsViewControllerDelegate> delegate;
@property (strong, nonatomic) IPPMapKitViewController *detailViewController;

@end
