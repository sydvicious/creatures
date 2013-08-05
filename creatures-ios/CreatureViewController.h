//
//  CreatureViewController.h
//  creatures
//
//  Created by Syd Polk on 6/8/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Creature.h"

@interface CreatureViewController : UIViewController <UISplitViewControllerDelegate, UITextFieldDelegate, UINavigationBarDelegate>

@property (strong, nonatomic) Creature *creature;

@property (weak, nonatomic) IBOutlet UITextField *characterNameField;
@property (weak, nonatomic) IBOutlet UITextField *playerNameField;
@property (weak, nonatomic) IBOutlet UITextField *campaignNameField;


@end
