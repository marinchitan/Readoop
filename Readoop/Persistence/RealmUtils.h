//
//  RealmUtils.h
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface RealmUtils : NSObject

+ (void)addUserObject:(User *)user;

+ (User*)getUserByName:(NSString*)name byPassword:(NSString*)password;

+ (void)changeRememberStatusForUser:(User*)user shouldBeRemembered:(BOOL)remember;
+ (void)changePasswordForUser:(User*)user newPassword:(NSString*)newPassword;
+ (void)changeCountryForUser:(User*)user newCountry:(NSString*)country;
+ (void)changeCityForUser:(User*)user newCity:(NSString*)city;
+ (void)changeDateForUser:(User*)user newDate:(NSDate*)date;
@end
