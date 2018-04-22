//
//  UserCell.h
//  Readoop
//
//  Created by Marin Chitan on 20/04/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

- (void)setUpCellWith:(UIImage*)avatar withUsername:(NSString*)uersname withFullName:(NSString*)fullName;

@end
