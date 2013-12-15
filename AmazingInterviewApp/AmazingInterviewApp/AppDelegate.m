//
//  AppDelegate.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 12/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "AppDelegate.h"
#import "FMDatabaseManager.h"
#import "MyProfileViewController.h"
#import "FriendsViewController.h"
#import "AppNavigationController.h"
#import "AppTabBarController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    //copy the database into the app if needed
    [[FMDatabaseManager sharedInstance] copyDatabaseIfNeeded:@"interview.db"];
    
    //create
    [self createViewControllers];
    
    //customistations
    [self performCustomisations];
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark Instance Methods

// Create the inital view controller(s) of the app
- (void) createViewControllers
{
    //create pointers for view controllers
    UIViewController * myDetailsViewController = [[MyProfileViewController alloc] init];
    UIViewController * friendsViewController = [[FriendsViewController alloc] init];
    
    //add each to their own nav controller
    AppNavigationController * detailsNavController = [[AppNavigationController alloc] initWithRootViewController:myDetailsViewController];
    
    AppNavigationController * friendsNavController = [[AppNavigationController alloc] initWithRootViewController:friendsViewController];
    
    //create array of these nav controller to be submitted to the tab bar controller
    NSArray * tabBarViewControllerArray = [[NSArray alloc] initWithObjects:detailsNavController,friendsNavController, nil];
    
    //add each nav controller to the tab bar controller
    AppTabBarController * tabBarController = [[AppTabBarController alloc] init];
    [tabBarController setViewControllers:tabBarViewControllerArray];
    
    //add completed tab bar controller to the windows
    [[self window] setRootViewController:tabBarController];
    
}

// Customise the app in any way we want here. Theme colors etc
- (void) performCustomisations
{
    
}

// Customise the Navigation Bars' appearance
- (void) customiseNavigationBar
{
    
}


@end
