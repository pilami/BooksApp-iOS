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

    
    
    if(self.popularBooks.count == 0)
    {
        self.popularImages = [[NSMutableOrderedSet alloc] init];
        self.popularBooks = [[NSMutableOrderedSet alloc] init];
        NSLog(@"going in ");

    PFQuery *query = [PFQuery queryWithClassName:@"Book"];
    [query whereKeyExists:@"Serial"];
    query.limit = 10;
    [query orderByDescending:@"views"];
    

/*    //Stop
    NSArray* objects = [query findObjects];
    for (PFObject *object in objects) {
        //                NSLog(@"%@" , object[@"Title"]);
        [self.popularBooks addObject:object];
    }
*/
        self.loadedImages = false;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
//            NSLog(@"Successfully retrieved %d books.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
//                NSLog(@"adding : %@" , object[@"Title"]);

                    [self.popularBooks addObject:object[@"Serial"]  ];
//                NSLog(@"Pop books count: %d", self.popularBooks.count);
                
                PFFile *imageFile = [object objectForKey:@"thumbnail"];
                UIImage *im =  [UIImage imageWithData:[imageFile getData]];
                UIImageView *imview = [[UIImageView alloc] initWithImage:im];
                [imview setTag:[object[@"Serial"] intValue]];
                [self.popularImages addObject:imview];
                
            }
            
            self.loadedImages = true;
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    }
    if(self.recommendedBooks.count == 0)
    {
        self.recommendedBooks = [[NSMutableOrderedSet alloc] init];
//    NSLog(@"Giving you recommendations!");
    
    //Recommended
    //Query user, his fav books,
    //for each one, get the top 2 books in his genre
    
    PFQuery *query1 = [PFUser query];
    [query1 whereKey:@"username" equalTo:[[PFUser currentUser] username]     ];
    /*
    objects = [query1 findObjects];
    for (PFObject* ob in objects) {
        NSMutableArray * favbooks = [ob objectForKey:@"FavBooks"];
        //get the genre and get top 2 books of that genre
        for (NSNumber *bo in favbooks) {
            
            PFQuery *query3 = [PFQuery queryWithClassName:@"Book"];
            [query3 whereKey:@"Serial" equalTo:bo ];
            NSArray* objarray = [query3 findObjects];
            
            
            
            for (PFObject *object in objarray) {
                //                            NSLog(@"He likes: %@ " ,  object[@"Genre"]);
                PFQuery *query2 = [PFQuery queryWithClassName:@"Book"];
                [query2 whereKey:@"Genre" equalTo:object[@"Genre"] ];
                query2.limit = 2;
                [query2 orderByDescending:@"views"];
                NSArray* objarray2 = [query2 findObjects];
                for (PFObject *object1 in objarray2) {
                    //                                        NSLog(@"Genre:%@ %@" ,object1[@"Genre"], object[@"Title"]);
                    [self.recommendedBooks addObject:object1];
                }

            }

        }}
        
      */
            
            
            
            
            
            
            
            
            
            
//    
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject* ob in objects) {
                NSMutableArray * favbooks = [ob objectForKey:@"FavBooks"];
                //get the genre and get top 2 books of that genre
                for (NSNumber *bo in favbooks) {

                    PFQuery *query3 = [PFQuery queryWithClassName:@"Book"];
                    [query3 whereKey:@"Serial" equalTo:bo ];
                    [query3 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        // The find succeeded.
                        // Do something with the found objects
                        for (PFObject *object in objects) {
//                            NSLog(@"He likes: %@ " ,  object[@"Genre"]);
                            PFQuery *query2 = [PFQuery queryWithClassName:@"Book"];
                            [query2 whereKey:@"Genre" equalTo:object[@"Genre"] ];
                            query2.limit = 2;
                            [query2 orderByDescending:@"views"];
                            [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                if (!error) {
                                    // The find succeeded.
                                    //                            NSLog(@"Successfully retrieved %d books.", objects.count);
                                    // Do something with the found objects
                                    for (PFObject *object1 in objects) {
//                                        NSLog(@"Genre:%@ %@" ,object1[@"Genre"], object[@"Title"]);

                                            [self.recommendedBooks addObject:object1[@"Serial"]];
                                    }
                                } else {
                                    // Log details of the failure
                                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                                }
                            }];
                            }
                    } else {
                                                // Log details of the failure
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                        }
        }];
                    
                }
       
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    }
    
    NSLog(@"Popular books:");
    for (NSNumber *i in self.popularBooks) {
        NSLog(@"%d",  [i intValue] );
    }
    NSLog(@"Recommended books");
    for (NSNumber *i in self.recommendedBooks) {
        NSLog(@"%d", [i intValue]);
    }
    

    //    [popularView setBackgroundColor:[UIColor blueColor]];

}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    if(self.loadedImages)
    {    HSImageSidebarView *popularView = [[HSImageSidebarView alloc] initWithFrame:CGRectMake(0, 120,320 , 100)];
         popularView.delegate = self;
        [self.view addSubview:popularView];
    }

//    self.navigationController.navigationItem.hidesBackButton = true;
    NSLog(@"Home screen created!");
    // Make a query and get books with maximum likes..
//    NSDictionary* user =  [[PFUser currentUser] objectForKey:@"FavBooks"];
//    NSLog([NSString stringWithFormat:@"User: %@", [[PFUser currentUser] username]]);
//    NSLog([NSString stringWithFormat:@"Fav Books: %@", [user objectForKey:@"FavBooks"] ]);
    
        
    //Popular
    //Query all books and get books with max likes, put them in a scroll, lets say max 10 books
    


    
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

- (NSUInteger)countOfImagesInSidebar:(HSImageSidebarView *)sidebar{
    
    return self.popularBooks.count;
    
}
- (UIImage *)sidebar:(HSImageSidebarView *)sidebar imageForIndex:(NSUInteger)anIndex{
    
    NSLog(@"I think there are %d images with me now! and asking for %d ", self.popularBooks.count, anIndex);
    //popular books!
    if(anIndex < self.popularImages.count )
    {
        for(UIImageView *i in self.popularImages){
            if(i.tag == anIndex){
                return i.image;
            }
        }
    }
   
}

@end
