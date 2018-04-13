//
//  CellModel.h
//  Readoop
//
//  Created by Marin Chitan on 26/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum typeOfCell{
    profile_presentation,
    profile
}CellType;

@interface CellModel : NSObject

@property(nonatomic, strong) id cell;
@property(nonatomic, strong) NSString *reuseIdentifier;
@property(nonatomic, assign) CellType cellType;

@property(nonatomic, strong) NSString *action;
@property(nonatomic, strong) NSString *title;


+ (CellModel*)getCellModelWithIdentifier:(NSString*)reuseIdentifier withType:(CellType)type;

@end


