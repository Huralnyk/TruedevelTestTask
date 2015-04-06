//
//  EventsTVC.m
//  TruedevelTestTask
//
//  Created by Alexey Huralnyk on 4/5/15.
//  Copyright (c) 2015 Alexey Huralnyk. All rights reserved.
//

#import "EventsTVC.h"
#import "GitHubEvent.h"
#import "WebViewController.h"
#import "GitHubEventFetcher.h"

@interface EventsTVC ()

@property (nonatomic, strong) NSMutableArray *avatars;

@end

@implementation EventsTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fetchEvents];
}

- (IBAction)fetchEvents
{
    [self.refreshControl beginRefreshing];
    [GitHubEventFetcher downloadDataFromURL:[GitHubEventFetcher URLforEventsAPI] withCompletionHandler:^(NSData *data) {
        if(data) {
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            for(NSDictionary *eventDictionary in JSON) {
                GitHubEvent *event = [[GitHubEvent alloc] initWithDictionary:eventDictionary];
                [self.events addObject:event];
            }
        } else {
            NSLog(@"Oops! We have no data. Must fix it.");
        }
        
        [self.refreshControl endRefreshing];        
        [self loadAvatars];
        [self.tableView reloadData];
    }];
}

- (void)loadAvatars
{
    for(int i = 0; i < [self.events count]; i++) {
        GitHubEvent *event = [self.events objectAtIndex:i];
        [GitHubEventFetcher downloadDataFromURL:event.avatarURL withCompletionHandler:^(NSData *data) {
            UIImage *avatarImage = [UIImage imageWithData:data];
            [self.avatars addObject:avatarImage];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]]
                                  withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

- (UIImage *)avatarImageForIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row < [self.avatars count] ? self.avatars[indexPath.row] : [UIImage imageNamed:@"blank_avatar"];
}

#pragma mark - Porperties

@synthesize events = _events;

- (void)setEvents:(NSMutableArray *)events
{
    _events = events;
    [self.tableView reloadData];
}

- (NSMutableArray *)events
{
    if(!_events) _events = [[NSMutableArray alloc] init];
    return _events;
}

- (NSMutableArray *)avatars
{
    if(!_avatars) _avatars = [[NSMutableArray alloc] init];
    return _avatars;
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Event Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    GitHubEvent *event = [self.events objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = [[event.actorLogin stringByAppendingString:@" "] stringByAppendingString:event.repoName];
    cell.detailTextLabel.text = [[event.type stringByAppendingString:@" "] stringByAppendingString:event.dateCreated];
    cell.imageView.image = [self avatarImageForIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    static NSString *segueIdentifier = @"Show Event";
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    if([segue.identifier isEqualToString:segueIdentifier]) {
        if([segue.destinationViewController isKindOfClass:[WebViewController class]]) {
            WebViewController *dvc = (WebViewController *)segue.destinationViewController;
            GitHubEvent *event = [self.events objectAtIndex:indexPath.row];
            dvc.repoURL = event.repoURL;
        }
    }
}

@end
