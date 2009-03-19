//
//	GiantBombViewController.m
//	TableViewCellLoading
//
//	Created by Corey Johnson on 3/16/09.
//	Copyright 2009 Probably Interactive. All rights reserved.
//

#import "GiantBombViewController.h"
#import "GameTableViewCell.h"

#import "Game.h"
#import "HTTPEater.h"
#import "HTTPEaterResponse.h"
#import "CJSONDeserializer.h"

static NSString *API_KEY = @"a3c9efad67bb42f0881032edb1c6b39449944090";
static int LIMIT = 50;

@implementation GiantBombViewController

- (id)init {
	if (self = [super initWithNibName:@"GiantBombView" bundle:nil]) {
		_offset = 0;
		_games = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)dealloc {
	[_games release];
	[_loadMoreGamesView release];
	[_tableView release];
	[super dealloc];
}

- (void)viewDidLoad {
	_tableView.dataSource = self;
	_tableView.delegate = self;
	
	[NSThread detachNewThreadSelector:@selector(downloadGames) toTarget:self withObject:nil];
}

- (void)didReceiveMemoryWarning {
	for (Game *game in _games) {
		[game setImage:nil];
	}
}

- (void)downloadGames {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	[_tableView performSelectorOnMainThread:@selector(setTableFooterView:) withObject:_loadingView waitUntilDone:NO];
	
	NSString *url = [NSString stringWithFormat:@"http://api.giantbomb.com/games/?limit=%d&offset=%d&api_key=%@&format=json", LIMIT, _offset, API_KEY];
	HTTPEaterResponse *response = [HTTPEater get:url];
	if ([response isSuccessful]) {
		NSError *error;
		NSDictionary *json = [[CJSONDeserializer deserializer] deserialize:[response body] error:&error];
		_totalGameCount = [[json objectForKey:@"number_of_total_results"] intValue];

		for (NSDictionary *gameAttributes in [json valueForKey:@"results"]) {
			Game *game = [[Game alloc] initWithAttributes:gameAttributes];
			[_games addObject:game];
			[game release];
		}
		
		_offset += LIMIT;
		
		[_tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES]; // UI changes need to run in the main thread
	}
	else {
		NSLog(@"NO CONNECTION");
	}
	
	if (_games.count >= _totalGameCount) {
		[_tableView performSelectorOnMainThread:@selector(setTableFooterView:) withObject:nil waitUntilDone:NO]; // No more games! Stop loading
	}
	else {
		[_tableView performSelectorOnMainThread:@selector(setTableFooterView:) withObject:_loadMoreGamesView waitUntilDone:NO];
	}
	
	[pool release];
}

- (IBAction)downloadGamesPressed:(id)sender {
	[NSThread detachNewThreadSelector:@selector(downloadGames) toTarget:self withObject:nil];
}

// UITableView DataSource
// ----------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
	return _games.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
	static NSString *CellIdentifier = @"GiantBombViewControllerCell";

	GameTableViewCell *cell = (GameTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[GameTableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	Game *game = [_games objectAtIndex:indexPath.row];
	
	[cell setGame:game];

	return cell;
}

// UITableView Delegate
// --------------------
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	[(GameTableViewCell *)cell showImage];
}

@end
