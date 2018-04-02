//
//  PadView.h
//  Matchismo
//
//  Created by Dmitry Reshetnik on 8/25/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PadView : UIView

@property (nonatomic) BOOL pinchedViews;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;
-(void)pan:(UIPanGestureRecognizer *)gesture;

@end
