//
//  ASLSAnnouncement.m
//  AS Announcer
//
//  Created by Robbie Clarken on 4/06/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASLSAnnouncement.h"

@implementation ASLSAnnouncement

+ (id)announcementWithName:(NSString *)name andCode:(NSUInteger)code {
    ASLSAnnouncement *announcement = [[ASLSAnnouncement alloc] init];
    announcement.name = name;
    announcement.code = code;
    return announcement;
}

- (void)makeAnnouncement {
    NSLog(@"%s %@ %i", __PRETTY_FUNCTION__, self.name, self.code);
}

@end
