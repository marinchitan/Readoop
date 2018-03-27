//
//  ProfileDashboard.m
//  Readoop
//
//  Created by Marin Chitan on 16/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ProfileDashboard.h"
#import "ProfilePresentationCell.h"
#import "ProfileCell.h"
#import "ProfileTVCDataSource.h"
#import "CellModel.h"

@interface ProfileDashboard ()
@property (nonatomic, strong) Session* appSession;
@property (nonatomic, strong) NSMutableArray* dataSource;
@property (nonatomic, strong) NSArray* profileCellsTitles;
@property (nonatomic, strong) NSArray* profileCellSelectors;
@end

@implementation ProfileDashboard

- (void)viewDidLoad {
    self.backButtonEnabled = NO;
    [super viewDidLoad];
    self.appSession = [Session sharedSession];
    
    self.dataSource = [ProfileTVCDataSource getProfileDashboardDataSource];
    self.profileCellsTitles = [ProfileTVCDataSource getProfileCellsTitles];
    self.profileCellSelectors = [ProfileTVCDataSource getProfileCellsSelectors];
    
    [self setUpUI];
    //[self.tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:@"profilePresentationCell"];
}

- (void)viewDidAppear:(BOOL)animated {
    [self initialGreeting];
}

- (void)setUpUI {
    UINib* nib = [UINib nibWithNibName:@"ProfilePresentationCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"profilePresentationCell"];
    UINib* nib2 = [UINib nibWithNibName:@"ProfileCell" bundle:nil];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:@"profileCell"];
    
    self.tableView.bounces = NO;
    self.tableView.separatorColor = [UIColor whiteColor];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 180;
    
   // [self.navigationController pushViewController:[ViewController getTestVC] animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    __weak ProfileDashboard *weakSelf = self;
    //Check the implementation with protocol
    CellModel *cellModel = self.dataSource[indexPath.row];
    if(cellModel.cellType == profile_presentation) {
        ProfilePresentationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.reuseIdentifier];
        [cell populateWithCurrenUserData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if(cellModel.cellType == profile) {
        ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.reuseIdentifier];
        [cell setUpCellWithTitle:self.profileCellsTitles[indexPath.row - 1] titleIndex:indexPath.row - 1];
        [cell setActionForCell:self.profileCellSelectors[indexPath.row - 1] onVC:weakSelf];
        /*[cell.actionButton addTarget:self
                              action:NSSelectorFromString(@"editProfile:")
                    forControlEvents:UIControlEventTouchUpInside];*/
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        return [UITableViewCell new];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (IBAction)editProfile:(id)sender {
    NSLog(@"Edit Clicked");
}

- (IBAction)changePassword:(id)sender {
    NSLog(@"Ch Passw Clicked");
}

- (IBAction)additionalInfo:(id)sender {
    NSLog(@"Additional info Clicked");
}

- (IBAction)myFriends:(id)sender {
    NSLog(@"My Friends Clicked");
}

- (IBAction)myBooks:(id)sender {
    NSLog(@"My Books Clicked");
}

- (IBAction)signOut:(id)sender {
    [AlertUtils showInformation:@"Do you want to sign out?"
                      withTitle:@"Sign Out"
               withActionButton:@"Yes"
               withCancelButton:@"No"
                     withAction:^{[self.tabBarController.navigationController popViewControllerAnimated:self.tabBarController];}
                           onVC:self];
}

- (void)initialGreeting {
    if(self.appSession.wayOfArrival == register_path){
        [AlertUtils getSuccesToastPanel:@"Welcome!" withMessage:@"Succcessfully registered."];
        self.appSession.wayOfArrival = others_path;
    } else if(self.appSession.wayOfArrival == login_path){
        [AlertUtils getSuccesToastPanel:@"Success!" withMessage:@"Succcessfully logged in."];
        self.appSession.wayOfArrival = others_path;
    } else if(self.appSession.wayOfArrival == seamless){
        [AlertUtils getSuccesToastPanel:[NSString stringWithFormat:@"Welcome %@!",self.appSession.currentUser.username] withMessage:@"Seamless logged in."];
        self.appSession.wayOfArrival = others_path;
    }
}

@end
