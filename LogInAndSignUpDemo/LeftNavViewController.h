//
//  UIViewController+LeftNavViewController.h
//  BooksApp
//
//  Created by Sai Chaitanya Manchikatla on 14/04/15.
//
//

#import <UIKit/UIKit.h>

@interface LeftNavViewController: UIViewController
@property (weak, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;

@end
