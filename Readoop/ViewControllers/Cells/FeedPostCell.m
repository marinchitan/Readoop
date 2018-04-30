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

@implementation FeedPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellWithModel:(Post*)post {
    Session *appSession = [Session sharedSession];
    self.postContentLabel.text = post.content;
    self.byUserLabel.font = [Font getBariolwithSize:17];
    self.byUserLabel.text = [NSString stringWithFormat:@"By %@", appSession.currentUser.username];
    self.datePostedLabel.font = [Font getBariolwithSize:15];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd-mm-yyyy hh:MM"];
    
    self.datePostedLabel.text = [NSString stringWithFormat:@"Posted at %@", [dateFormatter stringFromDate:post.datePosted]];
    self.datePostedLabel.textColor = [Color getSubTitleGray];
    
    self.currentPost = post;
}
     
- (IBAction)upTap:(id)sender {
    [self deactivateDownTab];
    if(self.isUpActive){
        [self deactivateUpTab];
        self.isUpActive = NO;
    } else {
        [self activateUpTab];
        self.isUpActive = YES;
    }
}

- (IBAction)downTap:(id)sender {
    [self deactivateUpTab];
    if(self.isDownActive){
        [self deactivateDownTab];
        self.isDownActive = NO;
    } else {
        [self activateDownTab];
        self.isDownActive = YES;
    }
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
