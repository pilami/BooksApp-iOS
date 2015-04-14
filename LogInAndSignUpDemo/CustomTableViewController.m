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

#import "CustomTableViewController.h"
#import "MyLogInViewController.h"
#import "BookViewCell.h"

@implementation CustomTableViewController{


}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Results"];
    
//    NSLog(@"The table view loaded !! ");
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
//    NSLog(@"Table cel cout");
    return [self.dataitems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *simpleTableIdentifier = @"BookViewCell";
    
    BookViewCell *cell = (BookViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
//    NSLog(@"table view at index");
  
 
    
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    

 //   NSLog(@"%@ %@ %@", object.objectId, object[@"Title"], object[@"Serial"]);
    NSDictionary *dict = self.dataitems[ indexPath.row];
    PFFile *imageFile = [dict objectForKey:@"thumbnail"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            cell.titleImage.image = image;
            
            [tableView reloadData];
        }
    }];

    
    
    
    
    NSMutableString *str = dict[@"Title"];
//    [str appendString:@" : "];
//    [str appendString: dict[@"ShortDesc"]];
    
    cell.titleLabel.text = str;
    cell.authorLabel.text = str;
    cell.authorLabel.text = dict[@"Author"];
    cell.serial =  [[dict objectForKey:@"Serial"] intValue];
    
//   NSLog([NSString stringWithFormat:@"Set the cell to %@, with number %d", cell.titleLabel.text, cell.serial]);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSInteger row = indexPath.row;
//    NSLog(  [NSMutableString stringWithFormat:@"Selected this %d cell", row]  );
    
    DetailViewController *detailView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailView.row = indexPath.row;

    BookViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = selectedCell.titleLabel.text;
    detailView.title = cellText;
    detailView.serial = selectedCell.serial;
    
//    detailView.serial =
    [self.view addSubview:detailView.view];
    [self.navigationController pushViewController:detailView animated:YES];
    
    
    
    
    
    
    
    
//    MyLogInViewController *detailView = [[MyLogInViewController alloc] init];
//    [self.view addSubview:detailView.view];
//    [self.navigationController pushViewController:detailView animated:YES];
    
    }





@end
