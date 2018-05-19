//
//  Comment.h
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Book.h"
#import "User.h"

@class User;
RLM_ARRAY_TYPE(User);

@interface Comment : RLMObject
@property NSNumber<RLMInt> *commentId;

@property NSString *contents;
@property NSNumber<RLMInt> *userId;

@property RLMArray<User *><User> *upRates;
@property RLMArray<User *><User> *downRates;

@property (readonly) RLMLinkingObjects *commentedBook;

@end
