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
    CellModel *presentationModel = [CellModel getCellModelWithIdentifier:@"profilePresentationCell" withType:profile_presentationCell];
    
    CellModel *myBooks = [CellModel getCellModelWithIdentifier:@"profileCell" withTitle:@"My Books" withType:profileCell withSubType:myBooksCell];
    CellModel *myFriends = [CellModel getCellModelWithIdentifier:@"profileCell" withTitle:@"My Friends" withType:profileCell withSubType:myFriendsCell];
    CellModel *requests = [CellModel getCellModelWithIdentifier:@"profileCell" withTitle:@"Requests" withType:profileCell withSubType:requestsCell];
    CellModel *editProfile =[CellModel getCellModelWithIdentifier:@"profileCell" withTitle:@"Edit Profile" withType:profileCell withSubType:editProfileCell];
    CellModel *changePassword = [CellModel getCellModelWithIdentifier:@"profileCell" withTitle:@"Change Password" withType:profileCell withSubType:changePasswordCell];
    CellModel *additionalInfo = [CellModel getCellModelWithIdentifier:@"profileCell" withTitle:@"Additional Info" withType:profileCell withSubType:additionalInfoCell];
    CellModel *signOut = [CellModel getCellModelWithIdentifier:@"profileCell" withTitle:@"Sign Out" withType:profileCell withSubType:signOutCell];

    
    NSMutableArray *dataSource = [NSMutableArray new];
    [dataSource addObject:presentationModel];
    [dataSource addObject:myBooks];
    [dataSource addObject:myFriends];
    [dataSource addObject:requests];
    [dataSource addObject:editProfile];
    [dataSource addObject:changePassword];
    [dataSource addObject:additionalInfo];
    [dataSource addObject:signOut];
    
    return dataSource;
}

@end
