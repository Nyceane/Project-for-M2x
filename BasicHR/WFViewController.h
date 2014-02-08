//
//  WFViewController.h
//  BasicHR
//
//  Created by Murray Hughes on 26/10/12.
//  Copyright (c) 2012 Wahoo Fitness. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WFViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *antPlusSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *bluetoothSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *suuntoSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *wildcardSwitch;

@property (weak, nonatomic) IBOutlet UIButton *connectButton;

@property (weak, nonatomic) IBOutlet UILabel *hrLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialLabel;

- (IBAction)connectButtonTouched:(id)sender;

@end
