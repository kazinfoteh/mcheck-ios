//
//  MCViewController.m
//  MCheck
//
//  Created by Yelnar Shopanov on 05/05/2018.
//  Copyright (c) 2018 KazInfoTeh. All rights reserved.
//

#import "MCViewController.h"
#import "MCheck.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "MCheckValidationType.h"

@interface MCViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberInput;
@property (weak, nonatomic) IBOutlet UILabel *requestIdLabel;
@property (weak, nonatomic) IBOutlet UITextField *pinCodeInput;

@property (nonatomic) MCheck *mCheck;

@end

@implementation MCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *token = @"YOUR_TOKEN"; //automatically generated token from https://isms.center
    
    self.mCheck = [[MCheck alloc] initWithToken:token];
}

- (IBAction)requestValidationAction:(UIButton *)sender {
    if (!self.phoneNumberInput.text || self.phoneNumberInput.text.length == 0) {
        [self showMessage:@"Enter phone number"];
        return;
    }
    
    // [:phone] phone number
    // [:pin] validation code
    
    NSString *smsBody = @"Your validation code: [:pin]"; // smsBody is optional param, and maybe is null
    __weak __typeof(self) weakSelf = self;
    
    [SVProgressHUD show]; //show loading view
    
    [self.mCheck requestValidationWithPhone:self.phoneNumberInput.text type:SMS message:smsBody callback:^(MCheckRequestValidationResult *result, NSError *error) {
        [SVProgressHUD dismiss];
        
        if (error) {
            [weakSelf showMessage:[NSString stringWithFormat:@"code: %ld\nmessage: %@", (long)error.code, error.localizedDescription]];
            return;
        }
        
        weakSelf.requestIdLabel.text = result.rid;
        [weakSelf showMessage:[NSString stringWithFormat:@"Success, request ID: %ld", (long)result.rid]];
    }];
}

- (IBAction)checkValidationStatusAction:(UIButton *)sender {
    if (!self.requestIdLabel.text || self.requestIdLabel.text.length == 0) {
        [self showMessage:@"Execute first request validation"];
        return;
    }
    
    [SVProgressHUD show]; //show loading view
    
    NSString *requestID = self.requestIdLabel.text; // it's coming from request validation
    __weak __typeof(self) weakSelf = self;
    
    [self.mCheck checkValidationStatusWithRequestId:requestID callback:^(MCheckValidationStatusResult *result, NSError *error) {
        [SVProgressHUD dismiss];
        
        if (error) {
            [weakSelf showMessage:[NSString stringWithFormat:@"code: %ld\nmessage: %@", (long)error.code, error.localizedDescription]];
            return;
        }
        
        [weakSelf showMessage:[NSString stringWithFormat:@"Validated: %@", result.validated ? @"YES" : @"NO"]];
    }];
}

- (IBAction)verifyValidationAction:(UIButton *)sender {
    if (!self.requestIdLabel.text || self.requestIdLabel.text.length == 0) {
        [self showMessage:@"Execute first request validation"];
        return;
    }
    
    if (!self.pinCodeInput.text || self.pinCodeInput.text.length == 0) {
        [self showMessage:@"Enter pin code"];
        return;
    }
    
    [SVProgressHUD show]; //show loading view
    
    NSString *requestID = self.requestIdLabel.text; // it's coming from request validation
    NSString *pinCode = self.pinCodeInput.text;
    __weak __typeof(self) weakSelf = self;
    
    [self.mCheck verifyValidationWithRequestId:requestID pin:pinCode callback:^(MCheckVerifyValidationResult *result, NSError *error) {
        [SVProgressHUD dismiss];
        
        if (error) {
            [weakSelf showMessage:[NSString stringWithFormat:@"code: %ld\nmessage: %@", (long)error.code, error.localizedDescription]];
            return;
        }
        
        [weakSelf showMessage:[NSString stringWithFormat:@"Validated: %@", result.validated ? @"YES" : @"NO"]];
    }];
}

- (void)showMessage:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
