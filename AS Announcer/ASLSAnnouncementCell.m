//
//  ASLSAnnouncementCell.m
//  AS Announcer
//
//  Created by Robbie Clarken on 5/06/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASLSAnnouncementCell.h"

@implementation ASLSAnnouncementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:titleLabel];
        NSDictionary *views = NSDictionaryOfVariableBindings(titleLabel);
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[titleLabel]-|" options:kNilOptions metrics:nil views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]|" options:kNilOptions metrics:nil views:views]];
        
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
        titleLabel.highlightedTextColor = [UIColor whiteColor];
        
        self.titleLabel = titleLabel;
    }
    return self;
}

@end
