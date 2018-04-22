//
//  UserCell.m
//  Readoop
//
//  Created by Marin Chitan on 20/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "UserCell.h"
#import "Color.h"

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setUpCellWith:(UIImage*)avatar withUsername:(NSString*)uersname withFullName:(NSString*)fullName {
    self.avatar.image = avatar;
    self.usernameLabel.text = uersname;
    self.fullNameLabel.text = [NSString stringWithFormat:@"(%@)", fullName];
    self.fullNameLabel.textColor = [Color getSubTitleGray];
    
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width/2;
    self.avatar.clipsToBounds = YES;
}

@end
