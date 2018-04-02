//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Dmitry Reshetnik on 8/24/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic,strong) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
