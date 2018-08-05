//
//  CellModel.m
//  Readoop
//
//  Created by Marin Chitan on 26/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

+ (CellModel*)getCellModelWithIdentifier:(NSString*)reuseIdentifier withTitle:(NSString*)title withType:(CellType)type withSubType:(CellSubType)subType {
    CellModel *model = [CellModel new];
    model.reuseIdentifier = reuseIdentifier;
    model.title = title;
    model.cellType = type;
    model.cellSubType = subType;
    
    return model;
}

+ (CellModel*)getCellModelWithIdentifier:(NSString*)reuseIdentifier withType:(CellType)type {
    CellModel *model = [CellModel new];
    model.reuseIdentifier = reuseIdentifier;
    model.cellType = type;

    return model;
}

@end
