//
//  ASLSAnnouncementsViewController.m
//  AS Announcer
//
//  Created by Robbie Clarken on 4/06/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASLSAnnouncementsViewController.h"
#import "ASLSAnnouncement.h"
#import "ASLSAnnouncementGroup.h"
#import "ASLSAnnouncementCell.h"

static NSString *AnnouncementCellIdentifier = @"AnnouncementCell";

@interface ASLSAnnouncementsViewController () <UIActionSheetDelegate>

@property (strong, nonatomic) NSArray *announcementGroups;
@property (strong, nonatomic) ASLSAnnouncement *selectedAnnouncement;

@end

@implementation ASLSAnnouncementsViewController

- (id)JSONObjectFromResource:(NSString *)resource {
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[ASLSAnnouncementCell class] forCellReuseIdentifier:AnnouncementCellIdentifier];
    
    NSDictionary *codes = [self JSONObjectFromResource:@"announce_codes"];
    NSArray *groupings = [self JSONObjectFromResource:@"groupings"];
    
    NSMutableArray *announcementGroups = [NSMutableArray arrayWithCapacity:[groupings count]];
    for (NSDictionary *sectionSpec in groupings) {
        ASLSAnnouncementGroup *group = [ASLSAnnouncementGroup announcementGroupWithTitle:sectionSpec[@"title"]];
        NSMutableArray *announcements = [NSMutableArray arrayWithCapacity:[sectionSpec[@"announcements"] count]];
        for (NSDictionary *announcementSpec in sectionSpec[@"announcements"]) {
            ASLSAnnouncement *announcement = [ASLSAnnouncement announcementWithName:announcementSpec[@"title"] andCode:codes[announcementSpec[@"code"]]];
            [announcements addObject:announcement];
        }
        group.announcements = announcements;
        [announcementGroups addObject:group];
    }

    self.announcementGroups = announcementGroups;
}

- (ASLSAnnouncementGroup *)announcementGroupForSection:(NSInteger)section {
    return self.announcementGroups[section];
}

- (ASLSAnnouncement *)announcementForIndexPath:(NSIndexPath *)indexPath {
    return [self announcementGroupForSection:indexPath.section].announcements[indexPath.row];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.announcementGroups count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self announcementGroupForSection:section].announcements count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self announcementGroupForSection:section].title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASLSAnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:AnnouncementCellIdentifier forIndexPath:indexPath];
    
    ASLSAnnouncement *announcement = [self announcementForIndexPath:indexPath];
    cell.titleLabel.text = announcement.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedAnnouncement = [self announcementForIndexPath:indexPath];
    
    NSString *message = [NSString stringWithFormat:@"Announce \"%@\"?", self.selectedAnnouncement.name];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:message delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Announce" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.selectedAnnouncement makeAnnouncement];
    }
    self.selectedAnnouncement = nil;
}

@end
