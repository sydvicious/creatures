//
//  MasterViewController.h
//  creatures-ios-storyboard
//
//  Created by Syd Polk on 8/8/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>;

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
