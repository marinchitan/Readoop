//
//  Post.h
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "User.h"

RLM_ARRAY_TYPE(User);

@interface Post : RLMObject

@property NSNumber<RLMInt> *postId;
@property NSNumber<RLMInt> *userId;
@property NSDate* datePosted;

@property NSString *content;

@property RLMArray<User *><User> *upRates;
@property RLMArray<User *><User> *downRates;

@end
