//
//  RequestsTVCDataSource.m
//  Readoop
//
//  Created by Marin Chitan on 23/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "RequestsTVCDataSource.h"
#import "Request.h"
#import "RequestCellModel.h"
#import "Session.h"
#import <Realm/Realm.h>


@implementation RequestsTVCDataSource

- (NSArray*)getReceivedRequestsDataSource {
    Session *session = [Session sharedSession];
    NSMutableArray *models = [NSMutableArray new];
    
    RLMArray *modelss = [[RLMArray alloc] initWithObjectClassName:Request.className];
    RLMResults *requestsResults = [Request allObjects];
    
    RLMArray *receivedRequests = [[RLMArray alloc] initWithObjectClassName:Request.className];
    
    RLMArray *allRequests = [[RLMArray alloc] initWithObjectClassName:Request.className];
    [allRequests addObjects:requestsResults];
    
    for(Request *request in allRequests){
        if(request.receiverId == session.currentUser.userId){
            NSLog(@"Request receiverId:%@", request.receiverId);
            [receivedRequests addObject:request];
        }
    }

    for(Request *request in receivedRequests){
        RequestCellModel *model = [RequestCellModel getModelWithType:received_request withRequest:request withReuseId:@"receivedRequestCell"];
        [models addObject:model];
        [modelss addObject:model];
    }
    
    self.numberOfReceivedRequests = [receivedRequests count];
    
    RequestCellModel *rs = [modelss firstObject];
    return models;
}

- (NSArray*)getPendingRequestsDataSource {
    Session *session = [Session sharedSession];
    NSMutableArray *models = [NSMutableArray new];
    RLMResults *requestsResults = [Request allObjects];
    
    RLMArray *pendingRequests = [[RLMArray alloc] initWithObjectClassName:Request.className];
    
    RLMArray *allRequests = [[RLMArray alloc] initWithObjectClassName:Request.className];
    [allRequests addObjects:requestsResults];
    
    for(Request *request in allRequests){
        if(request.senderId == session.currentUser.userId){
            NSLog(@"Request receiverId:%@", request.receiverId);
            [pendingRequests addObject:request];
        }
    }
    
    for(Request *request in pendingRequests){
        RequestCellModel *model = [RequestCellModel getModelWithType:pending_request withRequest:request withReuseId:@"pendingRequestCell"];
        [models addObject:model];
    }
    
    self.numberOfPendingRequests = [pendingRequests count];
    
    return models;
}


- (NSUInteger)getNumberOfReceivedRequests {
    return self.numberOfReceivedRequests;
}
- (NSUInteger)getNumberOfPendingRequests {
    return self.numberOfPendingRequests;
}

@end
