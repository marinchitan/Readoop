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
    CellModel *presentationModel = [CellModel getCellModelWithIdentifier:@"profilePresentationCell" withType:profile_presentation];
    CellModel *myBooksCell = [CellModel getCellModelWithIdentifier:@"profileCell" withType:profile];
    myBooksCell.title = @"My Books";
    myBooksCell.action = @"myBooksAction:";
    CellModel *myFriends = [CellModel getCellModelWithIdentifier:@"profileCell" withType:profile];
    myFriends.title = @"My Friends";
    myFriends.action = @"myFriendsActions:";
    CellModel *requests = [CellModel getCellModelWithIdentifier:@"profileCell" withType:profile];
    requests.title = @"Requests";
    requests.action = @"requestsAction:";
    CellModel *editProfile = [CellModel getCellModelWithIdentifier:@"profileCell" withType:profile];
    editProfile.title = @"Edit Profile";
    editProfile.action = @"editProfileAction:";
    CellModel *changePassword = [CellModel getCellModelWithIdentifier:@"profileCell" withType:profile];
    changePassword.title = @"Change Password";
    changePassword.action = @"changePasswordAction:";
    CellModel *additionalInfo = [CellModel getCellModelWithIdentifier:@"profileCell" withType:profile];
    additionalInfo.title = @"Additional Info";
    additionalInfo.action = @"additionalInfoAction:";
    CellModel *signOut = [CellModel getCellModelWithIdentifier:@"profileCell" withType:profile];
    signOut.title = @"Sign Out";
    signOut.action = @"signoutAction:";
    
    
    NSMutableArray *dataSource = [NSMutableArray new];
    [dataSource addObject:presentationModel];
    [dataSource addObject:myBooksCell];
    [dataSource addObject:myFriends];
    [dataSource addObject:requests];
    [dataSource addObject:editProfile];
    [dataSource addObject:changePassword];
    [dataSource addObject:additionalInfo];
    [dataSource addObject:signOut];
    
    return dataSource;
}

+ (NSArray *)getProfileCellsTitles {
    return @[@"My Books", @"My Friends", @"Requests", @"Edit profile", @"Change password", @"Additional info", @"Sign Out"];
}


//try to put method and title on CellModel and make cells for every cell
+ (NSArray *)getProfileCellsSelectors {
    return @[@"signOut:", @"signOut:", @"signOut:", @"editProfile:", @"changePassword:", @"additionalInfo:", @"signOut:"];
}

@end
