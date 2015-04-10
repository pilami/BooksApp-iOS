//
//  UIViewController+WelcomeScreenController.m
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 10/04/15.
//
//

#import "WelcomeScreenController.h"
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"
#import "SearchViewController.h"
@implementation WelcomeScreenController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTitle:@"Register!"];
    if (![PFUser currentUser]) { // No user logged in
    }
    
}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"Yaay@!!!");
    [self setTitle:@"Register"];
    
    if ([PFUser currentUser]) { // No user logged in
        //Directly go to the search view
     
    }
}

-(IBAction)signupButtonPressed:(UIButton *)sender{
    NSLog(@"Signup button pressed!! " );
    
    MySignUpViewController *signupViewController = [[MySignUpViewController alloc] init];
    [signupViewController setDelegate:self];
    signupViewController.fields = PFSignUpFieldsUsernameAndPassword | PFSignUpFieldsEmail | PFSignUpFieldsSignUpButton;
    
    [self.view  addSubview:signupViewController.view];
    [self.navigationController pushViewController:signupViewController animated:YES];
//    [self presentViewController:signupViewController animated:YES completion:NULL];

}

-(IBAction)loginButtonPressed:(UIButton *)sender{
    NSLog(@"Login button pressed!! " );
//    if (![PFUser currentUser]) { // No user logged in
   
        MyLogInViewController *loginViewController = [[MyLogInViewController alloc] init];
        [loginViewController setDelegate:self];
        loginViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton;
//        [self presentViewController:loginViewController animated:YES completion:NULL];
        [self.view addSubview:loginViewController.view];

        [self.navigationController pushViewController:loginViewController animated:YES];
  //  }
    
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
    
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    [self.view addSubview:searchViewController.view];
    [self.navigationController pushViewController:searchViewController animated:NO];
//    [self presentViewController:searchViewController animated:YES completion:NULL];

    
    
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
    
    NSLog(@"Acutally its working!!");
    BOOL informationComplete = YES;
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







@end
