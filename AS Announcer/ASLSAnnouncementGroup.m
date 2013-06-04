//
//  ASLSAnnouncementGroup.m
//  AS Announcer
//
//  Created by Robbie Clarken on 4/06/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASLSAnnouncementGroup.h"

@implementation ASLSAnnouncementGroup

+ (id)announcementGroupWithTitle:(NSString *)title {
    ASLSAnnouncementGroup *group = [[ASLSAnnouncementGroup alloc] init];
    group.title = title;
    return group;
}

@end
