//
//  DefaultSettingsViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/14/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomTableViewController.h"
#import "WelcomeScreenController.h"
#import "AppDelegate.h"
@implementation SearchViewController


#pragma mark - UIViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
//    if ([PFUser currentUser]) {
//        self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
//    } else {
//        self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
//    }
    self.mysearchfield.clearsOnBeginEditing = YES;
    self.mysearchfield.text = @"";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     [self setTitle:@"Search"];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.38 green:0.82 blue:0.9 alpha:0.8]];

}






#pragma mark - ()

- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
    NSLog(@"Something is to be done here, user is logging off!");
//    [self dismissViewControllerAnimated:YES completion:NULL];
    
//    self.window.rootViewController = [[MyMainViewController alloc] initWithNibName:nil bundle:nil];
    
//    UIApplication *app = [UIApplication sharedApplication];
//    AppDelegate *appd = (AppDelegate* ) app;
//    UINavigationController *nav = (UINavigationController*) appd.window.rootViewController;
//    
//    UIViewController *rootController=(UIViewController *)[nav.viewControllers objectAtIndex:1];
//    [self.view addSubview:rootController.view];
// [self.navigationController pushViewController:rootController animated:YES];
    

    
    
    
    
    
//    DefaultSettingsViewController *newFish = [[DefaultSettingsViewController alloc] init];
//    [self.navigationController pushViewController:newFish animated:YES];
//    [self presentViewController:newFish animated:YES completion:NULL];
//    [self.navigationController popViewControllerAnimated:YES];
}


//Now this is for search!
//- (IBAction)listAllButtonTapAction:(id)sender {
//    
//    if (self.mysearchfield.text!=NULL) {
//        [self searchForThis:self.mysearchfield.text];
//    }
//}

-(IBAction)searchButtonPressed:(id)sender{
    NSLog(@"search button pressed!");
    [self searchForThis:self.mysearchfield.text];

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
}

-(void) searchForThis: (NSString*) text{
    
    if([text  isEqual: @""]){
        UIAlertView * alert =[ [UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hey %@",[[PFUser currentUser] username]] message:@"Please enter something and search" delegate:self cancelButtonTitle:@"I understood!" otherButtonTitles:NULL, nil];
        alert.show;
    return;
    }

    
    
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
//                               NSLog(@"%@ %d",  object[@"Title"], [[object objectForKey:@"Serial"] intValue] );
                
                
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
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    NSLog(@"You entered %@",self.mysearchfield.text);
    
    [self searchForThis:self.mysearchfield.text];

    return YES;
}






@end
