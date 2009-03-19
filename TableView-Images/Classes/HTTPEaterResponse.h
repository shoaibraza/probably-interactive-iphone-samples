//
//  HTTPEaterResponse.h
//  HTTPEaterAnalytics
//
//  Created by Corey Johnson on 11/3/08.
//
#import <UIKit/UIKit.h>


@interface HTTPEaterResponse : NSObject {
	NSMutableData *_body;
	NSInteger _statusCode;
	NSError *_error;
	NSDictionary *_headers;
}

@property (nonatomic, readonly) NSMutableData *body;
@property (nonatomic, readonly) NSInteger statusCode;
@property (nonatomic, readonly) NSError *error;
@property (nonatomic, readonly) NSDictionary *headers;

- (id)initWithResponse:(NSHTTPURLResponse *)response body:(NSData *)body error:(NSError *)error;

- (BOOL)isSuccessful;
- (BOOL)isFailure;

@end
