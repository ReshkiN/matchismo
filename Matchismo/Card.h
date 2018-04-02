//
//  Card.h
//  Matchismo
//
//  Created by Dmitry Reshetnik on 6/30/17.
//  Copyright © 2017 Dmitry Reshetnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
