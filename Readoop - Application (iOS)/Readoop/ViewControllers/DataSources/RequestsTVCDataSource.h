//
//  RequestsTVCDataSource.h
//  Readoop
//
//  Created by Marin Chitan on 23/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestCellModel.h"

@interface RequestsTVCDataSource : NSObject

@property (nonatomic, assign) NSUInteger numberOfReceivedRequests;
@property (nonatomic, assign) NSUInteger numberOfPendingRequests;

- (NSArray*)getReceivedRequestsDataSource;
- (NSArray*)getPendingRequestsDataSource;
- (NSArray*)getRequestsDataSource;

- (NSUInteger)getNumberOfReceivedRequests;
- (NSUInteger)getNumberOfPendingRequests;

@end


