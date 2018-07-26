//
//  XXReadConfig.m
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/7/24.
//  Copyright © 2018年 段新瑞. All rights reserved.
//

#import "XXReadConfig.h"

@implementation XXReadConfig
MJCodingImplementation

+ (instancetype)shareInstance {
    static XXReadConfig *readConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        YYCache *cache = [YYCache cacheWithName:NSStringFromClass([self class])];
        if ([cache containsObjectForKey:NSStringFromClass([self class])]) {
            readConfig = (XXReadConfig *)[cache objectForKey:NSStringFromClass([self class])];
        } else {
            readConfig = [XXReadConfig new];
            readConfig.readDefaultFontSize = 14;
            readConfig.readDefaultLineSpace = 10;
            readConfig.readDefaultSegmentSpace = 5;
            readConfig.readFont = [UIFont systemFontOfSize:readConfig.readDefaultFontSize];
        }
    });
    return readConfig;
}

- (NSDictionary *)readAttribute {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距
    paragraphStyle.lineSpacing = self.readDefaultLineSpace;
    
    // 段间距
    paragraphStyle.paragraphSpacing = self.readDefaultSegmentSpace;
    
    // 当前行间距(lineSpacing)的倍数(可根据字体大小变化修改倍数)
    paragraphStyle.lineHeightMultiple = 1.0;
    
    // 对齐方式
    paragraphStyle.alignment = NSTextAlignmentJustified;
    return @{NSFontAttributeName: self.readFont,
             NSParagraphStyleAttributeName: paragraphStyle};
}

- (void)save {
    YYCache *cache = [YYCache cacheWithName:NSStringFromClass([self class])];
    [cache setObject:[XXReadConfig shareInstance] forKey:NSStringFromClass([self class])];
}

@end
