//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Dmitry Reshetnik on 7/2/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger lastFlipPoints;
@property (nonatomic, readonly) NSIndexSet *indexesOfInsertedCards;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong) NSArray *matchedCards;
@property (nonatomic, strong) NSString *gameName;
@property (nonatomic, strong) NSArray *cardsOnTable;
@property (nonatomic, strong) NSMutableArray *matchesInRemainingCards;
@property (nonatomic) NSUInteger cardsInPlay;
@property (nonatomic) NSUInteger numberOfMatches;
@property (nonatomic) int bonus;
@property (nonatomic) int penalty;
@property (nonatomic) int flipCost;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (void)addCards:(NSUInteger)cardsNumber;
- (Card *)cardAtIndex:(NSUInteger)index;
- (NSIndexSet *)getIndexesForMatchedCards:(NSArray *)cards;
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

@end
