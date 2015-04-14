//
//  UIViewController+DetailViewController_m.h
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 09/04/15.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController: UIViewController

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;

@property NSInteger row ;
@property NSString *title;
@property BOOL isFav;
@property NSInteger serial;
@end
