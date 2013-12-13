//
//  LoginViewController.h
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 12/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomColorsLoader.h"

@interface LoginViewController : UIViewController

// **** Members **** //

@property (strong, nonatomic) IBOutlet UILabel *labelLoginMessage;
@property (strong, nonatomic) IBOutlet UITextField *textFieldEmailAddress;

@property (strong, nonatomic) IBOutlet UITextField *textFieldPassword;

@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnCancelLogin;

// **** Methods **** //

- (void) customiseApperance;
- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)cancelLoginPressed:(id)sender;



@end
