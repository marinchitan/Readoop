//
//  PendingRequest.h
//  Readoop
//
//  Created by Marin Chitan on 22/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PendingRequest : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *icon;
@property (weak, nonatomic) IBOutlet UILabel *sentToLabel;
@property (weak, nonatomic) IBOutlet UILabel *pendingLabel;

- (void)setupCellWithUser:(NSString*)user;

@end
