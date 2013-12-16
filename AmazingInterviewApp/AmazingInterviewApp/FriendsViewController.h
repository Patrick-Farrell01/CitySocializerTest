//
//  MyFriendsViewController.h
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 12/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsPlIstLoader.h"
#import "TableViewCellAction.h"

@interface FriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TableViewCellAction>

// **** Members **** //

@property (strong, nonatomic) IBOutlet UITableView *tableViewFriends;
@property (strong, nonatomic) NSArray * friends;
@property (nonatomic) BOOL isFriendsList;
@property (nonatomic, retain) FriendsPlistLoader * pendingFriendsLoader;


@property (strong, nonatomic) IBOutlet UIButton *btnFriends;
@property (strong, nonatomic) IBOutlet UIButton *btnFriendRequests;


// **** Members **** //

- (void) customiseUI;
- (void) populateViewControllerData;
- (void) loadCurrentFriends;
- (void) loadFriendRequestData;
- (UITableViewCell *) cellForFriendList:(UITableView *)tableView atIndex:(NSIndexPath *)indexPath;
- (UITableViewCell *) cellForFriendRequestList:(UITableView *)tableView atIndex:(NSIndexPath *)indexPath;
- (IBAction)friendsButtonClicked:(id)sender;
- (IBAction)friendRequestButtonClicked:(id)sender;


@end
