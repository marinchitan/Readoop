//
//  ReceivedRequest.m
//  Readoop
//
//  Created by Marin Chitan on 22/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "ReceivedRequest.h"
#import "RequestCellModel.h"
#import "Essentials.h"
#import "Request.h"

@implementation ReceivedRequest

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellWithModel:(RequestCellModel*)model {
    self.model = model;
    [self setupUI];
    NSString *receivedFrom = @"";
    if(![self.model.request isInvalidated]) {
        User *receivedFromUser = [[User objectsWhere:@"userId == %@",self.model.request.senderId] firstObject];
        receivedFrom = receivedFromUser.username;
    }
   
    
    
    self.receivedFromLabel.font = [Font getBariolwithSize:18];

    NSMutableAttributedString *receivedFromText = [[NSMutableAttributedString alloc]
                                             initWithString:[NSString stringWithFormat:@"Received from %@", receivedFrom]];
                                                                                                                                                    
    [receivedFromText addAttribute:NSForegroundColorAttributeName value:[Color getSubTitleGray] range:NSMakeRange(0, 13)];
    [receivedFromText addAttribute:NSForegroundColorAttributeName value:[Color getBlack] range:NSMakeRange(13, receivedFrom.length)];
                                                                                                                                                       
    self.receivedFromLabel.attributedText = receivedFromText;
    
    [ViewUtils setUpIconLabel:self.acceptLabel withSize:25];
    [ViewUtils setUpIconLabel:self.rejectLabel withSize:25];
    
    self.acceptLabel.textColor = [Color getValidGreen];
    self.acceptLabel.text = [NSString fontAwesomeIconStringForEnum:FACheck];
    self.rejectLabel.textColor = [Color getBariolRed];
    self.rejectLabel.text = [NSString fontAwesomeIconStringForEnum:FATimes];

}

- (void)setupUI {
    [ViewUtils setUpIconLabel:self.icon withSize:24];
    self.icon.text = [NSString fontAwesomeIconStringForEnum:FAuserPlus];
    self.icon.textColor = [Color getPassiveTab];
}
- (IBAction)acceptTap:(id)sender {
    NSLog(@"Accept tap");
    [AlertUtils showSuccess:@"Are you sure you want to accept this friend request?"
                  withTitle:@"Confirmation"
           withActionButton:@"Accept" withCancelButton:@"Cancel"
                 withAction:^{[self acceptRequest];}
                       onVC:self.model.currentVC];
}

- (IBAction)rejectTap:(id)sender {
    NSLog(@"Reject tap");
    [AlertUtils showInformation:@"Are you sure you want to reject this friend request?"
                      withTitle:@"Reject"
               withActionButton:@"Reject"
               withCancelButton:@"Cancel"
                     withAction:^{[self rejectRequest];}
                           onVC:self.model.currentVC];
}

- (void)acceptRequest {
    User *receiver = [RealmUtils getUserById:self.model.request.receiverId];
    User *sender = [RealmUtils getUserById:self.model.request.senderId];
    
    [RealmUtils addUser:receiver toFriendListOfUser:sender];
    [RealmUtils addUser:sender toFriendListOfUser:receiver];
    
    [RealmUtils deleteRequest:self.model.request];
    [self.model.currentVC.tableView reloadData];
}

- (void)rejectRequest {
    [RealmUtils deleteRequest:self.model.request];
    [self.model.currentVC.tableView reloadData];
}

@end
