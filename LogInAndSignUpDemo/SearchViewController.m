//
//  DefaultSettingsViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/14/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomTableViewController.h"
#import "WelcomeScreenController.h"
#import "AppDelegate.h"
@implementation SearchViewController
@synthesize autocompletestrings;
@synthesize strings;
@synthesize autocompleteTableView;

#pragma mark - UIViewController

-(void) viewWillAppear:(BOOL)animated{
//    [self.navigationItem setHidesBackButton:NO animated:YES];
    [super viewWillAppear:animated];
    
}
-(void) viewDidLoad{
    
//    [self.navigationItem setHidesBackButton:NO animated:YES];
//    if ([PFUser currentUser]) {
//        self.welcomeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Welcome %@!", nil), [[PFUser currentUser] username]];
//    } else {
//        self.welcomeLabel.text = NSLocalizedString(@"Not logged in", nil);
//    }
    
    self.mysearchfield.clearsOnBeginEditing = YES;
    self.mysearchfield.text = @"";
    [self setTitle:@"Search"];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.38 green:0.82 blue:0.9 alpha:0.8]];
    
    
    
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query whereKeyExists:@"Serial"];
    if(strings.count == 0)
    {
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            strings = [[NSMutableArray alloc] init];
            // The find succeeded.
            //            NSLog(@"Successfully retrieved %d books.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                [strings addObject:object[@"Title"] ];
                [strings addObject:object[@"Author"] ];
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    }

    


    autocompletestrings = [[NSMutableArray alloc] init];
    
    autocompleteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 176, 320, 300) style:UITableViewStylePlain];
    [autocompleteTableView setBackgroundColor:[UIColor clearColor]];
    autocompleteTableView.delegate = self;
    autocompleteTableView.dataSource = self;
    autocompleteTableView.scrollEnabled = YES;
    autocompleteTableView.hidden = YES;
    [self.view addSubview:autocompleteTableView];
    [super viewDidLoad];

}








#pragma mark - ()

- (IBAction)logOutButtonTapAction:(id)sender {
    [PFUser logOut];
    NSLog(@"Something is to be done here, user is logging off!");
//    [self dismissViewControllerAnimated:YES completion:NULL];
    
//    self.window.rootViewController = [[MyMainViewController alloc] initWithNibName:nil bundle:nil];
    
//    UIApplication *app = [UIApplication sharedApplication];
//    AppDelegate *appd = (AppDelegate* ) app;
//    UINavigationController *nav = (UINavigationController*) appd.window.rootViewController;
//    
//    UIViewController *rootController=(UIViewController *)[nav.viewControllers objectAtIndex:1];
//    [self.view addSubview:rootController.view];
// [self.navigationController pushViewController:rootController animated:YES];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    
    
    
//    DefaultSettingsViewController *newFish = [[DefaultSettingsViewController alloc] init];
//    [self.navigationController pushViewController:newFish animated:YES];
//    [self presentViewController:newFish animated:YES completion:NULL];
//    [self.navigationController popViewControllerAnimated:YES];
}


//Now this is for search!
//- (IBAction)listAllButtonTapAction:(id)sender {
//    
//    if (self.mysearchfield.text!=NULL) {
//        [self searchForThis:self.mysearchfield.text];
//    }
//}

-(IBAction)searchButtonPressed:(id)sender{
    NSLog(@"search button pressed!");
    [self searchForThis:self.mysearchfield.text];

}

- (IBAction)listAllButtonTapAction:(id)sender {
    NSLog(@"The user needs a list of all books!");
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query whereKeyExists:@"Title"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        CustomTableViewController *mycustomview = [[CustomTableViewController alloc] init];
        [self.view addSubview:mycustomview.view];
        [self.navigationController pushViewController:mycustomview animated:YES];
        [self setTitle:@"BooksApp!"];
        mycustomview.dataitems = objects;
        [self.mysearchfield resignFirstResponder];

        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d books.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                //                NSLog(@"%@ %@ %@", object.objectId, object[@"Title"], object[@"ShortDesc"]);
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:object[@"Title"]
                //                                                                message:object[@"ShortDesc"]
                //                                                               delegate:self
                //                                                      cancelButtonTitle:@"OK"
                //                                                      otherButtonTitles:nil];
                //                [alert show];
                //
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
}

-(void) searchForThis: (NSString*) text{
    
    if([text  isEqual: @""]){
        UIAlertView * alert =[ [UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Hey %@",[[PFUser currentUser] username]] message:@"Please enter something and search" delegate:self cancelButtonTitle:@"I understood!" otherButtonTitles:NULL, nil];
        alert.show;
    return;
    }


    
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query whereKey:@"Title" equalTo:self.mysearchfield.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        PFQuery *query2 = [PFQuery queryWithClassName:@"Book"];
        [query2 whereKey:@"Author" equalTo:self.mysearchfield.text];
        NSMutableArray *items = [query2 findObjects];
        CustomTableViewController *mycustomview = [[CustomTableViewController alloc] init];
        [self.view addSubview:mycustomview.view];
        [self.navigationController pushViewController:mycustomview animated:YES];
        [self setTitle:@"BooksApp!"];
        [items addObjectsFromArray: objects];
        mycustomview.dataitems = items;
        [self.mysearchfield resignFirstResponder];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    autocompleteTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    NSLog(@"You entered %@",self.mysearchfield.text);
    
    [self searchForThis:self.mysearchfield.text];

    return YES;
}


- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [autocompletestrings removeAllObjects];
    for(NSString *curString in strings) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [autocompletestrings addObject:curString];
        }
    }
    [autocompleteTableView reloadData];
}


#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    if(autocompletestrings.count == 0)
        autocompleteTableView.hidden = YES;
    return autocompletestrings.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier] ;
    }
    
    cell.textLabel.text = [autocompletestrings objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.mysearchfield.text = selectedCell.textLabel.text;
    
//    [self goPressed];
    
}


@end
