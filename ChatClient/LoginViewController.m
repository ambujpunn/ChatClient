//
//  LoginViewController.m
//  ChatClient
//
//  Created by Ambuj Punn on 9/16/15.
//  Copyright (c) 2015 Ambuj Punn. All rights reserved.
//

#import "LoginViewController.h"
#import "PFUser.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UIView *loginView;

@end

@implementation LoginViewController

- (IBAction)signUp:(id)sender {
    PFUser *user = [PFUser user];
    user.username = [self.userName text];
    user.password = [self.password text];
    
    // other fields can be set just like with PFObject
    //user[@"phone"] = @"415-392-0202";
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
        } else {   NSString *errorString = [error userInfo][@"error"];
            // Show the errorString somewhere and let the user try again.
            //NSLog(@"Sign up failed");
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Come on bro" message:@"Dude sign in correctly, smh" delegate:self cancelButtonTitle:@"Aiight" otherButtonTitles: nil];
            [error show];
            NSLog(@"%@", errorString);
        }
        if (succeeded) {
            NSLog(@"Sign up Successful");
        }
    }];
}

- (IBAction)signIn:(id)sender {
    [PFUser logInWithUsernameInBackground:[self.userName text] password:[self.password text]
        block:^(PFUser *user, NSError *error) {
        if (user) {
            // Do stuff after successful login.
            NSLog(@"Sign in Successful");
            [self performSegueWithIdentifier:@"chatWindow" sender:self];
        } else {
            // The login failed. Check error to see why.
            NSLog(@"Sign in failed");
            NSLog(@"%@", error);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
