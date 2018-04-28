//
//  RequestsTVC.h
//  Readoop
//
//  Created by Marin Chitan on 22/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerViewController.h"

@interface RequestsTVC : ContainerViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)fetchDataSource;

@end
