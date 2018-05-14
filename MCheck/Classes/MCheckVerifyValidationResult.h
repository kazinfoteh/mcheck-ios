//
//  MCheckVerifyValidationResult.h
//  MCheck
//
//  Created by Yelnar Shopanov on 10.05.2018.
//  Copyright (c) 2018 KazInfoTeh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCheckVerifyValidationResult : NSObject

/**
 * the number that needs to be validated
 */
@property (nonatomic) NSString *phone;
/**
 * true if the pin was correct. false Otherwise.
 */
@property (nonatomic) BOOL validated;
/**
 * the date time as UNIX timestamp when the validation was completed (the pin was matched first time).
 * In case the number is not validated the value is null
 */
@property (nonatomic) NSInteger validationDate;

@end
