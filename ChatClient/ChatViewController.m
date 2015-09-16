//
//  ChatViewController.m
//  ChatClient
//
//  Created by Ambuj Punn on 9/16/15.
//  Copyright (c) 2015 Ambuj Punn. All rights reserved.
//

#import "ChatViewController.h"
#import "PFObject.h"
#import "PFQuery.h"
#import "ChatTableViewCell.h"
#import "PFUser.h"

@interface ChatViewController ()
@property (nonatomic) NSArray *messages;
@end

@implementation ChatViewController

- (IBAction)submitMessage:(id)sender {
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"text"] = [self.message text];
    message[@"user"] = [PFUser currentUser];
    [message saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"%@", [self.message text]);
        } else {
            // There was a problem, check error.description
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.chatTable.delegate = self;
    self.chatTable.dataSource = self;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector: @selector(onTimer) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTimer {
    // Add code to be run periodically
    PFQuery *query = [PFQuery queryWithClassName:@"Message"];
    //[query whereKey:@"text"];
    [query includeKey:@"user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %ld scores.", objects.count);
            // Do something with the found objects
            self.messages = objects;
            [self.chatTable reloadData];
           /* for (PFObject *object in objects) {
                NSLog(@"%@", object[@"text"]);
            }
            */
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatMessage" forIndexPath:indexPath];
    cell.messages.text = self.messages[indexPath.row][@"text"];
    // default
    cell.user.text = @"No user found";
    NSLog(@"%@", self.messages[indexPath.row]);
    //PFUser *user = self.messages[indexPath.row][@"user"];
    // if user exists, over write
    if (self.messages[indexPath.row][@"user"]) {
        cell.user.text = self.messages[indexPath.row][@"user"][@"username"];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.messages count];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
