//
//  WritingCommentCell.m
//  Readoop
//
//  Created by Marin Chitan on 04/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "WritingCommentCell.h"
#import "FeedPostCell.h"
#import "Post.h"
#import "Color.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewUtils.h"
#import "NSString+FontAwesome.h"
#import "Font.h"
#import "Session.h"
#import "RealmUtils.h"
#import "User.h"
#import "WritingComment.h"

@implementation WritingCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.isUpActive = NO;
    self.isDownActive = NO;
    self.postContentLabel.layer.zPosition = 500;
    self.containerView.layer.zPosition = 100;
    self.containerView.layer.cornerRadius = 10;
    self.containerView.clipsToBounds = YES;
    
    self.postContentLabel.backgroundColor = [Color getFeedPostGray];
    self.containerView.backgroundColor = [Color getFeedPostGray];
    self.postContentLabel.textColor = [Color getBlack];
    
    [ViewUtils setUpIconLabel:self.upLabel withSize:25];
    [ViewUtils setUpIconLabel:self.downLabel withSize:25];
    self.upLabel.text = [NSString fontAwesomeIconStringForEnum:FACaretUp];
    self.downLabel.text = [NSString fontAwesomeIconStringForEnum:FACaretDown];
    
    self.averageRatingLabel.font = [Font getBariolwithSize:16];
    self.averageRatingLabel.textColor = [Color getSubTitleGray];
    
    [self refereshRating];
}

- (void)statusCheck {
    Session *session = [Session sharedSession];
    if([[self.currentWritingComment.upRates objectsWhere:@"userId == %@", session.currentUser.userId] firstObject]){
        
        [self activateUpTab];
    } else if([[self.currentWritingComment.downRates objectsWhere:@"userId == %@", session.currentUser.userId] firstObject]){
        [self activateDownTab];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setupCellWithModel:(WritingComment *)writingComment {
    [self deactivateUpTab];
    [self deactivateDownTab];
    self.postContentLabel.text = writingComment.content;
    self.byUserLabel.font = [Font getBariolwithSize:17];
    User *poster = [[User objectsWhere:@"userId == %@",writingComment.userId] firstObject];
    self.byUserLabel.text = [NSString stringWithFormat:@"By %@", poster.username];
    self.datePostedLabel.font = [Font getBariolwithSize:15];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm"];
    
    self.datePostedLabel.text = [NSString stringWithFormat:@"Posted at %@", [dateFormatter stringFromDate:writingComment.datePosted]];
    self.datePostedLabel.textColor = [Color getSubTitleGray];
    
    self.currentWritingComment = writingComment;
    [self statusCheck];
    [self refereshRating];
}

- (IBAction)upTap:(id)sender {
    Session *session = [Session sharedSession];
    [self deactivateDownTab];
    self.isDownActive = NO;
    [RealmUtils removeUserToDowns:session.currentUser forWritingComment:self.currentWritingComment];
    
    if(self.isUpActive){
        [self deactivateUpTab];
        self.isUpActive = NO;
        [RealmUtils removeUserToUps:session.currentUser forWritingComment:self.currentWritingComment];
        [RealmUtils removeStatusPoint:[RealmUtils getUserById:self.currentWritingComment.userId]];
        
    } else {
        [self activateUpTab];
        self.isUpActive = YES;
        [RealmUtils addStatusPoint:[RealmUtils getUserById:self.currentWritingComment.userId]];
        [RealmUtils insertUserToUps:session.currentUser forWritingComment:self.currentWritingComment];
    }
    
    [self refereshRating];
}

- (IBAction)downTap:(id)sender {
    Session *session = [Session sharedSession];
    [self deactivateUpTab];
    self.isUpActive = NO;
    [RealmUtils removeUserToUps:session.currentUser forWritingComment:self.currentWritingComment];
    
    if(self.isDownActive){
        [self deactivateDownTab];
        self.isDownActive = NO;
        [RealmUtils addStatusPoint:[RealmUtils getUserById:self.currentWritingComment.userId]];
        [RealmUtils removeUserToDowns:session.currentUser forWritingComment:self.currentWritingComment];
    } else {
        [self activateDownTab];
        self.isDownActive = YES;
        [RealmUtils removeStatusPoint:[RealmUtils getUserById:self.currentWritingComment.userId]];
        [RealmUtils insertUserToDowns:session.currentUser forWritingComment:self.currentWritingComment];
    }
    
    [self refereshRating];
}

- (void)deactivateUpTab {
    self.upLabel.textColor = [Color getBlack];
    [ViewUtils setUpIconLabel:self.upLabel withSize:28];
}

- (void)activateUpTab {
    self.upLabel.textColor = [Color getValidGreen];
    [ViewUtils setUpIconLabel:self.upLabel withSize:33];}

- (void)deactivateDownTab {
    self.downLabel.textColor = [Color getBlack];
    [ViewUtils setUpIconLabel:self.downLabel withSize:28];
}

- (void)activateDownTab {
    self.downLabel.textColor = [Color getBariolRed];
    [ViewUtils setUpIconLabel:self.downLabel withSize:33];
}

- (void)refereshRating {
    int ups = [self.currentWritingComment.upRates count];
    int downs = [self.currentWritingComment.downRates count];
    int rating = ups - downs;
    self.averageRatingLabel.text = [NSString stringWithFormat:@"Rating: %d", rating];
}


@end
