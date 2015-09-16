//
//  ChatTableViewCell.h
//  ChatClient
//
//  Created by Ambuj Punn on 9/16/15.
//  Copyright (c) 2015 Ambuj Punn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *messages;
@property (weak, nonatomic) IBOutlet UILabel *user;

@end
