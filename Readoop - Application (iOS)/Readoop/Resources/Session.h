//
//  Session.h
//  Readoop
//
//  Created by Marin Chitan on 18/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

typedef enum wayOfArrival{
   register_path,
   login_path,
   seamless,
   others_path
}ArrivalWay;

@interface Session : NSObject 

@property(nonatomic, assign) ArrivalWay wayOfArrival; //Give a welcome message when entering dashboard for first time from Login or Register pages
@property(nonatomic, strong) User *currentUser;

@property(nonatomic, assign) BOOL justRegistered;


+ (id)sharedSession;

@end
