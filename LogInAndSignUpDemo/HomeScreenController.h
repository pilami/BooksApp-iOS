//
//  UIViewController+HomeScreenController.h
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 10/04/15.
//
//

#import <UIKit/UIKit.h>
#import "HSImageSidebarView.h"
@interface  HomeScreenController: UIViewController<HSImageSidebarViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *leftnavButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property NSMutableOrderedSet * popularBooks;
@property NSMutableOrderedSet *popularImages;
@property NSMutableOrderedSet *recommendedBooks;
@property BOOL loadedImages;
@end
