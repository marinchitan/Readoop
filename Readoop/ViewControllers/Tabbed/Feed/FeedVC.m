//
//  FeedVC.m
//  Readoop
//
//  Created by Marin Chitan on 29/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "FeedVC.h"
#import "Essentials.h"

@interface FeedVC ()
@property (nonatomic, assign) BOOL isMyFriendsEnabled;
@property (nonatomic, assign) BOOL isAllPeopleEnabled;
@end

@implementation FeedVC

- (void)viewDidLoad {
    self.backButtonEnabled = NO;
    [super viewDidLoad];
    self.isMyFriendsEnabled = NO;
    
    [self setupUI];
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
    
    [self setUpTabs];
    
    self.tableView.bounces = NO;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
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
    //[self setDataSource];
}

- (IBAction)friendsTap:(id)sender {
    self.isMyFriendsEnabled = YES;
    self.isAllPeopleEnabled = NO;
    [self setUpTabs];
    //[self setDataSource];

}

- (IBAction)postTap:(id)sender {
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

@end
