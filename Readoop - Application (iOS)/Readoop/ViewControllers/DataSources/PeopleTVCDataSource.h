//
//  PeopleTVCDataSource.h
//  Readoop
//
//  Created by Marin Chitan on 21/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>
#import "User.h"

@interface PeopleTVCDataSource : NSObject

+ (RLMArray*)getAllUsers;
+ (RLMArray*)getFriendsOfUser:(User*)user;
+ (RLMArray*)getUsersForCurrentSelection:(NSString*)selection;

@end
