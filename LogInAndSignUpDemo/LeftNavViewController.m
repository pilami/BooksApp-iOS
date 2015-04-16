//
//  UIViewController+LeftNavViewController.m
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 14/04/15.
//
//

#import "LeftNavViewController.h"
#import "SearchViewController.h"
@implementation LeftNavViewController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [.button.layer setBorderWidth:3.0];
//    [self.button.layer setBorderColor:[[UIColor blackColor] CGColor]];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(IBAction)profileButtonPressed:(id)sender{
    NSLog(@"Profile Button Pressed");
}
-(IBAction)favButtonPressed:(id)sender{
    NSLog(@"fav button pressed");
}
-(IBAction)searchButtonPressed:(id)sender{
    SearchViewController* searchViewController = [[SearchViewController alloc] init];
    [self.view addSubview:searchViewController.view];
    [self.navigationController pushViewController:searchViewController animated:YES];
}
-(IBAction)logoutButtonPressed:(id)sender{
    NSLog(@"%@ wants to logout!",[[PFUser currentUser] username]);
    [PFUser logOut];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
//    [self presentLoginViewController];

    
    
    
}

@end
