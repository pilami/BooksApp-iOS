//
//  UITableViewCell+BookViewCell.h
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 10/04/15.
//
//

#import <UIKit/UIKit.h>

@interface BookViewCell:UITableViewCell{
//    IBOutlet UIImageView *titleImage;
//    IBOutlet UILabel *titleLabel;
}
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property NSInteger serial;

@end
