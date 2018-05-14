//
//  MCheckRequestValidationResult.h
//  MCheck
//
//  Created by Yelnar Shopanov on 05.05.2018.
//  Copyright (c) 2018 KazInfoTeh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCheckRequestValidationResult : NSObject

/**
 * unique identifier of the validation request
 */
@property (nonatomic) NSString* rid;
/**
 * validation type as requested
 */
@property (nonatomic) BOOL type;
/**
 * the number that needs to be validated
 */
@property (nonatomic) NSString* phone;

@end
