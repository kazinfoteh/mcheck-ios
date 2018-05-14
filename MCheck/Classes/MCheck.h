//
//  MCheck.h
//  MCheck
//
//  Created by Yelnar Shopanov on 05.05.2018.
//  Copyright (c) 2018 KazInfoTeh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCheckValidationType.h"
#import "MCheckRequestValidationResult.h"
#import "MCheckVerifyValidationResult.h"
#import "MCheckValidationStatusResult.h"

@interface MCheck : NSObject

- (instancetype)initWithToken:(NSString*)aToken;
- (void)requestValidationWithPhone:(NSString*)phone type:(MCheckValidationType)type message:(NSString*)message callback:(void(^)(MCheckRequestValidationResult*, NSError*))callback;
- (void)verifyValidationWithRequestId:(NSString*)requestId pin:(NSString*)pin callback:(void(^)(MCheckVerifyValidationResult*, NSError*))callback;
- (void)checkValidationStatusWithRequestId:(NSString*)requestId callback:(void(^)(MCheckValidationStatusResult*, NSError*))callback;

@end
