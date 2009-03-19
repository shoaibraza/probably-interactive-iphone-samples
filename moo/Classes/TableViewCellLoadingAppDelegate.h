//
//  TableViewCellLoadingAppDelegate.h
//  TableViewCellLoading
//
//  Created by Corey Johnson on 3/16/09.
//  Copyright Probably Interactive 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellLoadingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *_window;
	UIViewController* _viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

