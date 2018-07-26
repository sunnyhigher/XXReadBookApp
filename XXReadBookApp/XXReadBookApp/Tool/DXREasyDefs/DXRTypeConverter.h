//
//  DXRTypeConverter.h
//  DXRdyUI
//
//  Created by DXRdycat on 16/9/28.
//  Copyright © 2016 DXRdycat. All rights reserved.
//

#import <objc/objc.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import "DXRDefs.h"


#define DXR_CONVERT_VALUE_TO_STRING(x)  DXRConvertValueToString(DXR_TYPE(x), x)
#define DXR_CONVERT_VALUE_TO_NUMBER(x)  DXRConvertValueToNumber(DXR_TYPE(x), x)

#define DXR_IS_STRING(x)                (DXR_IS_OBJECT(x) && DXRObjectIsKindOfClass(@"NSString", x))
#define DXR_CHECK_IS_STRING(x, ...)     DXR_IS_STRING(x)

#define DXR_STRING_VALUE(x, ...)        ({ typeof(x) _ix_ = (x); DXRStringRepresentationOfValue(@encode(typeof(x)), &_ix_); })
#define DXR_STRING_FORMAT(...)          ({ DXRFormatedStringWithArgumentsCount(DXR_NUMBER_OF_VA_ARGS(__VA_ARGS__), __VA_ARGS__); })

#define DXR_LOG_PREFIX(x, ...)          ({ const char *_exp_ = #x; _exp_[strlen(_exp_) - 1] == '"'? @"": [NSString stringWithFormat:@"%s: ", _exp_]; })


id      DXRConvertValueToString(const char *type, ...);
id      DXRConvertValueToNumber(const char *type, ...);
id      DXRObjectFromVariadicFunction(NSString *placeholder, ...);
BOOL    DXRObjectIsKindOfClass(NSString *className, ...);

NSString *      DXRFormatedStringWithArgumentsCount(NSInteger count, ...);
NSString *      DXRStringRepresentationOfValue(const char *type, const void *value);


