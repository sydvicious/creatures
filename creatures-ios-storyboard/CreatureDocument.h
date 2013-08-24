//
//  CreatureDocument.h
//  creatures
//
//  Created by Syd Polk on 8/8/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Creature.h"

@interface CreatureDocument : UIDocument

@property (nonatomic, strong) Creature *creature;
@end
