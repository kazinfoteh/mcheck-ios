#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MCheck.h"
#import "MCheckRequestValidationResult.h"
#import "MCheckServerHelper.h"
#import "MCheckValidationStatusResult.h"
#import "MCheckValidationType.h"
#import "MCheckValidationTypeHelper.h"
#import "MCheckVerifyValidationResult.h"

FOUNDATION_EXPORT double MCheckVersionNumber;
FOUNDATION_EXPORT const unsigned char MCheckVersionString[];

