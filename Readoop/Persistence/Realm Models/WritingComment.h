//
//  WritingComment.h
//  Readoop
//
//  Created by Marin Chitan on 04/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "User.h"

RLM_ARRAY_TYPE(User);

#import <Foundation/Foundation.h>

@interface WritingComment : RLMObject

@property NSNumber<RLMInt> *writingCommentId;
@property NSNumber<RLMInt> *writingId;
@property NSNumber<RLMInt> *userId;
@property NSDate* datePosted;

@property NSString *content;

@property RLMArray<User *><User> *upRates;
@property RLMArray<User *><User> *downRates;

@end
