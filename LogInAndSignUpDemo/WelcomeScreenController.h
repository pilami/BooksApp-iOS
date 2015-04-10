
//  UIViewController+WelcomeScreenController.h
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 10/04/15.
//
//

#import <UIKit/UIKit.h>

@interface WelcomeScreenController: UIViewController<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

-(IBAction) signupButtonPressed : (UIButton*) sender;
-(IBAction)loginButtonPressed : (UIButton*) sender;

@end

