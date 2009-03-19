//
//  HTTPEaterResponse.m
//  HTTPEaterAnalytics
//
//  Created by Corey Johnson on 11/3/08.
//
#import "HTTPEaterResponse.h"

@implementation HTTPEaterResponse

@synthesize body=_body;
@synthesize statusCode=_statusCode;
@synthesize error=_error;
@synthesize headers=_headers;

- (id)initWithResponse:(NSHTTPURLResponse *)response body:(NSData *)body error:(NSError *)error {
	if (self = [super init]) {
		if (response) {
			_body = [body retain];
			_statusCode = [response statusCode];
			_headers = [[response allHeaderFields] retain];
		}
	
		_error = [error retain];
	}
	
	return self;
}

- (void)dealloc {
	[_body release];
	[_error release];
	[_headers release];
	[super dealloc];
}

- (BOOL)isSuccessful {
	return _statusCode >= 200 && _statusCode < 400;
}

- (BOOL)isFailure {
	return ![self isSuccessful];
}

- (NSString *)description {
	NSString *bodyString = [[NSString alloc] initWithData:_body encoding:NSUTF8StringEncoding];
	NSString *description = [NSString stringWithFormat:@"status: %d\nerror: %@\n%@", _statusCode, [_error localizedDescription], bodyString];
	[bodyString release];
	
	return description;
}

@end
