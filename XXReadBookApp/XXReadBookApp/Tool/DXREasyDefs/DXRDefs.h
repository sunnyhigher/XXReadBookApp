//
//  DXRDefs.h
//  MyDefine
//
//  Created by 段新瑞 on 2017/5/10.
//  Copyright © 2017年 段新瑞. All rights reserved.
//

#ifndef DXRDefs_h
#define DXRDefs_h

#import "DXRUtils.h"
#import "DXRTypeConverter.h"
#import "DXRPrivates.h"

/**
 1) UIImage object
 2) @"imageName"
 3) @"#imageName": stretchable image
 4) Any color value that Color() supported.
 
 * 使用＃字符前缀图像名称将创建一个可伸缩的图像。
 * 传递颜色值将创建一个具有特定颜色的1x1尺寸图像。
 
 * 使用:
 Img([UIImage imageNamed:@"cat"],
 Img(@"cat"),
 Img(@"#button-background"),
 Img(@"33,33,33,0.5"), // Img(rbga)
 Img(@"red")
 */
#define Img(x)      [DXRUtils imageWithImageObject:x]

#pragma mark -
#pragma mark - UIFont
/**
 1) UIFont object
 2) 15: systemFontOfSize 15
 3) @15: boldSystemFontOfSize 15
 4) @"Helvetica,15": fontName + fontSize, separated by comma.
 
 * 使用:
 Font([UIFont systemFontOfSize:15]),
 Font(15),
 Font(@15),
 Font(@"Helvetica,15")
 */
#define Font(x)  [DXRUtils fontWithFontObject:DXR_CONVERT_VALUE_TO_STRING(x)]


#pragma mark -
#pragma mark - UIColor
/**
 1) UIColor object
 2) UIImage object, return a pattern image color
 3) @"red", @"green", @"blue", @"clear", etc. (any system color)
 5) @"random": randomColor
 6) @"255,0,0": RGB color
 7) @"#FF0000" or @"0xF00": Hex color
 
 * 所有的字符串表示都可以有一个可选的alpha值。
 
 * 使用:
 Color([UIColor redColor]),
 Color([UIImage imageNamed:@""]),
 Color(@"red,0.5"),
 Color(@"255,0,0,1"),
 Color(@"#F00,0.5"),
 Color(@"random,0.5")
 */
#define Color(x)    [DXRUtils colorWithColorObject:x]

#pragma mark -
#pragma mark - NSString
/**
 1) C string
 2) any primitive type
 3) any object
 4) CGRect, CGPoint, CGSize, NSRange, UIEdgeInsets
 5) Selector
 6) Class
 7) Format String
 
 * 使用: 
 Str(100),
 Str(3.14),
 Str(@0.618),
 Str([UIView class]),
 Str(_cmd),
 Str(view.frame),
 Str("Hello"),
 Str(@"%d+%d=%d", 1, 1, 1 + 1)
 */
#define Str(...)                ({DXR_CHECK_IS_STRING(__VA_ARGS__)? \
                                    DXR_STRING_FORMAT(__VA_ARGS__):\
                                    DXR_STRING_VALUE(__VA_ARGS__);})

#pragma mark -
#pragma mark - NSLog
#ifndef __OPTIMIZE__
//#define XXLog(...)                ({id _prefix_ = DXR_LOG_PREFIX(__VA_ARGS__); \
                                    id _str_ = Str(__VA_ARGS__);\
                                    NSLog(@"%@%@", _prefix_, _str_);})
#define XXLog(...)                ({id _str_ = Str(__VA_ARGS__);\
                                        NSLog(@"%@", _str_);})
#else
#define XXLog(...)
#endif

#pragma mark -
#pragma mark - NSURL
#define Url(s)                  [NSURL URLWithString:s]




//////////////////////////////////////////////////////////
//                  提供上边调用的宏                       //
//////////////////////////////////////////////////////////
#define DXR_TYPE(x)                 @encode(typeof(x))
#define DXR_TYPE_FIRST_LETTER(x)    (DXR_TYPE(x)[0])
#define DXR_IS_TYPE_OF(x)           (strcmp(type, @encode(x)) == 0)

#define DXR_CHECK_IS_INT(x)         (strchr("liBLIcsqCSQ", x) != NULL)
#define DXR_CHECK_IS_FLOAT(x)       (strchr("df", x) != NULL)
#define DXR_CHECK_IS_OBJECT(x)      (strchr("@#", x) != NULL)

#define DXR_IS_OBJECT(x)            (strchr("@#", DXR_TYPE_FIRST_LETTER(x)) != NULL)


#define DXR_NUMBER_OF_VA_ARGS(...)  DXR_NUMBER_OF_VA_ARGS_(__VA_ARGS__, DXR_RSEQ_N())
#define DXR_NUMBER_OF_VA_ARGS_(...) DXR_ARG_N(__VA_ARGS__)

#define DXR_ARG_N( \
_1, _2, _3, _4, _5, _6, _7, _8, _9,_10, \
_11,_12,_13,_14,_15,_16,_17,_18,_19,_20, \
_21,_22,_23,_24,_25,_26,_27,_28,_29,_30, \
_31,_32,_33,_34,_35,_36,_37,_38,_39,_40, \
_41,_42,_43,_44,_45,_46,_47,_48,_49,_50, \
_51,_52,_53,_54,_55,_56,_57,_58,_59,_60, \
_61,_62,_63,N,...) N

#define DXR_RSEQ_N() \
63,62,61,60,                   \
59,58,57,56,55,54,53,52,51,50, \
49,48,47,46,45,44,43,42,41,40, \
39,38,37,36,35,34,33,32,31,30, \
29,28,27,26,25,24,23,22,21,20, \
19,18,17,16,15,14,13,12,11,10, \
9,8,7,6,5,4,3,2,1,0





#endif /* DXRDefs_h */
