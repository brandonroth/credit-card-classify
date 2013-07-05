//
//  Node.m
//  cards
//
//  Created by Brandon Roth on 7/4/13.
//  Copyright (c) 2013 Rocketmade. All rights reserved.
//

#import "Node.h"

@interface Node()

@end

@implementation Node

+(Node*)headNode
{
    static Node *head = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        head = [[Node alloc] init];
        head.possibleCards = [[NSMutableSet alloc] init];
        head.children = [[NSMutableDictionary alloc] init];
    });
    return head;
}

-(Node*)initWithStringValue:(NSString*)inValue
{
    Node *newNode = [[Node alloc] init];
    newNode.value = inValue;
    newNode.possibleCards = [[NSMutableSet alloc] init];
    newNode.children = [[NSMutableDictionary alloc] init];
    return newNode;
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

    //start at the head
    __block Node *node = self;
    
    [prefix enumerateSubstringsInRange:range options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {

        //get the value of the new node to add
        //NSInteger newValue = [substring integerValue];

        node = [node addChildWithValue:substring cardType:cardType];
    }];
}

/*
The method searches the tree for a card number match
If it is able to positively match a card number it will return a set with 1 string element which is the name of the card
If it unable to identify a card becasue it doesn't have enough information it will return a set will possible matches
If it is unable to identy a card because the prefix doesn't exist it will return nil;
*/
-(NSSet*)possibleCardsForCardNumber:(NSMutableArray*)cardNumber
{
    //if we run out of card digits and there are still children to explore
    //then we need more information and the node we are on knows what possible cards it could be
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
