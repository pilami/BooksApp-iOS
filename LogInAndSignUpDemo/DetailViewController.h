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

@property NSInteger row ;
@property NSString *title;
@end
