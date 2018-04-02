//
//  GameSettings.m
//  Matchismo
//
//  Created by Dmitry Reshetnik on 8/22/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import "GameSettings.h"

@implementation GameSettings

#define GAME_SETTINGS_KEY @"Game_Settings_Key"
#define MATCH_BONUS_KEY @"Match_Bonus_Key"
#define MISMATCH_PENALTY_KEY @"Mismatch_Penalty_Key"
#define FLIP_COST_KEY @"Flip_Cost_Key"
#define NUMBER_PLAYING_CARDS_KEY @"Number_Playing_Cards_Key"

- (int)intValueForKey:(NSString *)key withDefault:(int)defaultValue {
    NSDictionary *settings = [[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY];
    
    if (!settings) {
        return defaultValue;
    }
    if (![[settings allKeys] containsObject:key]) {
        return defaultValue;
    }
    return [settings[key] intValue];
}

- (int)bonus {
    return [self intValueForKey:MATCH_BONUS_KEY withDefault:4];
}

- (int)penalty {
    return [self intValueForKey:MISMATCH_PENALTY_KEY withDefault:2];
}

- (int)flipCost {
    return [self intValueForKey:FLIP_COST_KEY withDefault:1];
}

- (void)setIntValue:(int)value forKey:(NSString *)key {
    NSMutableDictionary *settings = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:GAME_SETTINGS_KEY] mutableCopy];
    if (!settings) {
        settings = [[NSMutableDictionary alloc] init];
    }
    settings[key] = @(value);
    [[NSUserDefaults standardUserDefaults] setObject:settings forKey:GAME_SETTINGS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setBonus:(int)bonus {
    [self setIntValue:bonus forKey:MATCH_BONUS_KEY];
}

- (void)setPenalty:(int)penalty {
    [self setIntValue:penalty forKey:MISMATCH_PENALTY_KEY];
}

- (void)setFlipCost:(int)flipCost {
    [self setIntValue:flipCost forKey:FLIP_COST_KEY];
}

@end
