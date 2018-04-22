//
//  PendingRequest.m
//  Readoop
//
//  Created by Marin Chitan on 22/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "PendingRequest.h"
#import "Essentials.h"

@implementation PendingRequest

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupCellWithUser:(NSString*)user {
    [self setupUI];
    
    self.sentToLabel.text = [NSString stringWithFormat:@"Sent to %@",user];
    
}

- (void)setupUI {
    [ViewUtils setUpIconLabel:self.icon withSize:24];
    self.icon.text = [NSString fontAwesomeIconStringForEnum:FAClockO];
}

@end
