//
//  URLSessionManager.h
//  Readoop
//
//  Created by Marin Chitan on 29/06/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLSessionManager : NSObject

- (void)startBookRequests;

+ (id)sharedSession;

@end
