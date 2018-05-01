//
//  FeedTVCDataSource.m
//  Readoop
//
//  Created by Marin Chitan on 30/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "FeedTVCDataSource.h"
#import "Post.h"
#import "Session.h"
#import "User.h"

@implementation FeedTVCDataSource

+ (RLMArray*)getAllFeedPosts {
    return [Post allObjects];
}

+ (RLMArray*)getFriendsFeedPosts {
    RLMArray *friendsPost = [[RLMArray alloc] initWithObjectClassName:Post.className];
    NSMutableArray *usersFriends = [NSMutableArray new];
    Session *session = [Session sharedSession];
    
    for(User* user in session.currentUser.friends){
        [usersFriends addObject:user.userId];
    }
    
    for(Post *post in [Post allObjects]){
        if([usersFriends containsObject:post.userId]) {
            [friendsPost addObject:post];
        }
    }
    
    return friendsPost;
    
}
@end
