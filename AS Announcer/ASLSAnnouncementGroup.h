//
//  ASLSAnnouncementGroup.h
//  AS Announcer
//
//  Created by Robbie Clarken on 4/06/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASLSAnnouncementGroup : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *announcements;

+ (id)announcementGroupWithTitle:(NSString *)title;

@end
