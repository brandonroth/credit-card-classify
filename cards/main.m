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

        NSArray *visa = @[@"4"];

        NSArray *mastercard = @[@"51-55"];

        NSArray *discover = @[@"60",@"65"];

        NSArray *amex = @[@"34",@"37"];

        NSArray *JCB = @[@"2528-3589"];

        NSDictionary *cards = @{@"visa": visa,
                               @"mastercard": mastercard,
                               @"discover": discover,
                               @"amex": amex,
                               @"JCB": JCB};

    
        CardValidator *validator = [CardValidator sharedValidator];
//        [validator addCardPrefix:@"4" forCardType:@"Visa"];
//        [validator addCardPrefix:@"35" forCardType:@"Amex"];
//        [validator addCardPrefix:@"37" forCardType:@"Amex"];
//        [validator addCardPrefix:@"3528" forCardType:@"JCB"];

        [validator addCardPrefixesFromDictionary:cards];

        NSMutableArray *card = [[NSMutableArray alloc] init];
        [card addObject:@"3"];
        [card addObject:@"5"];
        [card addObject:@"2"];

        NSString *cardNumber = @"359010";
        
        NSSet * set = [validator possibleCardsForCardNumber:cardNumber];

        NSLog(@"%@",set);

    }
    return 0;
}

