//
//  DefaultSettingsViewController.h
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/14/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//
#import "MyLogInViewController.h"
#import "MySignUpViewController.h"
@interface SearchViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *mysearchfield;
@property (nonatomic, strong) IBOutlet UILabel *welcomeLabel;

@property (nonatomic, retain) NSMutableArray *strings;
@property (nonatomic, retain)NSMutableArray *autocompletestrings;
@property (nonatomic, retain) UITableView *autocompleteTableView;

- (IBAction)logOutButtonTapAction:(id)sender;
- (IBAction)listAllButtonTapAction:(id)sender;
-(IBAction)searchButtonPressed:(id)sender;
-(void) searchForThis: (NSString*) text;
@end
