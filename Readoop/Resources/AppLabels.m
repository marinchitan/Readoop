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
    return [NSString stringWithFormat:@"The %@ field should be at least %@ characters long.",field,length];
}

+ (NSString *)getSpaceError:(NSString *)field{
    return [NSString stringWithFormat:@"The %@ field should not contain spaces.",field];
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

@end
