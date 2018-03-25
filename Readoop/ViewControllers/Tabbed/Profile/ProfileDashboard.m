//
//  ProfileDashboard.m
//  Readoop
//
//  Created by Marin Chitan on 16/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ProfileDashboard.h"
#import "ProfilePresentationCell.h"

@interface ProfileDashboard ()
@property (nonatomic, strong) Session* appSession;
@end

@implementation ProfileDashboard

- (void)viewDidLoad {
    self.backButtonEnabled = NO;
    [super viewDidLoad];
    self.appSession = [Session sharedSession];
    [self setUpUI];
    //[self.tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:@"profilePresentationCell"];
}

- (void)setUpUI {
    UINib* nib = [UINib nibWithNibName:@"ProfilePresentationCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"profilePresentationCell"];
    
    self.tableView.bounces = NO;
    self.tableView.separatorColor = [UIColor whiteColor];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 180;
    
   // [self.navigationController pushViewController:[ViewController getTestVC] animated:YES];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfilePresentationCell *presentationCell = [tableView dequeueReusableCellWithIdentifier:@"profilePresentationCell"];
    presentationCell.fullNameLabel.text = [NSString stringWithFormat:@"%@",self.appSession.currentUser.fullName];
    
    presentationCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [presentationCell populateWithCurrenUserData];
    return presentationCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}





@end
