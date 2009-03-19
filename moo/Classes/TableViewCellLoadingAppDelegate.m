//
//  TableViewCellLoadingAppDelegate.m
//  TableViewCellLoading
//
//  Created by Corey Johnson on 3/16/09.
//  Copyright Probably Interactive 2009. All rights reserved.
//

#import "TableViewCellLoadingAppDelegate.h"
#import "GiantBombViewController.h"

@implementation TableViewCellLoadingAppDelegate

@synthesize window=_window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	_viewController = [[GiantBombViewController alloc] init];
	
	[_window addSubview:_viewController.view];
    [_window makeKeyAndVisible];
}


- (void)dealloc {
	[_viewController release];
    [_window release];
    [super dealloc];
}


@end
