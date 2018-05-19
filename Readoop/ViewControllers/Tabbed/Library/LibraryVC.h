//
//  LibraryVC.h
//  Readoop
//
//  Created by Marin Chitan on 01/05/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface LibraryVC : ContainerViewController <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainTabsView;
@property (weak, nonatomic) IBOutlet UIView *secondaryTabsView;
@property (weak, nonatomic) IBOutlet UIView *searchFieldView;

@property (weak, nonatomic) IBOutlet UIButton *libraryTab;
@property (weak, nonatomic) IBOutlet UIButton *shopTab;

@property (weak, nonatomic) IBOutlet UIButton *firstSecondaryTab;
@property (weak, nonatomic) IBOutlet UIButton *secondSecondaryTab;


@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UILabel *searchExpandLabelFirst;
@property (weak, nonatomic) IBOutlet UILabel *searchExpandLabelSecond;

@property (weak, nonatomic) IBOutlet UILabel *secondaryTabExpandLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondaryTabsViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchViewHeight;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
