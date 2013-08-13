//
//  CardValidator.h
//
//  Created by Brandon Roth on 7/4/13.
//  Copyright (c) 2013 Rocketmade. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const kCardTypeAmbiguous;
FOUNDATION_EXPORT NSString * const kCardTypeInvalid;

@interface CardValidator : NSObject

+(CardValidator*)sharedValidator;

/*
 This method searches the prefixes for a match to the card number
 This method returns:

 -An nil if it is unable to find a match
 -A set with one string value if it is able to match
 -A set with multiple strings if it is unable to identify the card but
 doesn't have enough information yet (not enough card digits).
 */
-(NSSet*)possibleCardsForCardNumber:(NSString*)cardNumber;

//Adds a new prefix to the card validator.
-(void)addCardPrefix:(NSString*)prefix forCardType:(NSString*)cardType;

/*
 This method expects a dictionary with arrays of strings.
 The key is the card name (visa, mastercard) as a string and will
 be the card names that the possibleCardNamesForCardNumber method will
 return.  The arrays are prefixes that are associated with that card.  If a
 single value is specified then it will add that prefix, if a range is
 specified it will loop through the range and add each one.
 a range of 51,52,53,54,55 can be added with the string @"51-55".
 */
-(void)addCardPrefixesFromDictionary:(NSDictionary*)dictionary;

-(NSSet*)listOfKnownCards;

/*
 This will return the card type as a string if known.

 If there are multipe card types matchin the number provided
 then this method will return kCardTypeAmbiguous.

 If the validator can't clasify the card it will return
 kCardTypeInvalid
 */
-(NSString *)clasifyCardType:(NSString*)cardNumber;

+(BOOL)isCardNumberValid:(NSArray*)cardNumber;

@end

