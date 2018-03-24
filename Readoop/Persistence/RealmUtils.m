//
//  RealmUtils.m
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "RealmUtils.h"

@implementation RealmUtils

+ (void)addUserObject:(User *)user {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [realm addObject:user];
    }];
}

@end
