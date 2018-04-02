//
//  PlayingCard.m
//  Matchismo
//
//  Created by Dmitry Reshetnik on 6/30/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits {
    return @[@"♠️",@"♣️",@"♥️",@"♦️"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    int numMatches = 0;
    
    if ([otherCards count] > 0) {
        for (int i = 0; i < [otherCards count]; i++) {
            id otherCard = otherCards[i];
            
            if ([otherCard isKindOfClass:[PlayingCard class]]) {
                PlayingCard *cardOne = (PlayingCard *)otherCard;
                
                for (int j = i + 1; j < [otherCards count]; j++) {
                    id anotherCard = otherCards[j];
                    
                    if ([anotherCard isKindOfClass:[PlayingCard class]]) {
                        PlayingCard *cardTwo = (PlayingCard *)anotherCard;
                        
                        if ([cardOne.suit isEqualToString:cardTwo.suit]) {
                            score += 1;
                            numMatches++;
                        }
                        
                        if (cardOne.rank == cardTwo.rank) {
                            score += 4;
                            numMatches++;
                        }
                        
                       // NSLog(@"i= %d j= %d cardOne= %@ cardTwo= %@ numMatches= %d", i, j, cardOne, cardTwo, numMatches);
                        
                    }
                }
            }
        }
        if (numMatches < [otherCards count] -1) {
            score = 0;
        }
    }
    return score;
}

@end
