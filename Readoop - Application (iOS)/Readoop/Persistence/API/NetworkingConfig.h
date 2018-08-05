//
//  NetworkingConfig.h
//  Readoop
//
//  Created by Marin Chitan on 30/06/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingConfig : NSObject

+ (NSString *)getGoogleAPIKey;
+ (NSString *)getGoogleURLStringWithAuthor:(NSString *)author withKey:(NSString *)apiKey;
+ (NSString *)getRequestsHostString;
+ (NSString *)getWritingCommentHostString;
+ (NSString *)getBookRateHostString;
+ (NSString *)getPostsHostString;
+ (NSString *)getWritingsHostString;
+ (NSString *)getUsersHostString;


@end
