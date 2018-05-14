//
//  MCheckServerHelper.h
//  MCheck
//
//  Created by Yelnar Shopanov on 05.05.2018.
//  Copyright (c) 2018 KazInfoTeh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCheckRequestValidationResult.h"
#import "MCheckValidationType.h"
#import "MCheckVerifyValidationResult.h"
#import "MCheckValidationStatusResult.h"

@interface MCheckServerHelper : NSObject

+ (void)requestValidationWithToken:(NSString*)token phone:(NSString*)phone type:(MCheckValidationType)type message:(NSString*)message callback:(void (^)(MCheckRequestValidationResult*, NSError*))callback;
+ (void)verifyValidationWithToken:(NSString*)token id:(NSString*)rid pin:(NSString*)pin callback:(void (^)(MCheckVerifyValidationResult*, NSError*))callback;
+ (void)statusValidationWithToken:(NSString*)token id:(NSString*)rid callback:(void (^)(MCheckValidationStatusResult*, NSError*))callback;

@end
