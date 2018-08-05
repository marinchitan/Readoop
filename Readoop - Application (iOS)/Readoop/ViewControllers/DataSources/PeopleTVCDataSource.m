//
//  PeopleTVCDataSource.m
//  Readoop
//
//  Created by Marin Chitan on 21/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "PeopleTVCDataSource.h"
#import "Session.h"


@implementation PeopleTVCDataSource

+ (RLMArray*)getAllUsers {
    Session *appS = [Session sharedSession];
    RLMArray *users = [[RLMArray alloc] initWithObjectClassName:User.className];
    [users addObjects:[User objectsWhere:@"username != %@", appS.currentUser.username]];
    return users;
    //return [User allObjects];
}
+ (RLMArray*)getFriendsOfUser:(User*)user {
    return user.friends;
}
+ (RLMArray*)getUsersForCurrentSelection:(NSString*)selection {
    return nil;
}

@end
