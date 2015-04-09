//
//  mynavigationcontroller.m
//  LogInAndSignUpDemo
//
//  Created by Sai Chaitanya Manchikatla on 03/04/15.
//
//

//
//  MyLogInViewController.m
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2013 Parse. All rights reserved.
//

#import "customtableview.h"
#import "MyLogInViewController.h"


@implementation CustomTableViewController{


}



- (void)viewDidLoad {
    [super viewDidLoad];
        [self setTitle:@"Results"];
    NSLog(@"The table view loaded !! ");
    self.dataitems = [NSMutableArray arrayWithObjects:@"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

    }

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
   }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Table cel cout");
    return [self.dataitems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"table view at index");
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
//     NSLog(@"%@ %@ %@", object.objectId, object[@"Title"], object[@"ShortDesc"]);
    NSDictionary *dict = self.dataitems[ indexPath.row];
    NSMutableString *str = dict[@"Title"];
//    [str appendString:@" : "];
//    [str appendString: dict[@"ShortDesc"]];
    
    cell.textLabel.text = str;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSLog(  [NSMutableString stringWithFormat:@"Selected this %d cell", row]  );
    
    DetailViewController *detailView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailView.row = indexPath.row;

    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.textLabel.text;
    detailView.title = cellText;
    [self.view addSubview:detailView.view];
    [self.navigationController pushViewController:detailView animated:YES];
    
    
    
    
    
    
    
    
//    MyLogInViewController *detailView = [[MyLogInViewController alloc] init];
//    [self.view addSubview:detailView.view];
//    [self.navigationController pushViewController:detailView animated:YES];
    
    }





@end
