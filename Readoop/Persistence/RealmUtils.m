//
//  RealmUtils.m
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "RealmUtils.h"
#import "User.h"
#import "Request.h"
#import "Post.h"

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

+ (User*)getUserById:(NSNumber*)userId {
    User *retrievedUser = [[User objectsWhere:@"userId == %@",userId] firstObject];
    
    return retrievedUser;
    
}

+ (void)addUser:(User*)user toFriendListOfUser:(User*)secondUser {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [secondUser.friends addObject:user];
    }];
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

+ (void)createRequestfromUser:(User*)sender toUser:(User*)receiver {
    RLMRealm *realm = [RLMRealm defaultRealm];
    Request *request = [Request new];
    request.senderId = sender.userId;
    request.receiverId = receiver.userId;
    request.creationTime = [NSDate date];
    NSNumber *primaryKey = [[Request allObjects] maxOfProperty:@"requestId"];
    int key = [primaryKey intValue] + 1;
    request.requestId = [NSNumber numberWithInt:key];
    
    [realm transactionWithBlock:^{
        [realm addObject:request];
    }];
}

+ (void)deleteRequest:(Request*)request {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [realm deleteObject:request];
    }];
}

+ (void)deleteUser:(User*)user fromFriendListOfUser:(User*)secondUser {
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSUInteger index = [secondUser.friends indexOfObject:user];
    [realm transactionWithBlock:^{
        [secondUser.friends removeObjectAtIndex:index];
    }];
}

+ (void)createFeedPostByUser:(User*)user withContent:(NSString*)content {
    RLMRealm *realm = [RLMRealm defaultRealm];
    Post *post = [Post new];
    post.userId = user.userId;
    NSNumber *primaryKey = [[Post allObjects] maxOfProperty:@"postId"];
    int key = [primaryKey intValue] + 1;
    post.postId = [NSNumber numberWithInt:key];
    post.content = content;
    post.datePosted = [NSDate date];
    
    [realm transactionWithBlock:^{
        [realm addObject:post];
        //[realm deleteObjects:[Post allObjects]];
    }];
}

+ (void)insertUserToUps:(User*)user forFeedPost:(Post*)feedPost {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [feedPost.upRates addObject:user];
    }];
}

+ (void)insertUserToDowns:(User*)user forFeedPost:(Post*)feedPost {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [feedPost.downRates addObject:user];
    }];
}

+ (void)removeUserToUps:(User*)user forFeedPost:(Post*)feedPost {
    RLMRealm *realm = [RLMRealm defaultRealm];
    if([[feedPost.upRates objectsWhere:@"userId == %@",user.userId] firstObject]){ //remove user if it exists in upRates
        NSUInteger index = [feedPost.upRates indexOfObject:user];
        [realm transactionWithBlock:^{
            [feedPost.upRates removeObjectAtIndex:index];
        }];
    }
}

+ (void)removeUserToDowns:(User*)user forFeedPost:(Post*)feedPost {
    RLMRealm *realm = [RLMRealm defaultRealm];
    if([[feedPost.downRates objectsWhere:@"userId == %@",user.userId] firstObject]){ //remove user if it exists in downRates
        NSUInteger index = [feedPost.downRates indexOfObject:user];
        [realm transactionWithBlock:^{
            [feedPost.downRates removeObjectAtIndex:index];
        }];
    }
}

@end
