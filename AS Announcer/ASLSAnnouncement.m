//
//  ASLSAnnouncement.m
//  AS Announcer
//
//  Created by Robbie Clarken on 4/06/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASLSAnnouncement.h"
#import <zeromq-ios/zmq.h>

@implementation ASLSAnnouncement

+ (id)announcementWithName:(NSString *)name andCode:(NSString *)code {
    ASLSAnnouncement *announcement = [[ASLSAnnouncement alloc] init];
    announcement.name = name;
    announcement.code = code;
    return announcement;
}

- (void)makeAnnouncement {
    NSLog(@"%s %@ %@", __PRETTY_FUNCTION__, self.name, self.code);
    void *context = zmq_ctx_new();
    void *socket = zmq_socket(context, ZMQ_REQ);
    const char serverEndpoint[] = "tcp://10.6.100.199/announcer";
    int connectErr = zmq_connect(socket, serverEndpoint);
    NSLog(@"%i", connectErr);
    if (connectErr == 0) {
        NSStringEncoding encoding = NSUTF8StringEncoding;
        const char *message = [self.code cStringUsingEncoding:encoding];
        NSUInteger messageLength = [self.code lengthOfBytesUsingEncoding:encoding];
        int flags = 0;
        errno = 0;
        int sendErr = zmq_send(socket, message, messageLength, flags);
        if (sendErr != 0) {
            NSLog(@"error: %s", strerror(errno));
        }
    }
    
    zmq_disconnect(socket, serverEndpoint);
}

@end
