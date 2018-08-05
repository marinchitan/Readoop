//
//  CellModel.h
//  Readoop
//
//  Created by Marin Chitan on 26/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ProfileDashboard.h"

typedef enum typeOfCell{
    profile_presentationCell,
    profileCell
}CellType;

typedef enum subTypeOfcell{
    myBooksCell,
    myFriendsCell,
    requestsCell,
    editProfileCell,
    changePasswordCell,
    additionalInfoCell,
    signOutCell,
}CellSubType;

@interface CellModel : NSObject

@property(nonatomic, strong) NSString *reuseIdentifier;
@property(nonatomic, assign) CellType cellType;
@property(nonatomic, assign) CellSubType cellSubType;
@property(nonatomic, strong) NSString *title;

@property (strong, nonatomic) UINavigationController *currentNav;
@property (strong, nonatomic) ProfileDashboard *currentVC;
@property (strong, nonatomic) UITabBarController *currentTab;


+ (CellModel*)getCellModelWithIdentifier:(NSString*)reuseIdentifier withTitle:(NSString*)title withType:(CellType)type withSubType:(CellSubType)subType;
+ (CellModel*)getCellModelWithIdentifier:(NSString*)reuseIdentifier withType:(CellType)type;
@end


