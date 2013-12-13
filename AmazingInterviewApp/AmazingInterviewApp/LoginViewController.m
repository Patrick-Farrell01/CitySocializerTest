//
//  LoginViewController.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 12/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize textFieldEmailAddress, textFieldPassword, labelLoginMessage;

- (id)init
{
    self = [super initWithNibName:@"LoginViewController" bundle:nil];
    if (self)
    {
        
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customiseApperance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Instance Methods

- (void) customiseApperance
{
    
}

// Action when the 'Login' button has been pressed
- (IBAction)loginButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Action when the 'Cancel' button has been pressed
- (IBAction)cancelLoginPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
