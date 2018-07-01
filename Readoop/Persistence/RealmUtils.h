//
//  RealmUtils.h
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Request.h"
#import "Post.h"

@interface RealmUtils : NSObject

+ (void)addUserObject:(User *)user;

+ (User*)getUserByName:(NSString*)name byPassword:(NSString*)password;
+ (User*)getUserById:(NSNumber*)userId;

+ (void)addUser:(User*)user toFriendListOfUser:(User*)secondUser;
+ (void)deleteUser:(User*)user fromFriendListOfUser:(User*)secondUser;

+ (void)changeRememberStatusForUser:(User*)user shouldBeRemembered:(BOOL)remember;
+ (void)changePasswordForUser:(User*)user newPassword:(NSString*)newPassword;
+ (void)changeCountryForUser:(User*)user newCountry:(NSString*)country;
+ (void)changeCityForUser:(User*)user newCity:(NSString*)city;
+ (void)changeDateForUser:(User*)user newDate:(NSDate*)date;
+ (void)changeUsernameForUser:(User*)user newUsername:(NSString*)username;
+ (void)changeEmailForUser:(User*)user newEmail:(NSString*)email;
+ (void)changeFullNameForUser:(User*)user newName:(NSString*)name;
+ (void)changeAvatarForUser:(User*)user newAvatar:(NSData*)avatar;
+ (void)changeFirstTimeRegister:(User*)user newFlag:(BOOL)flag;

+ (void)createRequestfromUser:(User*)sender toUser:(User*)receiver;
+ (void)deleteRequest:(Request*)request;

+ (void)createFeedPostByUser:(User*)user withContent:(NSString*)content;

+ (void)insertUserToUps:(User*)user forFeedPost:(Post*)feedPost;
+ (void)insertUserToDowns:(User*)user forFeedPost:(Post*)feedPost;
+ (void)removeUserToUps:(User*)user forFeedPost:(Post*)feedPost;
+ (void)removeUserToDowns:(User*)user forFeedPost:(Post*)feedPost;

+ (NSString*)getRatingOfUser:(User*)user ofBook:(Book*)book;
+ (void)setRatingForBook:(Book*)book rating:(float)rating byUser:(User*)user;
+ (float)getInitialRatingForBook:(Book*)book forUser:(User*)user;

+ (void)addBook:(Book*)book toUser:(User*)user;
+ (void)removeBook:(Book*)book fromUser:(User*)user;
+ (BOOL)user:(User*)user hasBook:(Book*)book;

+ (void)addWriting:(Writing*)writing toUser:(User*)user;
+ (BOOL)user:(User*)user hasBoughtWriting:(Writing*)writing;
+ (BOOL)user:(User*)user isAuthorOfWriting:(Writing*)writing;

+ (void)addBooksFromAPI:(NSMutableArray *)books;
+ (void)clearBooks;

+ (NSString *)getAverageRatingOfBook:(Book *)book;



@end
