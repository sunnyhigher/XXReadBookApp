//
//  DXRUtils.h
//  MyDefine
//
//  Created by 段新瑞 on 2017/5/8.
//  Copyright © 2017年 段新瑞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DXRUtils : NSObject

+ (UIColor *)colorWithColorObject:(id)object;
+ (UIFont *)fontWithFontObject:(id)object;
+ (UIImage *)imageWithImageObject:(id)object;

+ (UIImage *)onePointImageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIViewController *)getVisibleViewController;
+ (UIViewController *) currentViewController;
@end
