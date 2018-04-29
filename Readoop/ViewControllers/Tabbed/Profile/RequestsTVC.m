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
#import "Request.h"
#import "RequestsTVCDataSource.h"
#import "Font.h"

@interface RequestsTVC ()

@property(nonatomic, strong) NSArray *receivedDataSource; //Received source
@property(nonatomic, strong) NSArray *pendingDataSource; //Pending source
@property(nonatomic, assign) NSUInteger numberOfPendingRequests;
@property(nonatomic, assign) NSUInteger numberOfReceivedRequests;

@end

@implementation RequestsTVC

- (void)viewDidLoad {
    self.backButtonEnabled = YES;
    [super viewDidLoad];
    [self fetchDataSource];

    [self setupUI];
}

- (void)fetchDataSource {
    RequestsTVCDataSource *requestsDataSource = [RequestsTVCDataSource new];
    self.receivedDataSource = [requestsDataSource getReceivedRequestsDataSource];
    self.pendingDataSource = [requestsDataSource getPendingRequestsDataSource];
    self.numberOfReceivedRequests = [requestsDataSource getNumberOfReceivedRequests];
    self.numberOfPendingRequests = [requestsDataSource getNumberOfPendingRequests];
}

- (void)setupUI {
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PendingRequest" bundle:nil] forCellReuseIdentifier:@"pendingRequestCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ReceivedRequest" bundle:nil] forCellReuseIdentifier:@"receivedRequestCell"];
    
    self.tableView.bounces = NO;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0){ //Received Section
        RequestCellModel *model = self.receivedDataSource[indexPath.row];
        model.currentVC = self;
        ReceivedRequest *cell = [self.tableView dequeueReusableCellWithIdentifier:model.reuseId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupCellWithModel:model];
        return cell;
    } else { // Pending Section
        RequestCellModel *model = self.pendingDataSource[indexPath.row];
        model.currentVC = self;
        PendingRequest *cell = [self.tableView dequeueReusableCellWithIdentifier:model.reuseId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupCellWithModel:model];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return self.numberOfReceivedRequests;
    } else {
        return self.numberOfPendingRequests;
    }
    //Have to keep received requests and pending requests in 2 different dataSources
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

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No requests";
    
    NSDictionary *attributes = @{NSFontAttributeName: [Font getBariolwithSize:32],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}


@end
