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
    
    
    
    
//    [self.signUpView.usernameField setTextColor:[UIColor blackColor]];
//    [self.signUpView.passwordField setTextColor:[UIColor blackColor]];
//    [self.signUpView.emailField setTextColor:[UIColor blackColor]];
//    [self.signUpView.usernameField setBorderStyle:UITextBorderStyleBezel];
//    [self.signUpView.usernameField setBackgroundColor:[UIColor whiteColor]];
//    [self.signUpView.passwordField setBackgroundColor:[UIColor whiteColor]];
//    [self.signUpView.passwordField setBorderStyle:UITextBorderStyleBezel];
//    [self.signUpView.emailField setBackgroundColor:[UIColor whiteColor]];
//    [self.signUpView.emailField setBorderStyle:UITextBorderStyleBezel];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Move all fields down on smaller screen sizes
    float yOffset = [UIScreen mainScreen].bounds.size.height <= 480.0f ? 30.0f : 0.0f;


//    CGRect fieldFrame = self.signUpView.usernameField.frame;

    self.signUpView.logo.hidden = YES;
    

    [self.logoLabel setFrame:CGRectMake(35.0f, 25.0f, 250.0f, 60.0f)];
//    [self.signUpView.emailField setFrame:CGRectMake(35.0f, 95.0f, 250.0f, 30.0f)];
//    [self.signUpView.usernameField setFrame:CGRectMake(35.0f, 135.0f, 250.0f, 30.0f)];
//    [self.signUpView.passwordField setFrame:CGRectMake(35.0f, 175.0f, 250.0f, 30.0f)];
    [self.signUpView.signUpButton setFrame:CGRectMake(35.0f, 215.0f, 250.0f, 30.0f)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
