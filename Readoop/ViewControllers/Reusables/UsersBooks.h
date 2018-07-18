//
//  UsersBooks.h
//  Readoop
//
//  Created by Marin Chitan on 18/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "User.h"

@interface UsersBooks : ContainerViewController <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) User *currentUser;

@end
