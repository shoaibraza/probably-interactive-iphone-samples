//
//  HTTPEaterConnectionDelegate.m
//  JSONTest
//
//  Created by Corey Johnson on 10/7/08.
//

#import "HTTPEaterConnectionDelegate.h"

@implementation HTTPEaterConnectionDelegate

@synthesize response=_response;
@synthesize body=_body;
@synthesize error=_error;

- (id)init {		
	if (self = [super init]) {
		_body = [[NSMutableData alloc] init];
		_done = NO;
	}
	return self;
}

- (void) dealloc {
	[_body release];
	[_response release];
	[_error release];
	[super dealloc];
}


- (BOOL)isDone {
	return _done;
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
	return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	[[challenge sender] useCredential:[challenge proposedCredential] forAuthenticationChallenge:challenge];
}
- (void)connection:(NSURLConnection *)connection didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	_done = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	_response = [response retain];
}

- (void)connection:(NSURLConnection *)connection didReceivebody:(NSData *)body {
	[_body appendData:body];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	_done = YES;
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
	_error = [error retain];
	_done = YES;
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
	return nil; // No caching! 
}

@end
