//
//  UIViewController+HomeScreenController.m
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 10/04/15.
//
//

#import "HomeScreenController.h"
#import "SearchViewController.h"
#import "LeftNavViewController.h"
@implementation HomeScreenController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.38 green:0.82 blue:0.9 alpha:0.8]];
    [self setTitle:@"Home"];
    [self.navigationItem setHidesBackButton:YES animated:YES]; 
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    self.navigationController.navigationItem.hidesBackButton = true;
    NSLog(@"Home screen created!");
    // Make a query and get books with maximum likes..
//    NSDictionary* user =  [[PFUser currentUser] objectForKey:@"FavBooks"];
//    NSLog([NSString stringWithFormat:@"User: %@", [[PFUser currentUser] username]]);
//    NSLog([NSString stringWithFormat:@"Fav Books: %@", [user objectForKey:@"FavBooks"] ]);
    
        
    
    
    
    
    
}

-(IBAction)leftNavPressed  :(id)sender{
    NSLog(@"Left nav button pressed!!");
    
    LeftNavViewController *leftnavController = [[LeftNavViewController alloc] init];
    [self.view addSubview:leftnavController.view];
    [self.navigationController pushViewController:leftnavController animated:YES];
    
}
-(IBAction)searchButtonPressed :(id)sender
{
    NSLog(@"Search Button pressed!!");
    
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    [self.view addSubview:searchViewController.view];
    [self.navigationController pushViewController:searchViewController animated:YES];
    
}


@end
