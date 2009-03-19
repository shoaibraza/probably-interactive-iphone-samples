//
//  TableView_ImagesAppDelegate.h
//  TableView-Images
//
//  Created by ProbablyInteractive on 3/19/09.
//  Copyright Probably Interactive 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GiantBombViewController;

@interface TableView_ImagesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *_window;
	UIViewController *_viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

