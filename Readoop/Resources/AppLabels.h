//
//  AppLabels.h
//  Readoop
//
//  Created by Marin Chitan on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppLabels : NSObject


+ (NSString *)getLengthError:(NSString *)field withExcepectedLength:(NSString *)length;
+ (NSString *)getSpaceError:(NSString *)field;
+ (NSString *)getUniqueUsernameError;
+ (NSString *)getDifferentPasswordsError;
+ (NSString *)getEmailError;
+ (NSString *)getNameError;

@end
