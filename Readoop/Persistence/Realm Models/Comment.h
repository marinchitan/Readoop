//
//  Comment.h
//  Readoop
//
//  Created by Marin Chitan on 21/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Book.h"

@interface Comment : RLMObject
@property NSNumber<RLMInt> *commentId;

@property NSString *contents;
@property NSNumber<RLMInt> *userId;

@property NSNumber<RLMInt> *numberOfPositiveRates;
@property NSNumber<RLMInt> *numberOfNegativeRates;
@property (readonly) RLMLinkingObjects *commentedBook;

@end
