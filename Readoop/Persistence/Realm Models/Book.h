//
//  Book.h
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Comment.h"

@class Comment;
RLM_ARRAY_TYPE(Comment)
@interface Book : RLMObject
@property NSNumber<RLMInt> *bookId;

@property NSString *bookAuthor;
@property NSString *bookDescription;
@property NSString *imageName;

@property NSNumber<RLMInt> *numberOfRates;
@property NSNumber<RLMDouble> *averageRate;

@property RLMArray<Comment *><Comment> *comments;


@end
