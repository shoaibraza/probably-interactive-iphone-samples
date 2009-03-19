//
//  GameTableViewCell.h
//  TableViewCellLoading
//
//  Created by Corey Johnson on 3/16/09.
//  Copyright 2009 Probably Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game;

@interface GameTableViewCell : UITableViewCell {
	UILabel *_infoLabel;
	UIImageView *_gameImageView;
	UIActivityIndicatorView *_imageLoadingView;
	
	NSThread *_thread;
	
	Game *_game;
}

- (void)setGame:(Game *)game;
- (void)showImage;

@end
