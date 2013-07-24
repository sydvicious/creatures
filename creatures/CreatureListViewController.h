//
//  CreatureListViewController.h
//  creatures
//
//  Created by Syd Polk on 6/8/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CreatureViewController;

@interface CreatureListViewController : UITableViewController

@property (strong, nonatomic) CreatureViewController *creatureViewController;

@property (atomic, assign) int untitledCount;

@end
