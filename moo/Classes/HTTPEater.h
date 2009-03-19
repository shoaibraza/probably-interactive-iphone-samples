//
//  HTTPEater.h
//  JSONTest
//
//  Created by Corey Johnson on 10/7/08.

#import <UIKit/UIKit.h>

@class HTTPEaterResponse;

@interface HTTPEater : NSObject {

}

+ (HTTPEaterResponse *)get:(id)url;
+ (HTTPEaterResponse *)get:(id)url headerFields:(NSDictionary *)headerFields;
	
+ (HTTPEaterResponse *)post:(id)url body:(NSData *)body;
+ (HTTPEaterResponse *)post:(id)url body:(NSData *)body headerFields:(NSDictionary *)headerFields;
	
+ (HTTPEaterResponse *)downloadURL:(NSURL *)url method:(NSString *)method body:(NSData *)body headerFields:(NSDictionary *)headerFields;
+ (NSString *)queryDictionaryToString:(NSDictionary *)query;
+ (NSURL *)urlWithProtocol:(NSString *)protocol host:(NSString *)host port:(int)port path:(NSString *)path query:(id)query;

@end
