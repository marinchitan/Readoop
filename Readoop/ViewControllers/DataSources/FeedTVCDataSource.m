//
//  FeedTVCDataSource.m
//  Readoop
//
//  Created by Marin Chitan on 30/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "FeedTVCDataSource.h"
#import "Post.h"

@implementation FeedTVCDataSource

+ (RLMArray*)getAllFeedPosts {
    return [Post allObjects];
}

@end
