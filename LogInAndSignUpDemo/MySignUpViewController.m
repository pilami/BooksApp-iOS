//
//  MySignUpViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "MySignUpViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MySignUpViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation MySignUpViewController

@synthesize fieldsBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIFont * customFont = [UIFont fontWithName:@"Noteworthy" size:37]; //custom font
    
    //CGSize labelSize = [text sizeWithFont:customFont constrainedToSize:CGSizeMake(380, 20) lineBreakMode:NSLineBreakByTruncatingTail];
    
    self.logoLabel= [[UILabel alloc]init ]; //WithFrame:CGRectMake(91, 15, labelSize.width, labelSize.height)];
    self.logoLabel.text = [NSString stringWithFormat:@"Register!"];
    self.logoLabel.font = customFont;
    self.logoLabel.numberOfLines = 1;
    self.logoLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines; // or UIBaselineAdjustmentAlignCenters, or UIBaselineAdjustmentNone
    self.logoLabel.adjustsFontSizeToFitWidth = YES;
    self.logoLabel.adjustsLetterSpacingToFitWidth = YES;
    self.logoLabel.minimumScaleFactor = 10.0f/12.0f;
    self.logoLabel.clipsToBounds = YES;
    self.logoLabel.backgroundColor = [UIColor clearColor];
    self.logoLabel.textColor = [UIColor blackColor];
    self.logoLabel.textAlignment = NSTextAlignmentCenter;
    [self.signUpView addSubview:self.logoLabel];

    
    [self.signUpView setBackgroundColor:[UIColor colorWithRed:0.38 green:0.82 blue:0.9 alpha:0.8]];

//    [self.signUpView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]]];
    [self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]]];
    
    // Change button apperance
    [self.signUpView.dismissButton setImage:[UIImage imageNamed:@"Exit.png"] forState:UIControlStateNormal];
    [self.signUpView.dismissButton setImage:[UIImage imageNamed:@"ExitDown.png"] forState:UIControlStateHighlighted];
    
    
    
    
    [self.signUpView.usernameField setTextColor:[UIColor blackColor]];
    [self.signUpView.passwordField setTextColor:[UIColor blackColor]];
    [self.signUpView.emailField setTextColor:[UIColor blackColor]];
    [self.signUpView.usernameField setBorderStyle:UITextBorderStyleBezel];
    [self.signUpView.usernameField setBackgroundColor:[UIColor whiteColor]];
    [self.signUpView.passwordField setBackgroundColor:[UIColor whiteColor]];
    [self.signUpView.passwordField setBorderStyle:UITextBorderStyleBezel];
    [self.signUpView.emailField setBackgroundColor:[UIColor whiteColor]];
    [self.signUpView.emailField setBorderStyle:UITextBorderStyleBezel];
    
    
    
//    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignUp.png"] forState:UIControlStateNormal];
//    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"SignUpDown.png"] forState:UIControlStateHighlighted];
//    [self.signUpView.signUpButton setTitle:@"" forState:UIControlStateNormal];
//    [self.signUpView.signUpButton setTitle:@"" forState:UIControlStateHighlighted];
    
    // Add background for fields
//    [self setFieldsBackground:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SignUpFieldBG.png"]]];
//    [self.signUpView insertSubview:fieldsBackground atIndex:1];
    
    // Remove text shadow
//    CALayer *layer = self.signUpView.usernameField.layer;
//    layer.shadowOpacity = 0.0f;
//    layer = self.signUpView.passwordField.layer;
//    layer.shadowOpacity = 0.0f;
//    layer = self.signUpView.emailField.layer;
//    layer.shadowOpacity = 0.0f;
//    layer = self.signUpView.additionalField.layer;
//    layer.shadowOpacity = 0.0f;
//    
//    // Set text color
//    [self.signUpView.usernameField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
//    [self.signUpView.passwordField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
//    [self.signUpView.emailField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
//    [self.signUpView.additionalField setTextColor:[UIColor colorWithRed:135.0f/255.0f green:118.0f/255.0f blue:92.0f/255.0f alpha:1.0]];
//    
//    // Change "Additional" to match our use
//    [self.signUpView.additionalField setPlaceholder:@"Phone number"];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Move all fields down on smaller screen sizes
    float yOffset = [UIScreen mainScreen].bounds.size.height <= 480.0f ? 30.0f : 0.0f;

    CGRect fieldFrame = self.signUpView.usernameField.frame;

//    [self.signUpView.dismissButton setFrame:CGRectMake(10.0f, 10.0f, 87.5f, 45.5f)];
  
//    [self.signUpView.logo setFrame:CGRectMake(66.5f, 70.0f, 187.0f, 58.5f)];
    self.signUpView.logo.hidden = YES;
    
//    [self.signUpView.signUpButton setFrame:CGRectMake(35.0f, 385.0f, 250.0f, 40.0f)];
//    [self.fieldsBackground setFrame:CGRectMake(35.0f, fieldFrame.origin.y + yOffset, 250.0f, 174.0f)];
//    
//    [self.signUpView.usernameField setFrame:CGRectMake(fieldFrame.origin.x + 5.0f,
//                                                       fieldFrame.origin.y + yOffset,
//                                                       fieldFrame.size.width - 10.0f,
//                                                       fieldFrame.size.height)];
//    yOffset += fieldFrame.size.height;
//    
//    [self.signUpView.passwordField setFrame:CGRectMake(fieldFrame.origin.x + 5.0f,
//                                                       fieldFrame.origin.y + yOffset,
//                                                       fieldFrame.size.width - 10.0f,
//                                                       fieldFrame.size.height)];
//    yOffset += fieldFrame.size.height;
//    
//    [self.signUpView.emailField setFrame:CGRectMake(fieldFrame.origin.x + 5.0f,
//                                                    fieldFrame.origin.y + yOffset,
//                                                    fieldFrame.size.width - 10.0f,
//                                                    fieldFrame.size.height)];
//    yOffset += fieldFrame.size.height;
//    
//    [self.signUpView.additionalField setFrame:CGRectMake(fieldFrame.origin.x + 5.0f,
//                                                         fieldFrame.origin.y + yOffset,
//                                                         fieldFrame.size.width - 10.0f,
//                                                         fieldFrame.size.height)];
    [self.logoLabel setFrame:CGRectMake(35.0f, 25.0f, 250.0f, 60.0f)];
    [self.signUpView.emailField setFrame:CGRectMake(35.0f, 95.0f, 250.0f, 30.0f)];
    [self.signUpView.usernameField setFrame:CGRectMake(35.0f, 135.0f, 250.0f, 30.0f)];
    [self.signUpView.passwordField setFrame:CGRectMake(35.0f, 175.0f, 250.0f, 30.0f)];
    [self.signUpView.signUpButton setFrame:CGRectMake(35.0f, 215.0f, 250.0f, 30.0f)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
