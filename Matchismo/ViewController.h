//
//  ViewController.h
//  Matchismo
//
//  Created by Dmitry Reshetnik on 6/30/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"
#import "GameSettings.h"

@interface ViewController : UIViewController

@property (nonatomic) NSUInteger numberOfMatches;
@property (nonatomic) BOOL addCardsAfterDelete;
@property (nonatomic) CGSize maxCardSize;

- (Deck *)createDeck;
- (NSUInteger)startingCardCount;
- (UIView *)cellViewForCard:(Card *)card inRect:(CGRect)rect;
- (void)updateCell:(UIView *)cell usingCard:(Card *)card animate:(BOOL)animate;

@end

