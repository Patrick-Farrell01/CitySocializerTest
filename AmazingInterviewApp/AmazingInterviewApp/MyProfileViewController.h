//
//  MyDetailsViewController.h
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 12/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyProfileViewController : UIViewController


// **** Members **** //

@property (strong, nonatomic) IBOutlet UILabel *labelUsername;

// **** Methods **** //

- (void) populateViewControllerData;
- (void) checkUserAuthenticated;
- (void) presentLoginViewController;

@end
