//
//  main.m
//  cards
//
//  Created by Brandon Roth on 7/4/13.
//  Copyright (c) 2013 Rocketmade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {

    
        Node *head = [Node headNode];
        [head addCardPrefix:@"4" forCardType:@"Visa"];
        [head addCardPrefix:@"35" forCardType:@"Amex"];
        [head addCardPrefix:@"37" forCardType:@"Amex"];
        [head addCardPrefix:@"3528" forCardType:@"JCB"];

        NSMutableArray *card = [[NSMutableArray alloc] init];
        [card addObject:@"3"];
        [card addObject:@"5"];
        [card addObject:@"2"];
        
        NSSet * set = [head possibleCardsForCardNumber:card];

        NSLog(@"%@",set);
    }
    return 0;
}

