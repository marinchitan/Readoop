//
//  StatusManager.m
//  Readoop
//
//  Created by Marin Chitan on 02/07/2018.
//  Copyright © 2018 Marin Chitan. All rights reserved.
//

#import "StatusManager.h"
#import "RealmUtils.h"
#import "Color.h"

@implementation StatusManager

+ (Status)getStatusForUser:(User *)user {
    int points = [RealmUtils getStatusPointsForUser:user];
    
    if(points < 10) {
        return Beginner;
    } else if(points < 25 && points >= 10) {
        return Amateur;
    } else if(points < 150 && points >= 25) {
        return Experienced;
    } else {
        return Prof;
    }
}

+ (NSString *)getStatusNameForUser:(User *)user {
    int points = [RealmUtils getStatusPointsForUser:user];
    
    if(points < 10) {
        return @"Beginner";
    } else if(points < 25 && points >= 10) {
        return @"Amateur";
    } else if(points < 150 && points >= 25) {
        return @"Experienced";
    } else {
        return @"Professional";
    }
}

+ (UIColor *)getStatusColorForUser:(User *)user {
    int points = [RealmUtils getStatusPointsForUser:user];
    
    if(points < 10) {
        return [Color getBeginnerStatus];
    } else if(points < 25 && points >= 10) {
        return [Color getAmateurStatus];
    } else if(points < 150 && points >= 25) {
        return [Color getExperiencedStatus];
    } else {
        return [Color getProffesionalStatus];
    }
}


@end
