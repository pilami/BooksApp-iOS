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
    self.isFav = false;
    

    
    PFQuery *query1 = [PFUser query];
    [query1 whereKey:@"username" equalTo:[[PFUser currentUser] username]     ];
    
    
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
//            NSLog(@"Successfully retrieved %d users", objects.count);
            // Do something with the found objects
            
            for (PFObject* ob in objects) {
                
                NSDictionary *book = ob;
//                NSLog([NSString stringWithFormat:@"Fav books are %@", [book objectForKey:@"FavBooks"] ] );
                
                
                NSArray * favbooks = [book objectForKey:@"FavBooks"];
                for (NSNumber* i in favbooks) {
//                    NSLog(i);
                    if([i intValue]== self.serial){
//                        NSLog(@"Found it!!");
                        self.isFav = true;
                        
                    }
                }
            }
            if(self.isFav == true){
//                NSLog(@"Yes a fav");
                UIImage *btnImage = [UIImage imageNamed:@"fav-after.png"];
                [self.favButton setImage:btnImage forState:UIControlStateNormal];
            }
            else if(self.isFav != true) {
//                NSLog(@"Not a fav");
                UIImage *btnImage = [UIImage imageNamed:@"fav-before.png"];
                [self.favButton setImage:btnImage forState:UIControlStateNormal];
            }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    

    
//    NSLog( [NSString stringWithFormat: @"The user %@ selected the book with serial %d",[ [PFUser currentUser] username] , self.serial ]);
    
//    NSLog([NSString stringWithFormat:@"Got title as :   %@", self.title]);    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
//    NSInteger t = 3;
    [query whereKey:@"Serial" equalTo:[NSNumber numberWithInt:self.serial] ];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
//            NSLog(@"Successfully retrieved %d books. and %d row", objects.count, self.row);
            // Do something with the found objects
            
            for (PFObject* ob in objects) {
                
                NSDictionary *book = ob;
                self.titleLabel.text=book[@"Title"];
//                NSLog([NSString stringWithFormat:@"Title is %@  %@ ", book[@"Title"], book]);
                self.descLabel.text=book[@"ShortDesc"];
                NSInteger views =  [[book objectForKey:@"views"] intValue];
//                NSLog(@"The number of views : %d", views );
                views = views+1;
                self.viewsLabel.text = [NSString stringWithFormat:@"%d",  views]; 
                NSNumber *upviews = [NSNumber numberWithInt:views];
                [ob setObject:upviews forKey:@"views"];
                
                
                NSArray *likes = [ob objectForKey:@"likes"];
                NSInteger *likescount = [likes count]  ;
                self.likesLabel.text = [NSString stringWithFormat:@"%d", likescount];
                
                
                
                
                
                [ob saveInBackground];
                
                
                

                
                
                
                
                
                
                
//                self.serial = book[@"Serial"];
                //            [self.picView setImageWithURL:[NSURL URLWithString:[teaserImage url]]];
                PFFile *imageFile = [ob objectForKey:@"thumbnail"];
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
    
//    NSLog( [NSString stringWithFormat:@"The correct row to crack is %ld ", (long)self.row  ]);
    
//    self.titleView.hidden = false;
//    self.bodyView.hidden = false;
    

}

-(IBAction)favButtonPressed:(id)sender{
    NSLog(@"FavButton pressed");
    //get users fav items
    
    if(self.isFav){
        NSLog(@"Remove it  from fav!");
        self.isFav = false;
        UIImage *btnImage = [UIImage imageNamed:@"fav-before.png"];
        [self.favButton setImage:btnImage forState:UIControlStateNormal];

    }
    else{
        NSLog(@"Make it fav");
        self.isFav= true;
        UIImage *btnImage = [UIImage imageNamed:@"fav-after.png"];
        [self.favButton setImage:btnImage forState:UIControlStateNormal];
    }
    
    
    
    PFQuery *query1 = [PFUser query];
    [query1 whereKey:@"username" equalTo:[[PFUser currentUser] username]     ];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            for (PFObject* ob in objects) {
                
                //                NSLog([NSString stringWithFormat:@"Fav books are %@", [book objectForKey:@"FavBooks"] ] );
                
                NSMutableArray * favbooks = [ob objectForKey:@"FavBooks"];
                NSLog(@"Initially");
//                NSLog(@"array: %@", favbooks);
                // add or remove
              
                if(self.isFav == true){
                    [favbooks addObject:[NSNumber numberWithInt:self.serial]];
//                    [likes addObject:[NSString stringWithFormat:@"%@",[[PFUser currentUser] username]]];
//                    if ([likes containsObject:[NSString stringWithFormat:@"%@", [[PFUser currentUser] username ]]] ) {
//                        [likes addObject:[NSString stringWithFormat:@"%@",[[PFUser currentUser] username] ]];
//                    }
                    
                    
                }
                else{
                    [favbooks removeObject:[NSNumber numberWithInt:self.serial]];
//                    [likes removeObject:[NSString stringWithFormat:@"%@",[[PFUser currentUser] username]]];
//                    NSLog(@"Now the fav books was");
//                    NSLog(@"array: %@", favbooks);
                }
                
//                ob[@"FavBooks"] = (NSArray*) favbooks;
                [ob setObject:favbooks forKey:@"FavBooks"];                
//                [ob setObject:likes forKey:@"likes"];
                [ob saveInBackground];
                NSLog(@"Done!!");
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    //    NSInteger t = 3;
    [query whereKey:@"Serial" equalTo:[NSNumber numberWithInt:self.serial] ];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //            NSLog(@"Successfully retrieved %d books. and %d row", objects.count, self.row);
            // Do something with the found objects
            
            for (PFObject* ob in objects) {
                
                NSDictionary *book = ob;
                NSMutableArray *likes = [ob objectForKey:@"Likes"];
                NSLog(@"array: %@",likes);
                if(self.isFav == true){

                    [likes addObject:[NSString stringWithFormat:@"%@",[[PFUser currentUser] username]]];
                    //                    if ([likes containsObject:[NSString stringWithFormat:@"%@", [[PFUser currentUser] username ]]] ) {
                    //                        [likes addObject:[NSString stringWithFormat:@"%@",[[PFUser currentUser] username] ]];
                    //                    }
                    
                    
                    NSInteger *likescount = [likes count]  ;
                    self.likesLabel.text = [NSString stringWithFormat:@"%d", likescount];
                    
                    
                    NSLog(@"Now the likes is");
                    NSLog(@"array: %@", likes);
                }
                else{
                    
                    [likes removeObject:[NSString stringWithFormat:@"%@",[[PFUser currentUser] username]]];
                    NSLog(@"Now the likes are");
                    NSLog(@"array: %@", likes);
                    NSInteger *likescount = [likes count]  ;
                    self.likesLabel.text = [NSString stringWithFormat:@"%d", likescount];
                }
                

                [ob setObject:likes forKey:@"likes"];
                [ob saveInBackground];
                NSLog(@"Done!!");
    
            }
        }
    }];
}

@end



