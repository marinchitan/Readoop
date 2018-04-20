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

+ (void)changePasswordForUser:(User*)user newPassword:(NSString*)newPassword {
    RLMRealm *realm = [RLMRealm defaultRealm];
   
    [realm transactionWithBlock:^{
        user.password = newPassword;
    }];
}

+ (void)changeCountryForUser:(User*)user newCountry:(NSString*)country {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.country = country;
    }];
}

+ (void)changeCityForUser:(User*)user newCity:(NSString*)city {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.city = city;
    }];
}

+ (void)changeDateForUser:(User*)user newDate:(NSDate*)date {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.dateOfBirth = date;
    }];
}

+ (void)changeUsernameForUser:(User*)user newUsername:(NSString*)username {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.username = username;
    }];
}

+ (void)changeEmailForUser:(User*)user newEmail:(NSString*)email {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.email = email;
    }];
}

+ (void)changeFullNameForUser:(User*)user newName:(NSString*)name {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.fullName = name;
    }];
}

+ (void)changeAvatarForUser:(User*)user newAvatar:(NSData*)avatar {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.avatar = avatar;
    }];
}

+ (void)changeFirstTimeRegister:(User*)user newFlag:(BOOL)flag {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        user.firstTimeRegsitered = flag;
    }];
}

@end
