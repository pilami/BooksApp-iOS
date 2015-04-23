//
//  MyLogInViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "MyLogInViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MyLogInViewController ()
@property (nonatomic, strong) UIImageView *fieldsBackground;
@end

@implementation MyLogInViewController

@synthesize fieldsBackground;


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"WTF DUde!!!");
    
    UIFont * customFont = [UIFont fontWithName:@"Noteworthy" size:37]; //custom font
    
    //CGSize labelSize = [text sizeWithFont:customFont constrainedToSize:CGSizeMake(380, 20) lineBreakMode:NSLineBreakByTruncatingTail];
    
    self.logoLabel= [[UILabel alloc]init ]; //WithFrame:CGRectMake(91, 15, labelSize.width, labelSize.height)];
    self.logoLabel.text = [NSString stringWithFormat:@"BookApp!"];
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
    [self.logInView addSubview:self.logoLabel];
    
    
    
    
//[self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"MainBG.png"]]];
    [self.logInView setBackgroundColor:[UIColor colorWithRed:0.38 green:0.82 blue:0.9 alpha:0.8]];
//    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo.png"]]];
    
    // Set buttons appearance
    [self.logInView.dismissButton setImage:[UIImage imageNamed:@"Exit.png"] forState:UIControlStateNormal];
    [self.logInView.dismissButton setImage:[UIImage imageNamed:@"ExitDown.png"] forState:UIControlStateHighlighted];
    
    [self.logInView.facebookButton setImage:nil forState:UIControlStateNormal];
    [self.logInView.facebookButton setImage:nil forState:UIControlStateHighlighted];
    [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"FacebookDown.png"] forState:UIControlStateHighlighted];
    [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"Facebook.png"] forState:UIControlStateNormal];
    [self.logInView.facebookButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.facebookButton setTitle:@"" forState:UIControlStateHighlighted];
    
    [self.logInView.twitterButton setImage:nil forState:UIControlStateNormal];
    [self.logInView.twitterButton setImage:nil forState:UIControlStateHighlighted];
    [self.logInView.twitterButton setBackgroundImage:[UIImage imageNamed:@"Twitter.png"] forState:UIControlStateNormal];
    [self.logInView.twitterButton setBackgroundImage:[UIImage imageNamed:@"TwitterDown.png"] forState:UIControlStateHighlighted];
    [self.logInView.twitterButton setTitle:@"" forState:UIControlStateNormal];
    [self.logInView.twitterButton setTitle:@"" forState:UIControlStateHighlighted];

    // Add login field background
//
//    [self.logInView.usernameField setTextColor:[UIColor blackColor]];
//    [self.logInView.passwordField setTextColor:[UIColor blackColor]];
//    [self.logInView.usernameField setBorderStyle:UITextBorderStyleBezel];
//    [self.logInView.usernameField setBackgroundColor:[UIColor whiteColor]];
//    [self.logInView.passwordField setBackgroundColor:[UIColor whiteColor]];
//    [self.logInView.passwordField setBorderStyle:UITextBorderStyleBezel];
//    
    
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
            [self setTitle:@"Login"];
    // Set frame for elements


    self.logInView.logo.hidden = YES;

    
    [self.logoLabel setFrame:CGRectMake(35.0f, 55.0f, 250.0f, 60.0f)];
    
//    [self.logInView.usernameField setFrame:CGRectMake(35.0f, 125.0f, 250.0f, 30.0f)];
//    [self.logInView.passwordField setFrame:CGRectMake(35.0f, 165.0f, 250.0f, 30.0f)];
    [self.logInView.logInButton setFrame:CGRectMake(35.0f, 205.0f, 250.0f, 30.0f)];


    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
