//
//  ChatViewController.h
//  ChatClient
//
//  Created by Ambuj Punn on 9/16/15.
//  Copyright (c) 2015 Ambuj Punn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *submitChat;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (strong, nonatomic) IBOutlet UIView *messagesView;

@property (weak, nonatomic) IBOutlet UITableView *chatTable;
@end
