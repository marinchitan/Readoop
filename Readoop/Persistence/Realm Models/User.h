//
//  User.h
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Book.h"

@class Book;
@class User;
RLM_ARRAY_TYPE(Book);
RLM_ARRAY_TYPE(User);

@interface User : RLMObject
@property NSNumber<RLMInt> *userId;

@property NSString *username;
@property NSString *password;
@property NSString *fullName;
@property NSString *email;
@property NSString *imageName;

//Additional info
@property NSDate *dateOfBirth;
@property NSString *city;
@property NSString *country;

//Flags
@property BOOL shouldBeRemembered;
@property BOOL firstTimeRegsitered;

@property NSNumber<RLMInt> *status;
@property RLMArray<Book *><Book> *books;
@property RLMArray<User *><User> *friends;

@end
