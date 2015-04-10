//
//  UIViewController+HomeScreenController.m
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 10/04/15.
//
//

#import "HomeScreenController.h"

@implementation HomeScreenController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.38 green:0.82 blue:0.9 alpha:0.8]];
    [self setTitle:@"Home"];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationController.navigationItem.hidesBackButton = true;
    NSLog(@"Home screen created!");
}

@end
