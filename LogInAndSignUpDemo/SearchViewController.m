//
//  DefaultSettingsViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/14/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "SearchViewController.h"
#import "customtableview.h"

@implementation SearchViewController


#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([PFUser currentUser]) {
        self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
    } else {
        self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     [self setTitle:@"Search"];
    
}






#pragma mark - ()

- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
    NSLog(@"Something is to be done here, user is logging off!");
    [self dismissViewControllerAnimated:YES completion:NULL];
//    DefaultSettingsViewController *newFish = [[DefaultSettingsViewController alloc] init];
//    [self.navigationController pushViewController:newFish animated:YES];
//    [self presentViewController:newFish animated:YES completion:NULL];
//    [self.navigationController popViewControllerAnimated:YES];
}




- (IBAction)listAllButtonTapAction:(id)sender {
    NSLog(@"The user needs a list of all books!");
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query whereKeyExists:@"Title"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        CustomTableViewController *mycustomview = [[CustomTableViewController alloc] init];
        [self.view addSubview:mycustomview.view];
        [self.navigationController pushViewController:mycustomview animated:YES];
        [self setTitle:@"BooksApp!"];
        mycustomview.dataitems = objects;
        [self.mysearchfield resignFirstResponder];
        
        
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d books.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                //                NSLog(@"%@ %@ %@", object.objectId, object[@"Title"], object[@"ShortDesc"]);
                
                
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:object[@"Title"]
                //                                                                message:object[@"ShortDesc"]
                //                                                               delegate:self
                //                                                      cancelButtonTitle:@"OK"
                //                                                      otherButtonTitles:nil];
                //                [alert show];
                //
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    
    
    
    
    
//    [self dismissViewControllerAnimated:YES completion:NULL];
    // [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",self.mysearchfield.text);

    
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query whereKey:@"Title" equalTo:self.mysearchfield.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        CustomTableViewController *mycustomview = [[CustomTableViewController alloc] init];
        [self.view addSubview:mycustomview.view];
        [self.navigationController pushViewController:mycustomview animated:YES];
        [self setTitle:@"BooksApp!"];
        mycustomview.dataitems = objects;
        [self.mysearchfield resignFirstResponder];

        
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d books.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
//                NSLog(@"%@ %@ %@", object.objectId, object[@"Title"], object[@"ShortDesc"]);

                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:object[@"Title"]
//                                                                message:object[@"ShortDesc"]
//                                                               delegate:self
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil];
//                [alert show];
//                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    

    return YES;
}






@end
