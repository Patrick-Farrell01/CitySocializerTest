//
//  MyFriendsViewController.h
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 12/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

// **** Members **** //

@property (strong, nonatomic) IBOutlet UITableView *tableViewFriends;
//@property (strong, nonatomic) NSArray * friendRequests;
//@property (strong, nonatomic) NSArray * currentFriends;
@property (strong, nonatomic) NSArray * friends;


@property (strong, nonatomic) IBOutlet UIButton *btnFriends;
@property (strong, nonatomic) IBOutlet UIButton *btnFriendRequests;


// **** Members **** //

- (void) populateViewControllerData;
- (void) loadCurrentFriends;
- (void) loadFriendRequestData;
- (IBAction)friendsButtonClicked:(id)sender;
- (IBAction)friendRequestButtonClicked:(id)sender;

@end
