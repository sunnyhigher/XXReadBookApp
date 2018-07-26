//
//  NSNumber+BinAdd.h
//  CommonElement
//
//  Created by 瑞新段 on 2017/10/27.
//  Copyright © 2017年 瑞新段. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (BinAdd)
#pragma mark - NumberWithString
///=============================================================================
/// @name numberWithString
///=============================================================================

/**
 * 字符串转换为 NSNumber，转换失败返回nil
 */
+ (nullable NSNumber *)numberWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
