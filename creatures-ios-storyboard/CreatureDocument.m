//
//  CreatureDocument.m
//  creatures
//
//  Created by Syd Polk on 8/8/13.
//  Copyright (c) 2013 Bone Jarring Games and Software. All rights reserved.
//

#import <Foundation/NSJSONSerialization.h>

#import "CreatureDocument.h"

@implementation CreatureDocument

- (BOOL) loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
    NSData *data = contents;
    
    if ([data length] > 0) {
        NSError *error;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (!dictionary) {
            NSLog(@"%s: Error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
            return NO;
        }
        if (!self.creature) {
            self.creature = [[Creature alloc] initWithCharacterName:@""];
        }
        [self.creature populateFromDictionary:dictionary];
        return YES;
    }
    return NO;
}

- (id) contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError
{
    if (!self.creature) {
        self.creature = [[Creature alloc] initWithCharacterName:@"Unnamed"];
    }
    NSDictionary *dictionary = [self.creature createDictionary];
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    if (!data) {
        NSLog(@"%s: Error: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
    }
    return data;
}

- (void)handleError:(NSError *)error userInteractionPermitted:(BOOL)userInteractionPermitted
{
    NSLog(@"%s: Error saving: %@", __PRETTY_FUNCTION__, [error localizedDescription]);
    [super handleError:error userInteractionPermitted:userInteractionPermitted];
}

@end
