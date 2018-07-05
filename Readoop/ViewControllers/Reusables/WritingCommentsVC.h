//
//  WritingCommentsVC.h
//  Readoop
//
//  Created by Marin Chitan on 04/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface WritingCommentsVC : ContainerViewController <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UIView *commentTab;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) Writing *currentWriting;

@end
