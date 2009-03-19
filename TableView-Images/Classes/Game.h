//
//  Game.h
//  TableViewCellLoading
//
//  Created by ProbablyInteractive on 3/19/09.
//  Copyright 2009 Probably Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Game : NSObject {
	NSDictionary *_attributes;
	UIImage *_image;
}

- (id)initWithAttributes:(NSDictionary *)attributes;

- (NSString *)name;
- (UIImage *)image;
- (void)setImage:(UIImage *)image;
- (void)downloadImage;

@end
