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
@property (nonatomic, strong) NSArray* profileCellsTitles;
@property (nonatomic, strong) NSArray* profileCellSelectors;
@end

@implementation ProfileDashboard

- (void)viewDidLoad {
    self.backButtonEnabled = NO;  //Disable back button for this VC
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
    if(cellModel.cellType == profile_presentation) {
        ProfilePresentationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.reuseIdentifier];
        [cell populateWithCurrenUserData];
        cell.currentNavController = self.navigationController;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if(cellModel.cellType == profile) {
        ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellModel.reuseIdentifier];
        cell.title.text = cellModel.title;
        [cell.actionButton addTarget:self
                              action:NSSelectorFromString(cellModel.action)
                    forControlEvents:UIControlEventTouchUpInside];
        
        [cell setUpCellIconIndex:indexPath.row - 1];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        return [UITableViewCell new];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (IBAction)myBooksAction:(id)sender {
    NSLog(@"myBooksAction clicked");
}

- (IBAction)myFriendsActions:(id)sender {
    NSLog(@"myFriendsAction clicked");
}

- (IBAction)requestsAction:(id)sender {
    NSLog(@"requestsAction clicked");
}

- (IBAction)editProfileAction:(id)sender {
    NSLog(@"editProfileAction clicked");
    //EditProfileVC *editProfileVC = [ViewController getEditProfileVC];
    //[self.navigationController pushViewController:editProfileVC animated:YES];
}

- (IBAction)changePasswordAction:(id)sender {
    NSLog(@"changePassword clicked");
    //ChangePasswordVC *chpsswVC = [ViewController getChangePasswVC];
    //[self.navigationController pushViewController:chpsswVC animated:YES];
}

- (IBAction)additionalInfoAction:(id)sender {
    NSLog(@"additionalInfoAction clicked");
    //AdditionalInfoVC *addInfVC = [ViewController getAdditionalInfoVC];
    //[self.navigationController pushViewController:addInfVC animated:YES];
}

- (IBAction)signoutAction:(id)sender {
    NSLog(@"signoutAction clicked");
    [self signOut];
}

- (void)signOut {
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
