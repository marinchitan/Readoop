//
//  Comment.m
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "Comment.h"
#import "Book.h"

@implementation Comment

+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"commentedBook": [RLMPropertyDescriptor descriptorWithClass:Book.class propertyName:@"comments"],
             };
}

+ (NSString *)primaryKey {
    return @"commentId";
}

@end
