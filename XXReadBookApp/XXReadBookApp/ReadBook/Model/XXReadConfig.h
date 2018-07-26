//
//  XXReadConfig.h
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/7/24.
//  Copyright © 2018年 段新瑞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXReadConfig : NSObject <NSCoding>

+ (instancetype)shareInstance;
/// 阅读最小阅读字体大小
@property (nonatomic) NSInteger readMinFontSize;
/// 阅读最大阅读字体大小
@property (nonatomic) NSInteger readMaxFontSize;
/// 阅读当前默认字体大小
@property (nonatomic) NSInteger readDefaultFontSize;


/// 阅读当前默认行间距
@property (nonatomic) NSInteger readDefaultLineSpace;

/// 阅读当前默认段间距
@property (nonatomic) NSInteger readDefaultSegmentSpace;

/// 阅读当前字体
@property (nonatomic,strong) UIFont *readFont;


@property (nonatomic,strong) UIColor *theme;

- (void)save;

- (NSDictionary *)readAttribute;


@end
