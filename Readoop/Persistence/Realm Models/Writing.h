//
//  Writing.h
//  Readoop
//
//  Created by Marin Chitan on 19/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "BookRate.h"
#import "Comment.h"

@class Comment;
@class User;
RLM_ARRAY_TYPE(Comment)
RLM_ARRAY_TYPE(BookRate);

@interface Writing : RLMObject
@property NSNumber<RLMInt> *writingId;

@property NSString *writingTitle;
@property NSString *writingAuthor;

@property NSString *writingDescription;
@property NSData *writingContent;

@property NSNumber<RLMInt> *writingPrice;

//@property RLMArray<Comment *><Comment> *comments; //post-pred

@end
