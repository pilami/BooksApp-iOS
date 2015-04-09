//
//  mynavigationcontroller.h
//  LogInAndSignUpDemo
//
//  Created by Sai Chaitanya Manchikatla on 03/04/15.
//
//

#import <Foundation/Foundation.h>
#import "DetailViewController.h"
@interface CustomTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray* dataitems;

@end
