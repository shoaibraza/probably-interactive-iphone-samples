//
//  Game.m
//  TableViewCellLoading
//
//  Created by ProbablyInteractive on 3/19/09.
//  Copyright 2009 Probably Interactive. All rights reserved.
//

#import "Game.h"
#import "HTTPEater.h"
#import "HTTPEaterResponse.h"

@implementation Game

- (id)initWithAttributes:(NSDictionary *)attributes {
	if (self = [super init]) {
		_attributes = [attributes retain];
	}
	
	return self;
}

- (void)dealloc {
	[_image release];
	[_attributes release];
	[super dealloc];	
}

- (NSString *)name {
	return [_attributes valueForKey:@"name"];
}

- (NSString *)urlString {
	return [_attributes valueForKeyPath:@"image.thumb_url"];
}

- (UIImage *)image {
	return _image;
}

- (void)setImage:(UIImage *)image {
	[_image release];
	_image = image;
}


- (void)downloadImage {
	[_image release];
	
	if (![self urlString] || [[self urlString] isEqual:[NSNull null]]) {
		_image = [[UIImage imageNamed:@"noImage.png"] retain];
		return; // No url? Then no Image!
	}
	
	HTTPEaterResponse *response = [HTTPEater get:[self urlString]];
		
	if ([response isSuccessful]) {
		_image = [[UIImage alloc] initWithData:[response body]];
	}
	else {
		_image = [[UIImage imageNamed:@"noImage.png"] retain];
	}
}

@end
