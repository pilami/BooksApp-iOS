//
//  UIViewController+HomeScreenController.m
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 10/04/15.
//
//

#import "HomeScreenController.h"
#import "SearchViewController.h"
#import "DetailViewController.h"
#import "LeftNavViewController.h"
@implementation HomeScreenController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setTitle:@"Home"];
    [self.navigationItem setHidesBackButton:YES animated:YES];

    self.popularView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120,320 , 100)];
    self.popularView.delegate = self;
    self.popularView.showsVerticalScrollIndicator = NO;
    self.popularView.showsHorizontalScrollIndicator = YES;
    [self.popularView setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.95 alpha:1 ]];
    self.popularView.bounces = YES;
    [self.popularView setCanCancelContentTouches:YES];
    self.popularView.userInteractionEnabled = YES;
    [self.popularView setPagingEnabled:YES];
    [self.popularView setScrollEnabled:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.popularView];
    
    UILabel *poplabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 225, 200, 20)];
    poplabel.text = [NSString stringWithFormat:@"Popular Books"];
    [self.view addSubview:poplabel];
    
    UILabel *loadinglabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 200, 40)];
    loadinglabel.text = @"Loading..";
    loadinglabel.hidden = false;
    [self.popularView addSubview:loadinglabel];
    
    int x = 5, y = 5;
    int imageHeight = (90), imageWidth = (300/3);
    __block int lastx=x;
    int lasty=y;
    __block int contentwidth;
    __block int contentheight;

    
/*** POPULAR BEGIN!***/
    if(self.popularBooks.count == 0)
    {
        NSLog(@"Asking to load again! WTFFFFF!!");
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
        self.loadedImages = true;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
//            NSLog(@"Successfully retrieved %d books.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {


                    [self.popularBooks addObject:object[@"Serial"]  ];
//                NSLog(@"Pop books count: %d", self.popularBooks.count);
                
                PFFile *imageFile = [object objectForKey:@"thumbnail"];
                
                
                UIImage *im =  [UIImage imageWithData:[imageFile getData]];
                UIImageView *imgv = [[UIImageView alloc] initWithImage:im];
                imgv.tag = [object[@"Serial"] intValue];
                [self.popularImages addObject:imgv];

                UIImageView* imview = [[UIImageView alloc] initWithFrame: CGRectMake(lastx, lasty, imageWidth, imageHeight)];
                [imview setImage:im];
                NSLog(@"Asking to add at %d %d %d %d", lastx, lasty, imageHeight, imageWidth);
                [imview setTag: [object[@"Serial"] intValue] ];
                [imview setBackgroundColor:[UIColor purpleColor]];
                imview.userInteractionEnabled=YES;
                imview.multipleTouchEnabled=YES;
                imview.hidden = false;
                UITapGestureRecognizer *tapRecognizer =
                [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(handleSingleTap:)];
                [tapRecognizer setNumberOfTouchesRequired:1];
                
                [imview addGestureRecognizer:tapRecognizer];
                [self.popularView addSubview:imview];
                
                lastx +=imageWidth;
                
                contentheight=90;
                contentwidth=lastx;
                
            }     
            self.loadedImages = true;
            loadinglabel.hidden = YES;
            [self.popularView setContentSize:CGSizeMake(contentwidth, 100)];
            [self.view addSubview:self.popularView];
    

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
        
    }
    else {
    
    for (UIImageView * imgv in self.popularImages) {
        
        UIImage *im = imgv.image;
        UIImageView* imview = [[UIImageView alloc] initWithFrame: CGRectMake(lastx, lasty, imageWidth, imageHeight)];
        [imview setImage:im];
        NSLog(@"Asking to add at %d %d %d %d", lastx, 5, imageHeight, imageWidth);
        [imview setTag:imgv.tag];
        [imview setBackgroundColor:[UIColor purpleColor]];
        imview.userInteractionEnabled=YES;
        imview.multipleTouchEnabled=YES;
        imview.hidden = false;
        UITapGestureRecognizer *tapRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        
        [imview addGestureRecognizer:tapRecognizer];
        [self.popularView addSubview:imview];
        
        lastx +=imageWidth;
        
        contentheight=320;
        contentwidth=lastx;

    }
    loadinglabel.hidden = YES;
    [self.popularView setContentSize:CGSizeMake(contentwidth, 100)];
    [self.view addSubview:self.popularView];
    }
/*** POPULAR END!***/
    
    
/*** RECOMMENDATIONS BEGIN!***/
    self.recommendedView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 260,320 , 100)];
    self.recommendedView.delegate = self;
    self.recommendedView.showsVerticalScrollIndicator = NO;
    self.recommendedView.showsHorizontalScrollIndicator = YES;
    [self.recommendedView setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.95 alpha:1 ]];
    self.recommendedView.bounces = YES;
    [self.recommendedView setCanCancelContentTouches:YES];
    self.recommendedView.userInteractionEnabled = YES;
    [self.recommendedView setPagingEnabled:YES];
    [self.recommendedView setScrollEnabled:YES];
    [self.view addSubview:self.recommendedView];
    
    UILabel *reclabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 365, 200, 20)];
    reclabel.text = [NSString stringWithFormat:@"Recommended Books"];
    [self.view addSubview:reclabel];
    
    UILabel *rloadinglabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 200, 40)];
    rloadinglabel.text = @"Loading..";
    rloadinglabel.hidden = false;
    [self.recommendedView addSubview:rloadinglabel];
    
    
    int x1 = 5, y1 = 5;
    imageHeight = (90);imageWidth = (300/3);
    __block int lastx1=x1;
    int lasty1=y1;
    __block int contentwidth1;
    __block int contentheight1;
    
    
    if(self.recommendedBooks.count == 0)
    {
        self.recommendedBooks = [[NSMutableOrderedSet alloc] init];
        self.recommendedImages = [[NSMutableOrderedSet alloc] init];
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
        
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject* ob in objects) {
                NSMutableArray * favbooks = [ob objectForKey:@"FavBooks"];
                //get the genre and get top 2 books of that genre
                
                NSMutableOrderedSet *genres = [[NSMutableOrderedSet alloc] init];
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
                            
                            if ([genres containsObject:object[@"Genre"]]) {
                                NSLog(@"Already done!");
                            }
                            else

                            {[genres addObject:object[@"Genre"]];
                            
                            [query2 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                                if (!error) {
                                    // The find succeeded.
                                    //                            NSLog(@"Successfully retrieved %d books.", objects.count);
                                    // Do something with the found objects
                                    for (PFObject *object1 in objects) {
//                                        NSLog(@"Genre:%@ %@" ,object1[@"Genre"], object[@"Title"]);

                                        [self.recommendedBooks addObject:object1[@"Serial"]];
                                    
                                        PFFile *imageFile = [object1 objectForKey:@"thumbnail"];
                                        UIImage *im =  [UIImage imageWithData:[imageFile getData]];
                                        UIImageView *imgv = [[UIImageView alloc] initWithImage:im];
                                        imgv.tag = [object1[@"Serial"] intValue];
                                        [self.recommendedImages addObject:imgv];
                                        NSLog(@"Got reco %d", [object1[@"Serial"] intValue]);
                                        UIImageView* imview = [[UIImageView alloc] initWithFrame: CGRectMake(lastx1, lasty1, imageWidth, imageHeight)];
                                        [imview setImage:im];
                                        NSLog(@"Asking to add at %d %d %d %d", lastx1, lasty1, imageHeight, imageWidth);
                                        [imview setTag: [object1[@"Serial"] intValue] ];
                                        [imview setBackgroundColor:[UIColor purpleColor]];
                                        imview.userInteractionEnabled=YES;
                                        imview.multipleTouchEnabled=YES;
                                        imview.hidden = false;
                                        UITapGestureRecognizer *tapRecognizer =
                                        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleSingleTap:)];
                                        [tapRecognizer setNumberOfTouchesRequired:1];
                                        
                                        [imview addGestureRecognizer:tapRecognizer];
                                        [self.recommendedView addSubview:imview];
                                        
                                        lastx1 +=imageWidth;
                                        
                                        contentheight1=90;
                                        contentwidth1=lastx1;

                                    
                                    
                                    }
                                } else {
                                    // Log details of the failure
                                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                                }
                            }];//Query2
                            }
                            
                            
                            }
                    } else {
                                                // Log details of the failure
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                        }
                    }];//Query3
                    
                    
                    
                }
                NSLog(@"Size of got reco images: %d", self.recommendedImages.count);
                self.loadedImages = true;
                rloadinglabel.hidden = YES;
                [self.recommendedView setContentSize:CGSizeMake(contentwidth1, 100)];
                [self.view addSubview:self.recommendedView];
       
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];//Query1
        
        
        
        
    }
    
    
    else{
        for (UIImageView * imgv in self.recommendedImages) {
            
            UIImage *im = imgv.image;
            UIImageView* imview = [[UIImageView alloc] initWithFrame: CGRectMake(lastx1, lasty1, imageWidth, imageHeight)];
            [imview setImage:im];
            NSLog(@"Asking to add at %d %d %d %d", lastx1, lasty1, imageHeight, imageWidth);
            [imview setTag:imgv.tag];
            [imview setBackgroundColor:[UIColor purpleColor]];
            imview.userInteractionEnabled=YES;
            imview.multipleTouchEnabled=YES;
            imview.hidden = false;
            UITapGestureRecognizer *tapRecognizer =
            [[UITapGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleSingleTap:)];
            [tapRecognizer setNumberOfTouchesRequired:1];
            
            [imview addGestureRecognizer:tapRecognizer];
            [self.recommendedView addSubview:imview];
            
            lastx1 +=imageWidth;
            
            contentheight=90;
            contentwidth1=lastx1;
            
        }
        
        rloadinglabel.hidden = YES;
        [self.recommendedView setContentSize:CGSizeMake(contentwidth1, 100)];
        [self.view addSubview:self.recommendedView];
    }
    
    
    
/*** RECOMMENDATIONS END!***/
    
    
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
    {
        
      
        
        
        
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
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    UIImageView *currentimage = (UIImageView *)[recognizer view];
    NSLog(@"%d",currentimage.tag);
    
    DetailViewController *detailView = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailView.serial = currentimage.tag;
    

    
    //    detailView.serial =
    [self.view addSubview:detailView.view];
    [self.navigationController pushViewController:detailView animated:YES];

    
    
    
    
}
@end
