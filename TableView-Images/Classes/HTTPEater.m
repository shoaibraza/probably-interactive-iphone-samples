//
//  HTTPEater.m
//  JSONTest
//
//  Created by Corey Johnson on 10/7/08.

#import "HTTPEater.h"
#import "HTTPEaterConnectionDelegate.h"
#import "HTTPEaterResponse.h"

@implementation HTTPEater

+ (HTTPEaterResponse *)get:(id)url {
	return [self get:url headerFields:nil];
}

+ (HTTPEaterResponse *)get:(id)url headerFields:(NSDictionary *)headerFields {
	if ([url isKindOfClass:[NSString class]]) { // Can take a string or a NSURL
		url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		url = [NSURL URLWithString:url];
	}
	
	HTTPEaterResponse *httpResponse;
	httpResponse = [self downloadURL:url method:@"GET" body:nil headerFields:headerFields];
	
	return httpResponse;
}

+ (HTTPEaterResponse *)post:(id)url body:(NSData *)body {
	return [self post:url body:body headerFields:nil];
}

+ (HTTPEaterResponse *)post:(id)url body:(NSData *)body headerFields:(NSDictionary *)headerFields {
	if ([url isKindOfClass:[NSString class]]) url = [NSURL URLWithString:url]; 	// Can take a string or a NSURL
	HTTPEaterResponse *httpResponse = [self downloadURL:url method:@"POST" body:body headerFields:headerFields];
	return httpResponse;
}


+ (HTTPEaterResponse *)downloadURL:(NSURL *)url method:(NSString *)method body:(NSData *)body headerFields:(NSDictionary *)headerFields {
	if (DEBUG) NSLog(@"%@: %@", method, url);
	if (DEBUG && body) {
		if (body.length < 2000) {
			NSLog(@"(%d bytes) %@", body.length, [[[NSString alloc] initWithData:body encoding:NSASCIIStringEncoding] autorelease]);
		}
		else {
			NSLog(@"(%d bytes) Body is too long to display", body.length);
		}
	}
		
	NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:45];				
	
	[urlRequest setAllHTTPHeaderFields:headerFields];
	[urlRequest setHTTPMethod:method];
	[urlRequest setHTTPBody:body];	
	[urlRequest setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	[urlRequest setHTTPShouldHandleCookies:NO];
	
	NSError *error = nil;	
	NSHTTPURLResponse *urlResponse = nil;	
	NSData *bodyResponse = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&urlResponse error:&error];	
	[urlRequest release];	

	
	return [[[HTTPEaterResponse alloc] initWithResponse:urlResponse body:bodyResponse error:error] autorelease];
}

// Helper Methods
// --------------
+ (NSString *)queryDictionaryToString:(NSDictionary *)query {
	NSMutableArray *queryArray = [[NSMutableArray alloc] init];
	for (id key in query) {
		[queryArray addObject:[NSString stringWithFormat:@"%@=%@", key, [query objectForKey:key]]];
	}
	
	NSString *queryString = [queryArray componentsJoinedByString:@"&"];	
	[queryArray release];
	
	return queryString;
}

+ (NSURL *)urlWithProtocol:(NSString *)protocol host:(NSString *)host port:(int)port path:(NSString *)path query:(id)query {
	NSMutableString *urlString = [[NSMutableString alloc] init];
	[urlString appendFormat:@"%@://", protocol ? protocol : @"http"];
	if (host) [urlString appendString:host];
	if (port && port != 80) [urlString appendFormat:@":%d", port];
	if (path) [urlString appendFormat:@"/%@", path];
	if (query) {
		if ([query isKindOfClass:[NSDictionary class]]) [urlString appendFormat:@"?%@", [self queryDictionaryToString:query]];
		else [urlString appendFormat:@"?%@", query];
	}
	
	NSURL *url = [NSURL URLWithString:urlString];	
	[urlString release];
	return url;
}

@end
