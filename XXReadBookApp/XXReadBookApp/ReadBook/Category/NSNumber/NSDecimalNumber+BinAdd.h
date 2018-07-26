//
//  NSDecimalNumber+BinAdd.h
//  CommonElement
//
//  Created by 瑞新段 on 2017/10/27.
//  Copyright © 2017年 瑞新段. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDecimalNumber (BinAdd)

#pragma mark - RoundPlain
///=============================================================================
/// @name RoundPlain
///=============================================================================
/**
 *  @brief  四舍五入 NSRoundPlain
 *
 *  @param scale 限制位数
 *
 *  @return 返回结果
 */
- (NSDecimalNumber*)roundToScale:(NSUInteger)scale;
/**
 *  @brief  四舍五入
 *
 *  @param scale        限制位数
 *  @param roundingMode NSRoundingMode
 *
 *  @return 返回结果
 */
- (NSDecimalNumber*)roundToScale:(NSUInteger)scale mode:(NSRoundingMode)roundingMode;
@end

NS_ASSUME_NONNULL_END
