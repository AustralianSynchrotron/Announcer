//
//  ASLSAnnouncement.m
//  AS Announcer
//
//  Created by Robbie Clarken on 4/06/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASLSAnnouncement.h"
#import "ASLSSiteSettings.h"

@implementation ASLSAnnouncement

+ (id)announcementWithName:(NSString *)name andCode:(NSString *)code {
    ASLSAnnouncement *announcement = [[ASLSAnnouncement alloc] init];
    announcement.name = name;
    announcement.code = code;
    return announcement;
}

- (void)makeAnnouncement {
    return;
    NSURL *announceURL = [NSURL URLWithString:@"/announcer/announce" relativeToURL:kASLSAnnouncerSiteURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:announceURL];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat:@"code=%@", self.code] dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        // TODO: Handle errors
        if (error) {
            NSLog(@"Error with request: %@", error);
            return;
        }
        NSDictionary *returnedJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            NSLog(@"Error deserializing JSON: %@", error);
            return;
        }
        NSLog(@"%@", returnedJSON);
    }];
}

@end
