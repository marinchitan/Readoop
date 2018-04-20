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

@interface PeopleVC ()

@end

@implementation PeopleVC

- (void)viewDidLoad {
    self.backButtonEnabled = NO;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isMyFriendsEnabled = YES; //hardcoded
    [self setupUI];
    
}

- (void)setupUI {
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

- (IBAction)myFriendsTap:(id)sender {
    self.isMyFriendsEnabled = YES;
    self.isAllPeopleEnabled = NO;
    [self setUpTabs];
}

- (IBAction)allPeoplTap:(id)sender {
    self.isMyFriendsEnabled = NO;
    self.isAllPeopleEnabled = YES;
    [self setUpTabs];
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
    UserCell *cell = [self.tableVIew dequeueReusableCellWithIdentifier:@"userCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Not sure why it is needed to override this method in order to get 100 height in tableView
    //and the height for cell's xib is not enough.
    return 80;
}

@end
