//
//  UserDefaultsManager.h
//  Readoop
//
//  Created by Marin Chitan on 22/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsManager : NSObject

+ (void)saveCredentialsUsername:(NSString*)username password:(NSString*)password;
+ (BOOL)checkCredentialsValability;
+ (NSString*)getCurrentUsername;
+ (NSString*)getCurrentPassword;

@end
