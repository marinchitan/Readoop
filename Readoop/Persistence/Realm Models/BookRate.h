//
//  BookRate.h
//  Readoop
//
//  Created by Marin Chitan on 13/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface BookRate : RLMObject

@property NSNumber<RLMInt> *userId;
@property NSNumber<RLMInt> *rate; //1 to 5

@end
