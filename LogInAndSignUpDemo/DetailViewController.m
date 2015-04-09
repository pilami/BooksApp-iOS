//
//  UIViewController+DetailViewController_m.m
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 09/04/15.
//
//

#import "DetailViewController.h"

@implementation DetailViewController




-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query whereKey:@"Title" equalTo:self.title];
    NSLog([NSString stringWithFormat:@"Got title as :   %@", self.title]);
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d books. and %d row", objects.count, self.row);
            // Do something with the found objects
            
            for (PFObject* ob in objects) {
                PFFile *imageFile = [ob objectForKey:@"thumbnail"];
                NSDictionary *book = ob;
                self.titleLabel.text=book[@"Title"];
                NSLog([NSString stringWithFormat:@"Title is %@  %@ ", book[@"Title"], book]);
                self.descLabel.text=book[@"ShortDesc"];
                //            [self.picView setImageWithURL:[NSURL URLWithString:[teaserImage url]]];
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        UIImage *image = [UIImage imageWithData:data];
                        [self.picView setImage:image];
                    }
                }];

            }
            
                   } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}


-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    NSLog( [NSString stringWithFormat:@"The correct row to crack is %ld ", (long)self.row  ]);
    
//    self.titleView.hidden = false;
//    self.bodyView.hidden = false;
    

}


@end



