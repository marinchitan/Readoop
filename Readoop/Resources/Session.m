//
//  Session.m
//  Readoop
//
//  Created by Marin Chitan on 18/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "Session.h"
#import <Foundation/Foundation.h>

@implementation Session

+ (id)sharedSession {
    static Session *appSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appSession = [[self alloc] init];
    });
    return appSession;
}

- (id)init {
    if(self = [super init]){
        //DO somet default initialization
    }
    return self;
}



@end
