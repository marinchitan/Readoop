//
//  WritingModel.m
//  Readoop
//
//  Created by Marin Chitan on 01/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "WritingModel.h"

@implementation WritingModel

+ (WritingModel*)getWritingModel:(id)object withReuseId:(NSString*)reuseId {
    WritingModel *model = [WritingModel new];
    model.object = object;
    model.reuseIdentifier = reuseId;
    return model;
}

@end
