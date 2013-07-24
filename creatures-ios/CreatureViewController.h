//
//  CreatureViewController.h
//  creatures
//
//  Created by Syd Polk on 6/8/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Creature.h"

@interface CreatureViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) Creature *creature;

@property (nonatomic, weak) IBOutlet NSString *characterNameField;
@property (nonatomic, weak) IBOutlet NSString *playerNameField;
@property (nonatomic, weak) IBOutlet NSString *campaignNameField;

@end
