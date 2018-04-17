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
@property (nonatomic, strong) NSMutableArray* dataSource;

@end

@implementation ProfileDashboard

- (void)viewDidLoad {
    self.backButtonEnabled = NO;  //Disable back button for this VC
    [super viewDidLoad];
    self.appSession = [Session sharedSession];
    
    self.dataSource = [ProfileTVCDataSource getProfileDashboardDataSource];
    
    [self setUpUI];
    NSLog(@"User:%@",self.appSession.currentUser.username);
}

- (void)viewDidAppear:(BOOL)animated {
    [self initialGreeting];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
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
    cellModel.currentNav = self.navigationController;
    cellModel.currentVC = weakSelf;
    cellModel.currentTab = self.tabBarController;
    if(cellModel.cellType == profile_presentationCell) {
        ProfilePresentationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.reuseIdentifier];
        [cell populateWithCurrenUserData];
        cell.currentNavController = self.navigationController;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if(cellModel.cellType == profileCell) {
        ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.reuseIdentifier];
        [cell setupCellWithModel:cellModel];
        
        //Migrated the assigning of actions to cells in the cell class, as the old solution was adding selector
        //multiple times when the cells where reusing, so you have to remove selectors before adding one (not a good approach)
        /*[cell.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [cell.actionButton addTarget:self
                              action:NSSelectorFromString(cellModel.action)
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
