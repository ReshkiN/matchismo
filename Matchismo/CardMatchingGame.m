//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Dmitry Reshetnik on 7/2/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import "CardMatchingGame.h"
#import "GameSettings.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger lastFlipPoints;
@property (nonatomic, readwrite) NSIndexSet *indexesOfInsertedCards;
@property (nonatomic, strong) GameSettings *gameSetings;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableArray *faceUpCards;
@property (nonatomic, strong) Deck *deck;

@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int FLIP_COST = 1;

- (GameSettings *)gameSetings {
    if (!_gameSetings) {
        _gameSetings = [[GameSettings alloc] init];
    }
    return _gameSetings;
}

- (NSIndexSet *)indexesOfInsertedCards {
    if (!_indexesOfInsertedCards) {
        _indexesOfInsertedCards = [[NSIndexSet alloc] init];
    }
    return _indexesOfInsertedCards;
}

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (int)bonus {
    if (_bonus <= 0) {
        _bonus = MATCH_BONUS;
    }
    return _bonus;
}

- (int)penalty {
    if (_penalty <= 0) {
        _penalty = MISMATCH_PENALTY;
    }
    return _penalty;
}

- (int)flipCost {
    if (_flipCost <= 0) {
        _flipCost = FLIP_COST;
    }
    return _flipCost;
}

- (void)setNumberOfMatches:(NSUInteger)numberOfMatches {
    _numberOfMatches = numberOfMatches >= 2 ? numberOfMatches : 2;
}

- (NSUInteger)cardsInPlay {
    return [self.cards count];
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSArray *)cardsOnTable {
    NSMutableArray *remCards = [[NSMutableArray alloc] init];
    for (Card *card in self.cards) {
        if (!card.isMatched) {
            [remCards addObject:card];
        }
    }
    return [remCards copy];
}

- (NSIndexSet *)getIndexesForMatchedCards:(NSArray *)cards {
    NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
    if (cards) {
        for (Card *cardOne in cards) {
            [indexes addIndex: [self.cards indexOfObject:cardOne]];
        }
        return indexes;
    }
    return nil;
}

- (void)addCards:(NSUInteger)cardsNumber {
    NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
    if (cardsNumber <= [self.deck count]) {
        for (int i = 0; i < cardsNumber; i++) {
            Card *card = [self.deck drawRandomCard];
            [self.cards addObject:card];
            [indexes addIndex:[self.cards indexOfObject:card]];
        }
        self.indexesOfInsertedCards = indexes;
    } else {
        self.indexesOfInsertedCards = nil;
    }
}

- (NSMutableArray *)matchesInRemainingCards {
    NSMutableArray *matches = [[NSMutableArray alloc] init];
    NSMutableArray *checkCards = [[NSMutableArray alloc] init];
    
    if (self.numberOfMatches == 3) {
        NSUInteger numCards = [self.cardsOnTable count];
        
        for (int i = 0; i < numCards; i++) {
            Card *cardOne = self.cardsOnTable[i];
            [checkCards addObject:cardOne];
            
            for (int j = i + 1; j < numCards; j++) {
                Card *cardTwo = self.cardsOnTable[j];
                [checkCards addObject:cardTwo];
                
                for (int k = j + 1; k < numCards; k++) {
                    Card *cardThree = self.cardsOnTable[k];
                    [checkCards addObject:cardThree];
                    int matchScore = [cardThree match:checkCards];
                    
                    if (matchScore > 0) {
                        [matches addObject:[checkCards copy]];
                    }
                    [checkCards removeObject:cardThree];
                }
                [checkCards removeObject:cardTwo];
            }
            [checkCards removeObject:cardOne];
        }
        return matches;
    }
    return nil;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        self.deck = deck;
        self.bonus = self.gameSetings.bonus;
        self.penalty = self.gameSetings.penalty;
        self.flipCost = self.gameSetings.flipCost;
        for (int i = 0; i < count; i++) {
            Card *card = [self.deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            
            self.faceUpCards = [[NSMutableArray alloc] initWithArray:@[card]];
            self.lastFlipPoints = 0;
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [self.faceUpCards insertObject:otherCard atIndex:0];
                    
                    if ([self.faceUpCards count] == self.numberOfMatches) {
                        int matchScore = [card match:self.faceUpCards];
                        if (matchScore) {
                            self.lastFlipPoints += matchScore * self.bonus;
                            for (Card *faceUpCard in self.faceUpCards) {
                                faceUpCard.matched = YES;
                            }
                            
                        } else {
                            self.lastFlipPoints -= self.penalty;
                            for (Card *faceUpCard in self.faceUpCards) {
                                if (faceUpCard != card) {
                                   faceUpCard.chosen = NO;
                                }
                            }
                        }
                        self.matchedCards = [self.faceUpCards copy];
                        break;
                    }
                }
            }
            self.score += self.lastFlipPoints - self.flipCost;
            self.matchedCards = [self.faceUpCards copy];
            card.chosen = YES;
        }
    }
}

@end
