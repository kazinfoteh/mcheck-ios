# mCheck SDK 

mCheck SDK for ios let you integrate the mobile phone number validation API in mobile devices.

In order to test the sample you need to change the secret key.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

MCheck is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MCheck'
```

## Sample Usage

**Init SDK**
```objc
//automatically generated token from https://isms.center
NSString *token = @"YOUR_TOKEN";
self.mCheck = [[MCheck alloc] initWithToken:token];
```
**Request validation**
```objc
// [:phone] phone number
// [:pin] validation code

NSString *phone = "+77770000000";
NSString *smsBody = @"Your validation code: [:pin]"; // smsBody is optional param, and maybe is null

[self.mCheck requestValidationWithPhone:phone type:SMS message:smsBody callback:^(MCheckRequestValidationResult *result, NSError *error) {
    if (error) {
        return;
    }

    //[self showMessage:[NSString stringWithFormat:@"Success, request ID: %ld", (long)result.rid]];
}];
```
**Verify Pin**
```objc
NSString *requestID = @""; //request id received from [self.mCheck requestValidationWithPhone] - response.id
NSString *pinCode = @""; //pin code to check

[self.mCheck verifyValidationWithRequestId:requestID pin:pinCode callback:^(MCheckVerifyValidationResult *result, NSError *error) {
    if (error) {
        return;
    }

    //[self showMessage:[NSString stringWithFormat:@"Validated: %@", result.validated ? @"YES" : @"NO"]];
}];
```
**Validation Status**
```objc
NSString *requestID = @""; //request id received from [self.mCheck requestValidationWithPhone] - response.id

[self.mCheck checkValidationStatusWithRequestId:requestID callback:^(MCheckValidationStatusResult *result, NSError *error) {
    if (error) {
        return;
    }

    //[self showMessage:[NSString stringWithFormat:@"Validated: %@", result.validated ? @"YES" : @"NO"]];
}];
```

## License

MCheck is available under the MIT license. See the LICENSE file for more info.
