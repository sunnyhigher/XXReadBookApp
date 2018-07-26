//
//  NSDecimalNumber+BinAdd.m
//  CommonElement
//
//  Created by 瑞新段 on 2017/10/27.
//  Copyright © 2017年 瑞新段. All rights reserved.
//

#import "NSDecimalNumber+BinAdd.h"

@implementation NSDecimalNumber (BinAdd)
/**
 *  @brief  四舍五入 NSRoundPlain
 *
 *  @param scale 限制位数
 *
 *  @return 返回结果
 */
- (NSDecimalNumber *)roundToScale:(NSUInteger)scale{
    return [self roundToScale:scale mode:NSRoundPlain];
}
/**
 *  @brief  四舍五入
 *
 *  @param scale        限制位数
 *  @param roundingMode NSRoundingMode
 *
 *  @return 返回结果
 */
- (NSDecimalNumber *)roundToScale:(NSUInteger)scale mode:(NSRoundingMode)roundingMode{
    NSDecimalNumberHandler * handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:roundingMode scale:scale raiseOnExactness:NO raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
    return [self decimalNumberByRoundingAccordingToBehavior:handler];
}
@end
