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

static NSString *AnnouncementCellIdentifier = @"AnnouncementCell";

@interface ASLSAnnouncementsViewController ()

@property (strong, nonatomic) NSArray *announcements;

@end

@implementation ASLSAnnouncementsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:AnnouncementCellIdentifier];
    
    ASLSAnnouncementGroup *faultGroup = [ASLSAnnouncementGroup announcementGroupWithTitle:@"Fault"];
    faultGroup.announcements = @[
        [ASLSAnnouncement announcementWithName:@"Beam Dump" andCode:@"101"],
        [ASLSAnnouncement announcementWithName:@"Beam Back" andCode:@"102"],
        [ASLSAnnouncement announcementWithName:@"Injection Delayed" andCode:@"103"]
    ];
    ASLSAnnouncementGroup *injectionGroup = [ASLSAnnouncementGroup announcementGroupWithTitle:@"Injection"];
    injectionGroup.announcements =  @[
        [ASLSAnnouncement announcementWithName:@"5 Minutes" andCode:@"201"],
        [ASLSAnnouncement announcementWithName:@"Commencing" andCode:@"202"],
        [ASLSAnnouncement announcementWithName:@"Complete" andCode:@"203"]
    ];
    self.announcements = @[faultGroup, injectionGroup];
    
    /*
     print 'The sound option you selected is not available. Please select from the following:'
     print '======== Misc. ========'
     print '900    Ping'
     print '901    PA_Test_Start.wav'
     print '902    PA_Test_Finish.wav'
     print '903    Mute Volume'
     print '======== Fault ========'
     print '101    Beam_dump.wav'
     print '102    Beam_returned.wav'
     print '103    Injection_delayed.wav'
     print '104    Injection_postponed.wav'
     print '======== Inject ========'
     print '201    5mins_to_injection.wav'
     print '202    Injection_commencing.wav'
     print '203    Injection_complete.wav'
     print '======== Scrape ========'
     print '301    Scraping_About.wav'
     print '302    Scraping_Commencing.wav'
     print '303    Scraping_Complete.wav'
     print 'Others are available, but not yet added.'
    */
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (ASLSAnnouncementGroup *)announcementGroupForSection:(NSInteger)section {
    return self.announcements[section];
}

- (ASLSAnnouncement *)announcementForIndexPath:(NSIndexPath *)indexPath {
    return [self announcementGroupForSection:indexPath.section].announcements[indexPath.row];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.announcements count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self announcementGroupForSection:section].announcements count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self announcementGroupForSection:section].title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AnnouncementCellIdentifier forIndexPath:indexPath];
    
    ASLSAnnouncement *announcement = [self announcementForIndexPath:indexPath];
    cell.textLabel.text = announcement.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ASLSAnnouncement *announcement = [self announcementForIndexPath:indexPath];
    [announcement makeAnnouncement];
    [[self.tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];
}

@end
