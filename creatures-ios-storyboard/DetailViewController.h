//
//  DetailViewController.h
//  creatures-ios-storyboard
//
//  Created by Syd Polk on 8/8/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Creature.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) Creature *creature;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
