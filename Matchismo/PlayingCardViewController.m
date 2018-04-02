//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Dmitry Reshetnik on 8/25/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface PlayingCardViewController ()

@end

@implementation PlayingCardViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)startingCardCount {
    return 20;
}

- (UIView *)cellViewForCard:(Card *)card inRect:(CGRect)rect {
    
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        PlayingCardView *newPlayingCardView = [[PlayingCardView alloc]  initWithFrame:rect];
        newPlayingCardView.opaque = NO;
        newPlayingCardView.rank = playingCard.rank;
        newPlayingCardView.suit = playingCard.suit;
        newPlayingCardView.faceUp = playingCard.isChosen;
        return newPlayingCardView;
    }
    return nil;
}

- (void)updateCell:(UIView *)cell usingCard:(Card *)card animate:(BOOL)animate {
    PlayingCardView *playingCardView = (PlayingCardView *)cell;
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        playingCardView.rank = playingCard.rank;
        playingCardView.suit = playingCard.suit;

        if (playingCardView.faceUp != playingCard.isChosen) {
            if (animate) {
                [UIView transitionWithView:playingCardView
                                  duration:0.5
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                                    playingCardView.faceUp = playingCard.isChosen;
                                }
                                completion:NULL];
            } else {
                playingCardView.faceUp = playingCard.isChosen;
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.maxCardSize = CGSizeMake(80.0, 120.0);
    self.addCardsAfterDelete = NO;
    self.numberOfMatches = 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
