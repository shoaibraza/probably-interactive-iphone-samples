//
//  HTTPEaterConnectionDelegate.m
//  JSONTest
//
//  Created by Corey Johnson on 10/7/08.
//

#import <UIKit/UIKit.h>

@interface HTTPEaterConnectionDelegate : NSObject {
	NSMutableData *_body;
	NSHTTPURLResponse *_response;
	NSError *_error;
	BOOL _done;
	
}

- (BOOL) isDone;

@property(nonatomic, readonly) NSHTTPURLResponse *response;
@property(nonatomic, readonly) NSMutableData *body;
@property(nonatomic, readonly) NSError *error;

@end
