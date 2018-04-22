//
//  RequestsTVC.m
//  Readoop
//
//  Created by Marin Chitan on 22/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "RequestsTVC.h"
#import "PendingRequest.h"
#import "ReceivedRequest.h"

@interface RequestsTVC ()

@end

@implementation RequestsTVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"PendingRequest" bundle:nil] forCellReuseIdentifier:@"pendingRequestCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReceivedRequest" bundle:nil] forCellReuseIdentifier:@"receivedRequestCell"];
    
    self.tableView.bounces = NO;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PendingRequest *cell = [self.tableView dequeueReusableCellWithIdentifier:@"pendingRequestCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setupCellWithUser:@"testUser1"];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 5;
    } else {
        return 7;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return @"Received requests";
    } else {
        return @"Pending requests";
    }
}


@end
