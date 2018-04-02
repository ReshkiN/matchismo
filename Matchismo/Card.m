//
//  Card.m
//  Matchismo
//
//  Created by Dmitry Reshetnik on 6/30/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

- (NSString *)description {
    return  self.contents;
}

@end
