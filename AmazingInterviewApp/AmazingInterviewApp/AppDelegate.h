//
//  AppDelegate.h
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 12/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

// **** Members **** //

@property (strong, nonatomic) UIWindow *window;


// **** Methods **** //

- (void) createViewControllers;
- (void) performCustomisations;
- (void) customiseNavigationBar;

@end
