//
//  MyDetailsViewController.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 12/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "MyProfileViewController.h"
#import "FacebookSessionManager.h"
#import "TwitterLoginViewController.h"
#import "UserAccountManager.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController
@synthesize labelUsername;

#pragma mark LifeCycle Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self setTitle:@"My Profile"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self checkUserAuthenticated];
    [self populateViewControllerData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Instance Methods

// Checks the FBSession state. Present login page if not authenticated
- (void) checkUserAuthenticated
{
    //check users preference for facebook / twitter
    
    // if (facebook)
    
//    //check the session
//    BOOL sessionOpen = [[[FacebookSessionManager sharedInstance] session] isOpen];
//    
//    if(!sessionOpen)
//    {
//        //present the login view controller
//        [self presentLoginViewController];
//        
//    }
    
}

- (void) populateViewControllerData
{
    NSString * username = [[[UserAccountManager sharedInstance] currentUser] username];
    
    //set the current username
    [[self labelUsername] setText:username];
}

// Present the LoginViewController for logging in via Faceboook
- (void) presentLoginViewController
{
    LoginViewController * loginViewController = [[TwitterLoginViewController alloc] init];
    [loginViewController setModalPresentationStyle:UIModalPresentationNone];
    
    [self presentViewController:loginViewController animated:YES completion:nil];
    
}

@end
