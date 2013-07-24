//
//  Creature.m
//  creatures
//
//  Created by Syd Polk on 7/23/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import "Creature.h"

@interface Creature ()
@property (nonatomic, strong) NSString *boneJarringSerial;
@end

@implementation Creature

- (id) initWithCharacterName:(NSString *)name
{
    self = [self init];
    if (self) {
        _characterName = name;
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        NSString *dateString = [formatter stringFromDate:date];
        _boneJarringSerial = [NSString stringWithFormat:@"BoneJarring%@", dateString];
    }
    return self;
}

- (id) initWithCharacterName:(NSString *)characterName playerName:(NSString *)playerName campaignName:(NSString *)campaignName
{
    self = [self initWithCharacterName:characterName];
    if (self) {
        _playerName = playerName;
        _campaignName = campaignName;
    }
    return self;
}
@end
