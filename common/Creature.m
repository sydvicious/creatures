//
//  Creature.m
//  creatures
//
//  Created by Syd Polk on 7/23/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import "Creature.h"

@implementation Creature

- (id) initWithCharacterName:(NSString *)name
{
    self = [self init];
    if (self) {
        self.characterName = name;
    }
    return self;
}
@end
