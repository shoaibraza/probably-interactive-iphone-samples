//
//	GiantBombViewController.h
//	TableViewCellLoading
//
//	Created by Corey Johnson on 3/16/09.
//	Copyright 2009 Probably Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GiantBombViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *_tableView;
	IBOutlet UIView *_loadMoreGamesView;
	IBOutlet UIView *_loadingView;
	
	NSMutableArray *_games;
	int _offset;
	int _totalGameCount;
}

- (IBAction)downloadGamesPressed:(id)sender;

@end
