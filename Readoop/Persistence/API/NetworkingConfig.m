//
//  NetworkingConfig.m
//  Readoop
//
//  Created by Marin Chitan on 30/06/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "NetworkingConfig.h"

@implementation NetworkingConfig

+ (NSString *)getGoogleAPIKey {
    return @"AIzaSyDRIWyukiR-HLfdVU8YT7Jqha-1RH0j1x8";
}

+ (NSString *)getGoogleURLStringWithAuthor:(NSString *)author withKey:(NSString *)apiKey {
    NSString *urlString = @"https://www.googleapis.com/books/v1/volumes?q=inauthor:{author}&key={key}";
    NSString *formatedString = [urlString stringByReplacingOccurrencesOfString:@"{author}" withString:author];
    NSString *finalUrlSting = [formatedString stringByReplacingOccurrencesOfString:@"{key}" withString:apiKey];
    
    return finalUrlSting;
}

+ (NSString *)getRequestsHostString {
    return @"http://localhost:3000/requests";
}

+ (NSString *)getWritingCommentHostString {
    return @"http://localhost:3000/writingComments";
}

+ (NSString *)getBookRateHostString {
    return @"http://localhost:3000/bookRates";
}

+ (NSString *)getPostsHostString {
    return @"http://localhost:3000/posts";
}

+ (NSString *)getWritingsHostString {
    return @"http://localhost:3000/writings";
}

@end

