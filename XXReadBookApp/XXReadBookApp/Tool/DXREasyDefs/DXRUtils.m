//
//  DXRUtils.m
//  MyDefine
//
//  Created by 段新瑞 on 2017/5/8.
//  Copyright © 2017年 段新瑞. All rights reserved.
//

#import "DXRUtils.h"
#import <objc/objc.h>
#import <objc/runtime.h>
#import "DXRPrivates.h"

#define DXR_SYSTEM_VERSION_HIGHER_EQUAL(n)  ([[[UIDevice currentDevice] systemVersion] floatValue] >= n)

@implementation DXRUtils

+ (UIColor *)colorWithColorObject:(id)object {
    if ([object isKindOfClass:[UIColor class]]) {
        return object;
        
    } else if ([object isKindOfClass:[NSString class]]) {
        CGFloat alpha = 1;
        NSArray *componnets = [object componentsSeparatedByString:@","];
        
        //whether the color object contains alpha
        if (componnets.count == 2 || componnets.count == 4) {
            NSRange range = [object rangeOfString:@"," options:NSBackwardsSearch];
            alpha = [[object substringFromIndex:range.location + range.length] floatValue];
            alpha = MIN(alpha, 1);
            object = [object substringToIndex:range.location];
        }
        
        //system color
        SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@Color", object]);
        if ([UIColor respondsToSelector:sel]) {
            UIColor *color = [UIColor performSelector:sel withObject:nil];
            if (alpha != 1) color = [color colorWithAlphaComponent:alpha];
            return color;
        }
        
        int r = 0, g = 0, b = 0;
        BOOL isRGBColor = NO;
        
        //random
        if ([object isEqualToString:@"random"]) {
            r = arc4random_uniform(256);
            g = arc4random_uniform(256);
            b = arc4random_uniform(256);
            isRGBColor = YES;
            
        } else {
            BOOL isHex = NO;
            
            if ([object hasPrefix:@"#"]) {
                object = [object substringFromIndex:1];
                isHex = YES;
            }
            if ([object hasPrefix:@"0x"]) {
                object = [object substringFromIndex:2];
                isHex = YES;
            }
            
            if (isHex) {
                int result = sscanf([object UTF8String], "%2x%2x%2x", &r, &g, &b);     //#FFFFFF
                
                if (result != 3) {
                    result = sscanf([object UTF8String], "%1x%1x%1x", &r, &g, &b);     //#FFF
                    
                    //convert #FFF to #FFFFFF
                    if (result == 3) {
                        r *= 17; g *= 17; b *= 17;
                    }
                }
                isRGBColor = (result == 3);
                
            } else {
                int result = sscanf([object UTF8String], "%d,%d,%d", &r, &g, &b);       //rgb
                isRGBColor = (result == 3);
            }
        }
        
        if (isRGBColor) {
            return [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:alpha];
        }
        
    } else if ([object isKindOfClass:[UIImage class]]) {
        return [UIColor colorWithPatternImage:object];
    }
    
    return nil;
}

+ (UIFont *)fontWithFontObject:(id)object {
    if ([object isKindOfClass:[UIFont class]]) {
        return object;
        
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [UIFont boldSystemFontOfSize:[object floatValue]];
        
    } else if ([object isKindOfClass:[NSString class]]) {
        static NSMutableDictionary *fontStyles = nil;
        
        if (!fontStyles) {
            fontStyles = [@{
                            @"headline": UIFontTextStyleHeadline,
                            @"subheadline": UIFontTextStyleSubheadline,
                            @"caption1": UIFontTextStyleCaption1,
                            @"caption2": UIFontTextStyleCaption2,
                            @"body": UIFontTextStyleBody,
                            @"footnote": UIFontTextStyleFootnote,
                            } mutableCopy];
            
            if (DXR_SYSTEM_VERSION_HIGHER_EQUAL(9)) {
                [fontStyles setObject:UIFontTextStyleCallout forKey:@"callout"];
                [fontStyles setObject:UIFontTextStyleTitle1 forKey:@"title1"];
                [fontStyles setObject:UIFontTextStyleTitle2 forKey:@"title2"];
                [fontStyles setObject:UIFontTextStyleTitle3 forKey:@"title3"];
            }
        }
        
        NSString *fontString = [object lowercaseString];
        NSString *style = fontStyles[fontString];
        
        if (style) {
            return [UIFont preferredFontForTextStyle:style];
        }
        
        NSArray *elements = [object componentsSeparatedByString:@","];
        if (elements.count == 2) {
            NSString *fontName = elements[0];
            CGFloat fontSize = [elements[1] floatValue];
            return [UIFont fontWithName:fontName size:fontSize];
        }
        
        CGFloat fontSize = [fontString floatValue];
        if (fontSize > 0) {
            return [UIFont systemFontOfSize:fontSize];
        }
    }
    
    return nil;
}

+ (UIImage *)imageWithImageObject:(id)object {
    return [self imageWithImageObject:object allowColorImage:YES];
}

+ (UIImage *)imageWithImageObject:(id)object allowColorImage:(BOOL)allowColorImage {
    if ([object isKindOfClass:[UIImage class]]) {
        return object;
        
    } else if ([object isKindOfClass:[NSString class]]) {
        BOOL stretchImage = [object hasPrefix:@"#"];
        NSString *imageName = stretchImage? [object substringFromIndex:1]: object;
        UIImage *image = [UIImage imageNamed:imageName];
        
        if (stretchImage) {
            if (!image) {
                image = [UIImage imageNamed:object];     //fallback
                
            } else {
                return [image dxr_stretchableImage];
            }
        }
        
        if (allowColorImage && !image) {
            image = [self onePointImageWithColor:[DXRUtils colorWithColorObject:object]];
        }
        
        return image;
    }
    
    return nil;
}

+ (UIImage *)onePointImageWithColor:(UIColor *)color {
    if (!color) return nil;
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    BOOL hasAlpha = [self colorHasAlphaChannel:color];
    UIGraphicsBeginImageContextWithOptions(rect.size, !hasAlpha, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (BOOL)colorHasAlphaChannel:(UIColor *)color {
    return CGColorGetAlpha(color.CGColor) < 1;
}

+ (UIImage *)onePointImageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color) return nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    BOOL hasAlpha = [self colorHasAlphaChannel:color];
    UIGraphicsBeginImageContextWithOptions(rect.size, !hasAlpha, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/*
 *  获取当前控制器
 */



+ (UIViewController *)getVisibleViewController {
    UIWindow *window = [UIApplication sharedApplication ].delegate.window;
    UIViewController *rootViewController = window.rootViewController;
    return [self getVisibleViewController:rootViewController];
}

+ (UIViewController *)getVisibleViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        
        return [self getVisibleViewController:lastViewController];
    }
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        
        return [self getVisibleViewController:selectedViewController];
    }
    
    if (rootViewController.presentedViewController != nil) {
        UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
        return [self getVisibleViewController:presentedViewController];
    }
    
    return rootViewController;
}

+ (UIViewController *)findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController *svc = (UISplitViewController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController *svc = (UINavigationController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        
        return vc;
    }
}

+ (UIViewController *) currentViewController {
    // Find best view controller
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];
}

@end
