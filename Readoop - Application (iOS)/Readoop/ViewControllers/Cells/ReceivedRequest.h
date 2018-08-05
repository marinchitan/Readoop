//
//  ReceivedRequest.h
//  Readoop
//
//  Created by Marin Chitan on 22/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestCellModel.h"

@interface ReceivedRequest : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *icon;
@property (weak, nonatomic) IBOutlet UILabel *receivedFromLabel;
@property (weak, nonatomic) IBOutlet UILabel *rejectLabel;
@property (weak, nonatomic) IBOutlet UILabel *acceptLabel;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *RejectButton;

@property (strong, nonatomic) RequestCellModel *model;

- (void)setupCellWithModel:(RequestCellModel*)model;

@end
