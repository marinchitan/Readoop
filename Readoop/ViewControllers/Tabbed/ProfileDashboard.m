//
//  ProfileDashboard.m
//  Readoop
//
//  Created by Marin Chitan on 16/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ProfileDashboard.h"

@interface ProfileDashboard ()

@end

@implementation ProfileDashboard

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    [Navigation hideNavBar:self.navigationController];
}

/*
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}*/



@end
