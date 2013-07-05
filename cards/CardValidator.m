//
//  CardValidator.m
//
//  Created by Brandon Roth on 7/4/13.
//  Copyright (c) 2013 Rocketmade. All rights reserved.
//

#import "CardValidator.h"

@interface Node : NSObject

@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSMutableSet *possibleCards;
@property (strong, nonatomic) NSMutableDictionary *children;

-(void)addCardPrefix:(NSString*)prefix forCardType:(NSString*)cardType;
-(NSSet*)possibleCardsForCardNumber:(NSMutableArray*)cardNumber;

@end

@interface CardValidator()

@property (strong, nonatomic) Node  *head;
@property (strong, nonatomic) NSMutableSet *knownCards;

@end

@implementation CardValidator

+(CardValidator*)sharedValidator
{
    static CardValidator *validator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        validator = [[CardValidator alloc] init];
    });
    return validator;
}

-(CardValidator*)init
{
    self.head = [[Node alloc] init];
    self.knownCards = [[NSMutableSet alloc] init];
    return self;
}

-(NSSet*)possibleCardsForCardNumber:(NSString *)cardNumber
{
    //convert the card number string into a mutable arrray to pass to the head
    NSMutableArray *cardNumberAsArray = [[NSMutableArray alloc] initWithCapacity:cardNumber.length];
    NSRange range;
    range.length = cardNumber.length;
    range.location = 0;
    [cardNumber enumerateSubstringsInRange:range
                                   options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                       [cardNumberAsArray addObject:substring];
                                   }];
    
    return [self.head possibleCardsForCardNumber:cardNumberAsArray];
}

-(void)addCardPrefix:(NSString *)prefix forCardType:(NSString *)cardType
{
    if (prefix && cardType)
    {
        [self.knownCards addObject:cardType];
        [self.head addCardPrefix:prefix forCardType:cardType];
    }
}

-(void)addCardPrefixesFromDictionary:(NSDictionary *)dictionary
{

}

-(NSSet*)listOfKnownCards
{
    return self.knownCards;
}

@end

@implementation Node

-(Node*)init
{
    self.possibleCards = [[NSMutableSet alloc] init];
    self.children = [[NSMutableDictionary alloc] init];
    return self;
}

-(Node*)initWithStringValue:(NSString*)inValue
{
    self.value = inValue;
    self.possibleCards = [[NSMutableSet alloc] init];
    self.children = [[NSMutableDictionary alloc] init];
    return self;
}


-(Node*)addChildWithValue:(NSString*)value cardType:(NSString*)cardType
{
    Node *child = self.children[value];

    if (child)
    {
        //the child exists, we only need to add the possible card types to the childs list
        [child.possibleCards addObject:cardType];
    }
    else
    {
        //the child doesn't exist. we need to create a new child, and add it to this nodes
        //children
        child = [[Node alloc] initWithStringValue:value];
        [child.possibleCards addObject:cardType];
        [self.children setObject:child forKey:child.value];
    }
    return child;
}

-(void)addCardPrefix:(NSString*)prefix forCardType:(NSString*)cardType;
{
    NSRange range;
    range.location = 0;
    range.length = prefix.length;

    //self should be the head otherwise the tree won't be built correctly.
    //this is enforced by keeping the Node class an internal data structure.
    __block Node *node = self;
    
    [prefix enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        node = [node addChildWithValue:substring cardType:cardType];
    }];
}

/*
The method searches the tree for a card number match
If it is able to positively match a card number it will return a set with 1 string element which is the name of the card
If it unable to identify a card becasue it doesn't have enough information it will return a set will possible matches
If it is unable to identy a card because the prefix doesn't exist it will return and empty set;
*/
-(NSSet*)possibleCardsForCardNumber:(NSMutableArray*)cardNumber
{
    //if we run out of card digits then the node we landed on will know which
    //cards it's path is associated with
    if (cardNumber.count == 0)
    {
        return self.possibleCards;
    }

    //pull the next number from the list
    NSString *nextNumberInSequence = cardNumber[0];
    [cardNumber removeObjectAtIndex:0];

    //if there is a child with that value recurse down that part of the tree
    //otherwise that means we have a card prefix which isn't in the tree so the
    //card is invalid
    Node *possibleChild = [self.children objectForKey:nextNumberInSequence];
    if (possibleChild)
    {
        return [possibleChild possibleCardsForCardNumber:cardNumber];
    }
    else
    {
        return nil;
    }
}

@end
