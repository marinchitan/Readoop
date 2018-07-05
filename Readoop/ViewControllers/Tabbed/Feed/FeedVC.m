//
//  FeedVC.m
//  Readoop
//
//  Created by Marin Chitan on 29/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "FeedVC.h"
#import "Essentials.h"
#import "FeedTVCDataSource.h"
#import "FeedPostCell.h"

@interface FeedVC ()
@property (nonatomic, assign) BOOL isMyFriendsEnabled;
@property (nonatomic, assign) BOOL isAllPeopleEnabled;
@property (nonatomic, strong) RLMArray *dataSource;
@end

@implementation FeedVC

- (void)viewDidLoad {
    self.backButtonEnabled = NO;
    [super viewDidLoad];
    self.isMyFriendsEnabled = NO;
    
    [self setupUI];
    [self fetchDataSource];
}

- (void)setupUI {
    [ViewUtils setUpButton:self.postButton withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.allPostsTab withRadius:self.initialCornerRadius];
    [ViewUtils setUpButton:self.friendsPostTab withRadius:self.initialCornerRadius];
    self.tabsView.backgroundColor = [Color getBariolRed];
    self.postFieldView.backgroundColor = [Color getBariolRed];
    [self.postButton setTitleColor:[Color getBariolRed] forState:UIControlStateNormal];
    [self.postButton setTitleColor:[Color getBariolRed] forState:UIControlStateFocused];
    self.postField.layer.cornerRadius = self.initialCornerRadius;
    self.postField.clipsToBounds = YES;
    
    [ViewUtils setUpIconLabel:self.showHideLabel withSize:22];
    self.showHideLabel.textColor = [Color getWhite];
    self.showHideLabel.text = [NSString fontAwesomeIconStringForEnum:FAAngleDoubleUp];
    
    [self setUpTabs];
    
    self.tableView.bounces = NO;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
    UINib *nib = [UINib nibWithNibName:@"FeedPostCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"feedPostCell"];
    
    self.postButton.backgroundColor = [Color getFeedPostGray];
    [self.postButton setTitleColor:[Color getBlack] forState:UIControlStateNormal];
    [self.postButton setTitleColor:[Color getBlack] forState:UIControlStateFocused];
    
    self.postField.autocorrectionType = UITextAutocorrectionTypeNo;
}

- (void)fetchDataSource {
    if(self.isMyFriendsEnabled){
        self.dataSource = [FeedTVCDataSource getFriendsFeedPosts];
    } else {
        self.dataSource = [FeedTVCDataSource getAllFeedPosts];
    }
    [self.tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FeedPostCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"feedPostCell"];
    
    [cell setupCellWithModel:self.dataSource[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
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
        [self setupActiveTab:self.friendsPostTab];
        [self setupInActiveTab:self.allPostsTab];
    } else {
        [self setupActiveTab:self.allPostsTab];
        [self setupInActiveTab:self.friendsPostTab];
    }
}

- (IBAction)allPostsTap:(id)sender {
    self.isMyFriendsEnabled = NO;
    self.isAllPeopleEnabled = YES;
    [self setUpTabs];
    [self fetchDataSource];
}

- (IBAction)friendsTap:(id)sender {
    self.isMyFriendsEnabled = YES;
    self.isAllPeopleEnabled = NO;
    [self setUpTabs];
    [self fetchDataSource];

}

- (IBAction)postTap:(id)sender {
    if(![self.postField.text isEqualToString:@""]){
        [RealmUtils createFeedPostByUser:self.appSession.currentUser withContent:self.postField.text];
        [self fetchDataSource];
        [self.tableView reloadData];
        self.postField.text = @"";
    } else {
        [AlertUtils getInfoToastPanel:@"Empty post!" withMessage:@"Your input is empty."];
    }
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No posts found";
    
    NSDictionary *attributes = @{NSFontAttributeName: [Font getBariolwithSize:30],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"It seems like there are no posts yet.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [Font getBariolwithSize:20],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (IBAction)showHideTap:(id)sender {
    if(self.postFieldHeightConstraint.constant == 100) {
        self.postFieldHeightConstraint.constant = 20;
        self.postFieldRaportConstant.active = NO;
        self.postFieldNullRaportConstant.active = YES;
        self.showHideLabel.text = [NSString fontAwesomeIconStringForEnum:FAAngleDoubleDown];
    } else {
        self.postFieldHeightConstraint.constant = 100;
        self.postFieldRaportConstant.active = YES;
        self.postFieldNullRaportConstant.active = NO;
        self.showHideLabel.text = [NSString fontAwesomeIconStringForEnum:FAAngleDoubleUp];
        
    }
}

@end
