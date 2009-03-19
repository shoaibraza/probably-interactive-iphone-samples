//
//  TableView_ImagesAppDelegate.m
//  TableView-Images
//
//  Created by ProbablyInteractive on 3/19/09.
//  Copyright Probably Interactive 2009. All rights reserved.
//

#import "TableView_ImagesAppDelegate.h"
#import "GiantBombViewController.h"

@implementation TableView_ImagesAppDelegate

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
