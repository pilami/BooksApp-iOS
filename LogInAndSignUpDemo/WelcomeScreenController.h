
//  UIViewController+WelcomeScreenController.h
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 10/04/15.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <Parse/PFUser.h>

@interface WelcomeScreenController: UIViewController<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

-(IBAction) signupButtonPressed : (UIButton*) sender;
-(IBAction)loginButtonPressed : (UIButton*) sender;

@end

