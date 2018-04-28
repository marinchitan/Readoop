//
//  RequestCellModel.m
//  Readoop
//
//  Created by Marin Chitan on 23/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "RequestCellModel.h"

@implementation RequestCellModel

+ (RequestCellModel*)getModelWithType:(CellType)type withRequest:(Request*)request withReuseId:(NSString*)rid {
    RequestCellModel *model = [RequestCellModel new];
    model.cellType = type;
    model.request = request;
    model.reuseId = rid;
    
    return model;
}

@end
