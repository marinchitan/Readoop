//
//  StatusManager.h
//  Readoop
//
//  Created by Marin Chitan on 02/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <UIKit/UIKit.h>

typedef enum statusType{
    Beginner,
    Amateur,
    Experienced,
    Prof
}Status;

@interface StatusManager : NSObject

+ (Status)getStatusForUser:(User *)user;

+ (NSString *)getStatusNameForUser:(User *)user;

+ (UIColor *)getStatusColorForUser:(User *)user;

@end
