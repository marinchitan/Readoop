//
//  RealmUtils.m
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "RealmUtils.h"
#import "User.h"

@implementation RealmUtils

+ (void)addUserObject:(User *)user {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [realm addObject:user];
    }];
}

+ (User*)getUserByName:(NSString*)name byPassword:(NSString*)password {
    User *retrievedUser = [[User objectsWhere:@"username == %@",name] firstObject];
    if(retrievedUser){
        if([retrievedUser.password isEqualToString:password]){
            return retrievedUser;
        }
    }
    return nil;
}

+ (void)changeRememberStatusForUser:(User*)user shouldBeRemembered:(BOOL)remember {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.shouldBeRemembered = remember;
    }];
}

+ (void)changePasswordForUser:(User*)user newPasswrod:(NSString*)newPassword {
    RLMRealm *realm = [RLMRealm defaultRealm];
   
    [realm transactionWithBlock:^{
        user.password = newPassword;
    }];
}

@end
