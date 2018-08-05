//
//  Request.h
//  Readoop
//
//  Created by Marin Chitan on 23/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface Request : RLMObject

@property NSNumber<RLMInt> *requestId;
@property NSNumber<RLMInt> *senderId;
@property NSNumber<RLMInt> *receiverId;
@property NSDate *creationTime;


@end
