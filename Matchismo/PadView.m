//
//  PadView.m
//  Matchismo
//
//  Created by Dmitry Reshetnik on 8/25/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import "PadView.h"

@interface PadView () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) NSMutableArray *attachmentsForViews;

@end

@implementation PadView

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        _animator.delegate = self;
    }
    return _animator;
}

- (NSMutableArray *)attachmentsForView {
    if (!_attachmentsForViews) {
        _attachmentsForViews = [[NSMutableArray alloc] init];
    }
    return _attachmentsForViews;
}

- (void)attachCardsViewToPoint:(CGPoint)anchorPoint {
    for (UIView *v in [self subviews]) {
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc]
                                            initWithItem:v attachedToAnchor:anchorPoint];
        [self.attachmentsForViews addObject:attachment];
        [self.animator addBehavior:attachment];
    }
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    CGPoint gesturePoint =[gesture locationInView:self];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self attachCardsViewToPoint:gesturePoint];
        self.pinchedViews =YES;
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        for (UIAttachmentBehavior *attachment in self.attachmentsForViews) {
            attachment.anchorPoint = gesturePoint;
            attachment.length *= gesture.scale;
        }
        gesture.scale = 1.0;
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        for (UIAttachmentBehavior *attachment in self.attachmentsForViews) {
            attachment.anchorPoint = gesturePoint;
            attachment.length *= gesture.scale;
        }
        gesture.scale = 1.0;
        for (UIAttachmentBehavior *attachment in self.attachmentsForViews) {
            [self.animator removeBehavior:attachment];
        }
    }
}

- (void)pan:(UIPanGestureRecognizer *)gesture {
    CGPoint gesturePoint =[gesture locationInView:self];
    if (self.pinchedViews) {
        if (gesture.state == UIGestureRecognizerStateBegan) {
            [self attachCardsViewToPoint:gesturePoint];
        } else if (gesture.state == UIGestureRecognizerStateChanged) {
            for (UIAttachmentBehavior *attachment in self.attachmentsForViews) {
                attachment.anchorPoint = gesturePoint;
            }
        } else if (gesture.state == UIGestureRecognizerStateEnded) {
            for (UIAttachmentBehavior *attachment in self.attachmentsForViews) {
                [self.animator removeBehavior:attachment];
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
