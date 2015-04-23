//
//  UIViewController+HomeScreenController.h
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 10/04/15.
//
//

#import <UIKit/UIKit.h>

@interface  HomeScreenController: UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *leftnavButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *demoButton;
@property (weak, nonatomic) IBOutlet UIButton *warButton;
@property (weak, nonatomic) IBOutlet UIButton *childrenButton;
@property (weak, nonatomic) IBOutlet UIButton *fictionButton;
@property NSMutableOrderedSet * popularBooks;
@property NSMutableOrderedSet *popularImages;
@property NSMutableOrderedSet *recommendedImages;
@property NSMutableOrderedSet *recommendedBooks;
@property BOOL loadedImages;
@property UIScrollView* popularView;
@property UIScrollView* recommendedView;

-(IBAction)warButtonPressed:(id)sender;
-(IBAction)childrenButtonPressed:(id)sender;
-(IBAction)demoButtonPressed:(id)sender;
-(IBAction)fictionButtonPressed:(id)sender;
-(IBAction)categoryButtonPressed:(id)sender;
@end
