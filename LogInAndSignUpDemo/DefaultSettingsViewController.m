//
//  DefaultSettingsViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/14/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "DefaultSettingsViewController.h"
#import "customtableview.h"

@implementation DefaultSettingsViewController


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
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        logInViewController.fields = PFLogInFieldsDefault;
        [logInViewController setSignUpController:signUpViewController]; 
        [self setTitle:@"BooksApp!"];

//        [self.navigationController pushViewController:logInViewController animated:YES];
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
    
}



#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
//        [self.navigationController pushViewController:logInController animated:YES];
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}


#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
            [self.navigationController pushViewController:signUpController animated:YES];
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
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
