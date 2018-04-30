//
//  FeedVC.h
//  Readoop
//
//  Created by Marin Chitan on 29/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface FeedVC : ContainerViewController <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *allPostsTab;
@property (weak, nonatomic) IBOutlet UIButton *friendsPostTab;
@property (weak, nonatomic) IBOutlet UIView *tabsView;
@property (weak, nonatomic) IBOutlet UIView *postFieldView;
@property (weak, nonatomic) IBOutlet UITextView *postField;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
