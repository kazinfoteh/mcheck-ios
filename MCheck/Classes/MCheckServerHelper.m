//
//  MCheckServerHelper.m
//  MCheck
//
//  Created by Yelnar Shopanov on 05.05.2018.
//  Copyright (c) 2018 KazInfoTeh. All rights reserved.
//

#import "MCheckServerHelper.h"

#define URL_HOST @"http://isms.center"
#define URL_V1 URL_HOST @"/v1"
#define URL_VALIDATION URL_V1 @"/validation"
#define URL_VALIDATION_REQUEST URL_VALIDATION @"/request"
#define URL_VALIDATION_VERIFY URL_VALIDATION @"/verify"
#define URL_VALIDATION_STATUS URL_VALIDATION @"/status"

#define TOKEN @"token"
#define ERROR_CODE @"error_code"
#define ERROR_MESSAGE @"error_message"
#define ID @"id"
#define PHONE @"phone"
#define TYPE @"type"
#define VALIDATION_DATE @"validation_date"
#define VALIDATED @"validated"
#define MSG @"msg"
#define PIN @"pin"

@implementation MCheckServerHelper

+ (void)requestValidationWithToken:(NSString*)token phone:(NSString*)phone type:(MCheckValidationType)type message:(NSString*)message callback:(void (^)(MCheckRequestValidationResult*, NSError*))callback {
    NSError *error = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:@{PHONE:phone, TYPE:[self validationTypeName:type], MSG:message} options:0 error:&error];
    
    if (error) {
        callback(nil, error);
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL_VALIDATION_REQUEST]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = json;
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:token forHTTPHeaderField:TOKEN];
    
    __weak __typeof(self) weakSelf = self;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        @try {
            [weakSelf checkResponse:data response:response error:error];
            
            NSError *error = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error) {
                @throw error;
            }
            
            MCheckRequestValidationResult *result = [[MCheckRequestValidationResult alloc] init];
            result.rid = [json objectForKey:ID];
            result.phone = [json objectForKey:PHONE];
            
            id type = [json objectForKey:TYPE];
            result.type = type && type != [NSNull null] && [type boolValue];
            
            callback(result, nil);
        } @catch (NSError *e) {
            callback(nil, e);
        } @catch (NSException *ex) {
            callback(nil, [[NSError alloc] initWithDomain:@"" code:500 userInfo:ex.userInfo]);
        }
    }];
    [task resume];
}

+ (void)verifyValidationWithToken:(NSString*)token id:(NSString*)rid pin:(NSString*)pin callback:(void (^)(MCheckVerifyValidationResult*, NSError*))callback {
    NSError *error = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:@{ID:rid, PIN:pin} options:0 error:&error];
    
    if (error) {
        callback(nil, error);
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL_VALIDATION_VERIFY]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = json;
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:token forHTTPHeaderField:TOKEN];
    
    __weak __typeof(self) weakSelf = self;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        @try {
            [weakSelf checkResponse:data response:response error:error];
            
            NSError *error = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error) {
                @throw error;
            }
            
            MCheckVerifyValidationResult *result = [[MCheckVerifyValidationResult alloc] init];
            result.phone = [json objectForKey:PHONE];
            
            id validationDate = [json objectForKey:VALIDATION_DATE];
            result.validationDate = validationDate && validationDate != [NSNull null] ? [validationDate integerValue] : 0;
            
            id type = [json objectForKey:VALIDATED];
            result.validated = type && type != [NSNull null] && [type boolValue];
            
            callback(result, nil);
        } @catch (NSError *e) {
            callback(nil, e);
        } @catch (NSException *ex) {
            callback(nil, [[NSError alloc] initWithDomain:@"" code:500 userInfo:ex.userInfo]);
        }
    }];
    [task resume];
}

+ (void)statusValidationWithToken:(NSString*)token id:(NSString*)rid callback:(void (^)(MCheckValidationStatusResult*, NSError*))callback {
    NSError *error = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:@{ID:rid} options:0 error:&error];
    
    if (error) {
        callback(nil, error);
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL_VALIDATION_STATUS]];
    request.HTTPMethod = @"POST";
    request.HTTPBody = json;
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
    [request setValue:token forHTTPHeaderField:TOKEN];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        @try {
            [self checkResponse:data response:response error:error];
            
            NSError *error = nil;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error) {
                @throw error;
            }
            
            MCheckValidationStatusResult *result = [[MCheckValidationStatusResult alloc] init];
            result.phone = [json objectForKey:PHONE];
            
            id validationDate = [json objectForKey:VALIDATION_DATE];
            result.validationDate = validationDate && validationDate != [NSNull null] ? [validationDate integerValue] : 0;
            
            id type = [json objectForKey:VALIDATED];
            result.validated = type && type != [NSNull null] && [type boolValue];
            
            callback(result, nil);
        } @catch (NSError *e) {
            callback(nil, e);
        } @catch (NSException *ex) {
            callback(nil, [[NSError alloc] initWithDomain:@"" code:500 userInfo:ex.userInfo]);
        }
    }];
    [task resume];
}

+ (NSString*)validationTypeName:(MCheckValidationType)type {
    switch (type) {
        case SMS:
            return @"sms";
        default:
            return @"";
    }
}

+ (void)checkResponse:(NSData*)data response:(NSURLResponse*)response error:(NSError*)error {
    if (error) {
        @throw error;
    }
    
    if (!response) {
        @throw [[NSError alloc] initWithDomain:@"" code:500 userInfo:@{NSLocalizedDescriptionKey: @"Server error, empty response"}];
    }
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    
    if (httpResponse.statusCode != 200) {
        [self checkBase:data];
        @throw [[NSError alloc] initWithDomain:@"" code:httpResponse.statusCode userInfo:@{NSLocalizedDescriptionKey: @"Server error"}];
    } else {
        [self checkBase:data];
    }
}

+ (void)checkBase:(NSData*)data {
    if (!data) {
        @throw [[NSError alloc] initWithDomain:@"" code:500 userInfo:@{NSLocalizedDescriptionKey: @"Server error, empty response"}];
    }
    
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error) {
        @throw error;
    }
    
    NSNumber *errorCode = [json objectForKey:ERROR_CODE];
    
    if (errorCode && [errorCode integerValue] != 0) {
        NSString *errorMessage = [json objectForKey:ERROR_MESSAGE];
        @throw [[NSError alloc] initWithDomain:@"" code:[errorCode integerValue] userInfo:@{NSLocalizedDescriptionKey: errorMessage ? errorMessage : @""}];
    }
}

@end
