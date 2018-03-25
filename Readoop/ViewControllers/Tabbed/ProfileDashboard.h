//
//  ProfileDashboard.h
//  Readoop
//
//  Created by Marin Chitan on 16/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Essentials.h"

@interface ProfileDashboard : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backitem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logOutItem;


@end
