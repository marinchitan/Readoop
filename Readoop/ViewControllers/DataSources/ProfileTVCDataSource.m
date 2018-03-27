//
//  ProfileTVCDataSource.m
//  Readoop
//
//  Created by Marin Chitan on 26/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ProfileTVCDataSource.h"
#import "CellModel.h"
#import "ProfilePresentationCell.h"
#import "ProfileCell.h"

@implementation ProfileTVCDataSource

+ (NSMutableArray *)getProfileDashboardDataSource {
    ProfilePresentationCell *profilePresentationCell = [ProfilePresentationCell new];
    [profilePresentationCell populateWithCurrenUserData];
    CellModel *presentationModel = [CellModel getCellModelWithCell:profilePresentationCell withIdentifier:@"profilePresentationCell" withType:profile_presentation];
    
    ProfileCell *profileCell = [ProfileCell new];
    CellModel *simpleCellModel = [CellModel getCellModelWithCell:profileCell withIdentifier:@"profileCell" withType:profile];
    
    NSMutableArray *dataSource = [NSMutableArray new];
    [dataSource addObject:presentationModel];
    [dataSource addObject:simpleCellModel];
    [dataSource addObject:simpleCellModel];
    [dataSource addObject:simpleCellModel];
    [dataSource addObject:simpleCellModel];
    [dataSource addObject:simpleCellModel];
    [dataSource addObject:simpleCellModel];
    
    return dataSource;
}

+ (NSArray *)getProfileCellsTitles {
    return @[@"Edit profile", @"Change password", @"Additional info", @"My Friends", @"My Books", @"Sign Out"];
}

+ (NSArray *)getProfileCellsSelectors {
    return @[@"editProfile:", @"changePassword:", @"additionalInfo:", @"myFriends:", @"myBooks:", @"signOut:"];
}

@end
