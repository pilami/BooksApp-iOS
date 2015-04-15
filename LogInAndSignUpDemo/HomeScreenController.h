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
@property NSMutableOrderedSet * popularBooks;
@property NSMutableOrderedSet *popularImages;
@property NSMutableOrderedSet *recommendedImages;
@property NSMutableOrderedSet *recommendedBooks;
@property BOOL loadedImages;
@property UIScrollView* popularView;
@property UIScrollView* recommendedView;
@end
