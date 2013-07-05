//
//  Node.h
//  cards
//
//  Created by Brandon Roth on 7/4/13.
//  Copyright (c) 2013 Rocketmade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSMutableSet *possibleCards;
@property (strong, nonatomic) NSMutableDictionary *children;

+(Node*)headNode;

-(void)addCardPrefix:(NSString*)prefix forCardType:(NSString*)cardType;
-(NSSet*)possibleCardsForCardNumber:(NSMutableArray*)cardNumber;


@end
