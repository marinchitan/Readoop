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
#import "User.h"
#import "BookRate.h"

@class Comment;
@class User;
RLM_ARRAY_TYPE(Comment)
RLM_ARRAY_TYPE(BookRate);


@interface Book : RLMObject
@property NSNumber<RLMInt> *bookId;

@property NSString *bookTitle;
@property NSString *bookAuthor;
@property NSString *bookPublisher;
@property NSString *bookPublishedYear;
@property NSNumber<RLMInt> *pages;

@property NSString *imageName;
@property NSString *imageWithURL;

@property NSData *coverImage;

@property RLMArray<BookRate *><BookRate> *rates;
//@property RLMArray<Comment *><Comment> *comments; //post-pred

@end
