//
//  Writing.h
//  Readoop
//
//  Created by Marin Chitan on 19/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>


@interface Writing : RLMObject
@property NSNumber<RLMInt> *writingId;
@property NSNumber<RLMInt> *authorId;

@property NSString *writingTitle;
@property NSString *writingAuthor;

@property NSString *writingDescription;
@property NSDate *dateAdded
@property NSData *writingContent;

@property NSData *coverImage;

@property NSNumber<RLMInt> *writingPrice;

//@property RLMArray<Comment *><Comment> *comments; //post-pred

@end
