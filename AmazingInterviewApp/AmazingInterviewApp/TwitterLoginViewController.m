//
//  TwitterLoginViewController.m
//  AmazingInterviewApp
//
//  Created by Patrick Farrell on 13/12/2013.
//  Copyright (c) 2013 PatrickFarrell. All rights reserved.
//

#import "TwitterLoginViewController.h"


@interface TwitterLoginViewController ()

@end

@implementation TwitterLoginViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Customise the appearance of the TwitterViewController. Overridden from superclass.
- (void) customiseApperance
{
    //set the background color of the view to custom twitter color
    [[self view] setBackgroundColor:[[CustomColorsLoader sharedInstance] customColorWithName:@"TwitterBlue" withAlpha:1.0f]];
    [[self  labelLoginMessage] setText:@"Log in with Twitter"];
}

@end
