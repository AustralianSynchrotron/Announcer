//
//  ASLSAnnouncement.h
//  AS Announcer
//
//  Created by Robbie Clarken on 4/06/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASLSAnnouncement : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *code;

+ (id)announcementWithName:(NSString *)name andCode:(NSString *)code;
- (void)makeAnnouncement;

@end
