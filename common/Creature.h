//
//  Creature.h
//  creatures
//
//  Created by Syd Polk on 7/23/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Creature : NSObject

@property (nonatomic, strong) NSString *characterName;
@property (nonatomic, strong) NSString *playerName;
@property (nonatomic, strong) NSString *campaignName;

- (id) initWithCharacterName:(NSString *) name;
- (id) initWithCharacterName:(NSString *) characterName playerName:(NSString *)playerName campaignName:(NSString *)campaignName;

@end
