//
//  RequestCellModel.h
//  Readoop
//
//  Created by Marin Chitan on 23/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "RequestsTVC.h"

typedef enum typeOfCell{
    received_request,
    pending_request
}CellType;

@interface RequestCellModel : NSObject

@property(nonatomic, assign) CellType cellType;
@property(nonatomic, strong) Request *request;
@property(nonatomic, strong) NSString *reuseId;
@property(nonatomic, strong) RequestsTVC *currentVC;

+ (RequestCellModel*)getModelWithType:(CellType)type withRequest:(Request*)request withReuseId:(NSString*)rid;

@end
