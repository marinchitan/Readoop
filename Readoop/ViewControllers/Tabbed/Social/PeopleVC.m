//
//  PeopleVC.m
//  Readoop
//
//  Created by Marin Chitan on 20/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "PeopleVC.h"
#import "Essentials.h"
#import "UserCell.h"
#import "PeopleTVCDataSource.h"


@interface PeopleVC ()

@property (nonatomic, strong) RLMArray *currentDataSource;

@end

@implementation PeopleVC

- (void)viewDidLoad {
    self.backButtonEnabled = NO;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isMyFriendsEnabled = YES; //hardcoded
    [self setupUI];
    [self setDataSource];
    
}

- (void)setupUI {
    self.tableVIew.emptyDataSetSource = self;
    self.tableVIew.emptyDataSetDelegate = self;
    self.buttonsView.backgroundColor = [Color getBariolRed];
    self.searchView.backgroundColor = [Color getBariolRed];
    
    [ViewUtils setUpButton:self.myFriendsButton withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.allPeopleButton withRadius:self.initialCornerRadius];
    [self.tableVIew registerNib:[UINib nibWithNibName:@"UserCell" bundle:nil] forCellReuseIdentifier:@"userCell"];
    
    [self setUpTabs];
    
    self.tableVIew.bounces = NO;
    self.tableVIew.separatorColor = [UIColor whiteColor];
    self.tableVIew.rowHeight = UITableViewAutomaticDimension;
    self.tableVIew.estimatedRowHeight = 80;
}

- (void)setDataSource {
    if(self.isMyFriendsEnabled){
        self.currentDataSource = [PeopleTVCDataSource getFriendsOfUser:self.appSession.currentUser];
    } else {
        self.currentDataSource = [PeopleTVCDataSource getAllUsers];
    }
    [self.tableVIew reloadData];
}

- (IBAction)myFriendsTap:(id)sender {
    self.isMyFriendsEnabled = YES;
    self.isAllPeopleEnabled = NO;
    [self setUpTabs];
    [self setDataSource];
}

- (IBAction)allPeoplTap:(id)sender {
    self.isMyFriendsEnabled = NO;
    self.isAllPeopleEnabled = YES;
    [self setUpTabs];
    [self setDataSource];
}

- (void)setupActiveTab:(UIButton*)button {
    button.backgroundColor = [Color getWhite];
    button.layer.borderWidth = 1.0;
    button.layer.borderColor = [Color getWhite].CGColor;
    [button setTitleColor:[Color getBariolRed] forState:UIControlStateNormal];
    [button setTitleColor:[Color getBariolRed] forState:UIControlStateFocused];
}

- (void)setupInActiveTab:(UIButton*)button {
    button.backgroundColor = [Color getBariolRed];
    button.layer.borderWidth = 1.0;
    button.layer.borderColor = [Color getWhite].CGColor;
    [button setTitleColor:[Color getWhite] forState:UIControlStateNormal];
    [button setTitleColor:[Color getWhite] forState:UIControlStateFocused];
}

- (void)setUpTabs {
    if(self.isMyFriendsEnabled){
        [self setupActiveTab:self.myFriendsButton];
        [self setupInActiveTab:self.allPeopleButton];
    } else {
        [self setupActiveTab:self.allPeopleButton];
        [self setupInActiveTab:self.myFriendsButton];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    User *currentUser = self.currentDataSource[indexPath.row];
    UserCell *cell = [self.tableVIew dequeueReusableCellWithIdentifier:@"userCell"];
    [cell setUpCellWith:[UIImage imageWithData:currentUser.avatar] withUsername:currentUser.username withFullName:currentUser.fullName];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.currentDataSource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Not sure why it is needed to override this method in order to get 100 height in tableView
    //and the height for cell's xib is not enough.
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserPresentationVC *userVC = [ViewController getUserPresentationVC];
    userVC.isOwnProfile = NO;
    userVC.currentUser = self.currentDataSource[indexPath.row];
    [self.navigationController pushViewController:userVC animated:YES];
}

//Empty Data source handle

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No people found ";
    
    NSDictionary *attributes = @{NSFontAttributeName: [Font getBariolwithSize:30],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"It seems like there are no eligible people for your search or selection. Please try again with different parameters.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [Font getBariolwithSize:20],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
