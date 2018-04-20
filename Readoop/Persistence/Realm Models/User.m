//
//  User.m
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "User.h"
#import <UIKit/UIKit.h>

@implementation User

+ (NSString *)primaryKey {
    return @"userId";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"fullName" : @"",
             @"email": @"",
             @"status":@0,
             @"avatar": UIImagePNGRepresentation([UIImage imageNamed:@"defaultImage"]),
             @"firstTimeRegsitered":@1
             };
}

@end
