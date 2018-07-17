//
//  URLSessionManager.h
//  Readoop
//
//  Created by Marin Chitan on 29/06/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "WritingComment.h"
#import "BookRate.h"
#import "Post.h"

@interface URLSessionManager : NSObject

//Google API Books
- (void)startBookRequests;

//Request
- (void)loadRequestsFromMongo;

- (void)postRequestToMongo:(Request *)request;

- (void)deleteRequest:(NSNumber *)requestId;

//WritingComment
- (void)loadWritingCommentsFromMongo;

- (void)postWritingCommentsToMongo:(WritingComment *)writingComment;

//BookRate
- (void)loadBookRatesFromMongo;

- (void)postBookRateToMongo:(BookRate *)bookRate;

//Post
- (void)loadPostsFromMongo;

- (void)postPostToMongo:(Post *)post;


//Wrting

- (void)postWritingToMongo:(Writing *)writing;

- (void)loadWritingsFromMongo;


+ (id)sharedSession;


@end
