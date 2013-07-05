//
//  main.m
//  cards
//
//  Created by Brandon Roth on 7/4/13.
//  Copyright (c) 2013 Rocketmade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardValidator.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {

    
        CardValidator *validator = [[CardValidator alloc] init];
        [validator addCardPrefix:@"4" forCardType:@"Visa"];
        [validator addCardPrefix:@"35" forCardType:@"Amex"];
        [validator addCardPrefix:@"37" forCardType:@"Amex"];
        [validator addCardPrefix:@"3528" forCardType:@"JCB"];

        NSMutableArray *card = [[NSMutableArray alloc] init];
        [card addObject:@"3"];
        [card addObject:@"5"];
        [card addObject:@"2"];

        NSString *cardNumber = @"3";
        
        NSSet * set = [validator possibleCardsForCardNumber:cardNumber];

        NSLog(@"%@",set);

    }
    return 0;
}

