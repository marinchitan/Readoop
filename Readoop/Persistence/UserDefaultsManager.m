//
//  UserDefaultsManager.m
//  Readoop
//
//  Created by Marin Chitan on 22/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "UserDefaultsManager.h"
#import "User.h"
#import "Session.h"

@implementation UserDefaultsManager

+ (void)saveCredentialsUsername:(NSString*)username password:(NSString*)password {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:username forKey:@"cachedUsername"];
    [userDefaults setObject:password forKey:@"cachedPassword"];
    
    [userDefaults synchronize];
}

+ (BOOL)checkCredentialsValability {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *cachedUsername = [userDefaults objectForKey:@"cachedUsername"];
    NSString *cachedPassword = [userDefaults objectForKey:@"cachedPassword"];
    User *retrievedUser = [[User objectsWhere:@"username == %@ AND password == %@", cachedUsername, cachedPassword] firstObject];
    if(retrievedUser){
        NSLog(@"Can be seamless logged");
        Session *appSession = [Session sharedSession];
        appSession.currentUser = retrievedUser;
        appSession.wayOfArrival = seamless;
        return YES;
    }
    NSLog(@"Can not be seamless logged");
    return NO;
}

+ (User*)getCurrentUser {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *cachedUsername = [userDefaults objectForKey:@"cachedUsername"];
    NSString *cachedPassword = [userDefaults objectForKey:@"cachedPassword"];
    User *retrievedUser = [[User objectsWhere:@"username == %@ AND password == %@", cachedUsername, cachedPassword] firstObject];
    return retrievedUser;
}

+ (NSString*)getCurrentUsername {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"cachedUsername"];
}
+ (NSString*)getCurrentPassword {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"cachedPassword"];
}

@end
