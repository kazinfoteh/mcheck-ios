//
//  MCheck.m
//  MCheck
//
//  Created by Yelnar Shopanov on 05.05.2018.
//  Copyright (c) 2018 KazInfoTeh. All rights reserved.
//

#import "MCheck.h"
#import "MCheckServerHelper.h"

@interface MCheck()

@property (nonatomic) NSString* token;

@end

@implementation MCheck

/**
 * Init constructor.
 *
 * @param aToken automatically generated token from https://isms.center
 */
- (instancetype)initWithToken:(NSString*)aToken {
    if ((self = [super init])) {
        self.token = aToken;
    }
    
    return self;
}

/**
 * The Request Validation API lets you requesting a validation using one of the available methods:
 * SMS - Send a message to the user with a validation code that he has to enter to validate his mobile number.
 *
 * @param phone    the number that has to be validated
 * @param type     one of the following value: sms
 * @param message  sms message body
 * @param callback result
 */
- (void)requestValidationWithPhone:(NSString*)phone type:(MCheckValidationType)type message:(NSString*)message callback:(void(^)(MCheckRequestValidationResult*, NSError*))callback {
    [MCheckServerHelper requestValidationWithToken:self.token phone:phone type:type message:message callback:^(MCheckRequestValidationResult *result, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            callback(result, error);
        }];
    }];
}

/**
 * The Verify Pin API lets you to match a validation request with a validation pin inserted by a user.
 * SMS validation process.
 *
 * @param requestId validation request id
 * @param pin       the pin number inserted by user
 * @param callback  result
 */
- (void)verifyValidationWithRequestId:(NSString*)requestId pin:(NSString*)pin callback:(void(^)(MCheckVerifyValidationResult*, NSError*))callback {
    [MCheckServerHelper verifyValidationWithToken:self.token id:requestId pin:pin callback:^(MCheckVerifyValidationResult *result, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            callback(result, error);
        }];
    }];
}

/**
 * The Validation status API let you to check the validation status of a request.
 *
 * @param requestId validation request id
 * @param callback  result
 */
- (void)checkValidationStatusWithRequestId:(NSString*)requestId callback:(void(^)(MCheckValidationStatusResult*, NSError*))callback {
    [MCheckServerHelper statusValidationWithToken:self.token id:requestId callback:^(MCheckValidationStatusResult *result, NSError *error) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            callback(result, error);
        }];
    }];
}

@end
