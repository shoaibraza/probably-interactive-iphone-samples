//
//  GameTableViewCell.m
//  TableViewCellLoading
//
//  Created by Corey Johnson on 3/16/09.
//  Copyright 2009 Probably Interactive. All rights reserved.
//

#import "GameTableViewCell.h"
#import "Game.h"

@implementation GameTableViewCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {		
        _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 239, 43)];
		_infoLabel.font = [UIFont systemFontOfSize:17];
		[self addSubview:_infoLabel];		
		
		_gameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
		_gameImageView.clipsToBounds = YES;
		_gameImageView.contentMode = UIViewContentModeScaleAspectFill;
		[self addSubview:_gameImageView];
		
		_imageLoadingView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
		_imageLoadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
		_imageLoadingView.hidesWhenStopped;
		_imageLoadingView.contentMode = UIViewContentModeCenter;
		[_imageLoadingView startAnimating];		
		
		[self addSubview:_imageLoadingView];
    }
    return self;
}

- (void)dealloc {
	[_thread cancel];
	[_thread release];
	[_infoLabel release];
	[_gameImageView release];
	[_imageLoadingView release];
	[_game release];
	[super dealloc];
}

- (void)setGame:(Game *)game {
	[game retain];
	[_game release];
	_game = game;

	_infoLabel.text = [_game name];
	[_imageLoadingView startAnimating];
}

- (void)showImage {
	@synchronized(self) {			
		if ([[NSThread currentThread] isCancelled]) return;

		[_thread cancel]; // Cell! Stop what you were doing!
		[_thread release];
		_thread = nil;
				
		_gameImageView.image = nil; // Clear the image.

		if ([_game image]) {
			// If the image has already been downloaded.
			_gameImageView.image = [_game image];
			[_imageLoadingView stopAnimating];
		}
		else {
			// We need to download the image, get it in a seperate thread!
			_thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
			[_thread start];
		}			
	}		
}

- (void)downloadImage {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[NSThread sleepForTimeInterval:0.2]; // Why sleep? Because if we are scrolling fast the thread will be canceled and we don't want to start downloading.
	
	if (![[NSThread currentThread] isCancelled]) {
		[_game downloadImage];
		
		@synchronized(self) {
			if (![[NSThread currentThread] isCancelled]) {
			[_gameImageView performSelectorOnMainThread:@selector(setImage:) withObject:[_game image] waitUntilDone:NO];								
			[_imageLoadingView performSelectorOnMainThread:@selector(stopAnimating) withObject:nil waitUntilDone:NO];
			}
		}
	}
	
	[pool release];
}

@end
