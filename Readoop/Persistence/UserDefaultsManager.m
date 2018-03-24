//
//  UserDefaultsManager.m
//  Readoop
//
//  Created by Marin Chitan on 22/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "UserDefaultsManager.h"

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
    NSLog(@"UserDefaults User:%@ Password:%@",cachedUsername,cachedPassword);
    return YES;
}
+ (NSString*)getCurrentUsername {
    return @"";
}
+ (NSString*)getCurrentPassword {
    return @"";
}

@end
