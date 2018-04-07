//
//  ProfilePresentationCell.h
//  Readoop
//
//  Created by Marin Chitan on 24/03/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfilePresentationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *email;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;

- (void)populateWithCurrenUserData;

- (void)addUserWithName:(NSString*)name withPassword:(NSString*)password;

@end
