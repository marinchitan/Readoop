//
//  AppLabels.m
//  Readoop
//
//  Created by Marin Chitan on 20/02/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "AppLabels.h"

@implementation AppLabels

+ (NSString *)getLengthError:(NSString *)field withExcepectedLength:(NSString *)length{
    return [NSString stringWithFormat:@"The %@ field should containt at least %@ characters.",field,length];
}

+ (NSString *)getSpaceError:(NSString *)field{
    return [NSString stringWithFormat:@"The %@ field should not contain spaces.",field];
}

+ (NSString *)getUniqueUsernameError {
    return @"Username already in use. Please pick another one.";
}

+ (NSString *)getDifferentPasswordsError {
    return [NSString stringWithFormat:@"The passwords do not match, please retype the password in Confirm password field."];
}

+ (NSString *)getEmailError{
    return [NSString stringWithFormat:@"Please supply a valid email adress."];
}

+ (NSString *)getNameError {
    return [NSString stringWithFormat:@"The name field can not contain numbers."];
}

+ (NSString *)getWrongOldPasswordError {
    return [NSString stringWithFormat:@"Wrong old password"];
}

+ (NSString *)getDifferentNewPasswordsError {
    return [NSString stringWithFormat:@"The passwords do not match, please retype the new password."];
}

@end
