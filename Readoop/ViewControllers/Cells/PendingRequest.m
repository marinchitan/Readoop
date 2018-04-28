//
//  PendingRequest.m
//  Readoop
//
//  Created by Marin Chitan on 22/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "PendingRequest.h"
#import "Essentials.h"
#import "User.h"
#import "Request.h"

@implementation PendingRequest

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupCellWithModel:(RequestCellModel*)model {
    self.model = model;
    [self setupUI];
    User *sentToUser = [[User objectsWhere:@"userId == %@",self.model.request.receiverId] firstObject];
    NSString *sentUsername = sentToUser.username;
    self.sentToLabel.text = [NSString stringWithFormat:@"Sent to %@", sentUsername];
    
    self.sentToLabel.font = [Font getBariolwithSize:18];
    NSMutableAttributedString *sentToText = [[NSMutableAttributedString alloc]
                                             initWithString:[NSString stringWithFormat:@"Sent to %@", sentUsername]];
    [sentToText addAttribute:NSForegroundColorAttributeName value:[Color getSubTitleGray] range:NSMakeRange(0, 8)];
    [sentToText addAttribute:NSForegroundColorAttributeName value:[Color getBlack] range:NSMakeRange(8, sentUsername.length)];
    self.sentToLabel.attributedText = sentToText;
    
    self.pendingLabel.text = @"Waiting...";
    self.pendingLabel.textColor = [Color getSubTitleGray];
    self.pendingLabel.font = [Font getBariolwithSize:18];
}

- (void)setupUI {
    [ViewUtils setUpIconLabel:self.icon withSize:24];
    self.icon.text = [NSString fontAwesomeIconStringForEnum:FAClockO];
    self.icon.textColor = [Color getPassiveTab];
}

@end
