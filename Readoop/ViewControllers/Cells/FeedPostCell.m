//
//  FeedPostCell.m
//  Readoop
//
//  Created by Marin Chitan on 30/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

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

@implementation FeedPostCell

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
    if([[self.currentPost.upRates objectsWhere:@"userId == %@", session.currentUser.userId] firstObject]){
        NSLog(@"Current post id:%@", self.currentPost.postId);
        [self activateUpTab];
    } else if([[self.currentPost.downRates objectsWhere:@"userId == %@", session.currentUser.userId] firstObject]){
        [self activateDownTab];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellWithModel:(Post*)post {
    self.isUpActive = NO;
    self.isDownActive = NO;
    [self deactivateUpTab];
    [self deactivateDownTab];
    self.postContentLabel.text = post.content;
    self.byUserLabel.font = [Font getBariolwithSize:17];
    User *poster = [[User objectsWhere:@"userId == %@",post.userId] firstObject];
    self.byUserLabel.text = [NSString stringWithFormat:@"By %@", poster.username];
    self.datePostedLabel.font = [Font getBariolwithSize:15];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd-mm-yyyy hh:MM"];
    
    self.datePostedLabel.text = [NSString stringWithFormat:@"Posted at %@", [dateFormatter stringFromDate:post.datePosted]];
    self.datePostedLabel.textColor = [Color getSubTitleGray];
    
    self.currentPost = post;
    [self statusCheck];
    [self refereshRating];
}
     
- (IBAction)upTap:(id)sender {
    Session *session = [Session sharedSession];
    [self deactivateDownTab];
    self.isDownActive = NO;
    [RealmUtils removeUserToDowns:session.currentUser forFeedPost:self.currentPost];
    
    if(self.isUpActive){
        [self deactivateUpTab];
        self.isUpActive = NO;
        [RealmUtils removeUserToUps:session.currentUser forFeedPost:self.currentPost];
        
    } else {
        [self activateUpTab];
        self.isUpActive = YES;
        [RealmUtils insertUserToUps:session.currentUser forFeedPost:self.currentPost];
    }
    
    [self refereshRating];
}

- (IBAction)downTap:(id)sender {
    Session *session = [Session sharedSession];
    [self deactivateUpTab];
    self.isUpActive = NO;
    [RealmUtils removeUserToUps:session.currentUser forFeedPost:self.currentPost];
    
    if(self.isDownActive){
        [self deactivateDownTab];
        self.isDownActive = NO;
        [RealmUtils removeUserToDowns:session.currentUser forFeedPost:self.currentPost];
    } else {
        [self activateDownTab];
        self.isDownActive = YES;
        [RealmUtils insertUserToDowns:session.currentUser forFeedPost:self.currentPost];
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
    int ups = [self.currentPost.upRates count];
    int downs = [self.currentPost.downRates count];
    int rating = ups - downs;
    self.averageRatingLabel.text = [NSString stringWithFormat:@"Rating: %d", rating];
}

@end
