//
//  DXRPrivates.m
//  MyDefine
//
//  Created by 段新瑞 on 2017/5/10.
//  Copyright © 2017年 段新瑞. All rights reserved.
//

#import "DXRPrivates.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UIImage (DXRPrivate)

- (UIImage *)dxr_stretchableImage {
    CGFloat halfWidth = floorf(self.size.width / 2);
    CGFloat halfHeight = floorf(self.size.height / 2);
    UIEdgeInsets insets = UIEdgeInsetsMake(halfHeight - 1, halfWidth - 1, halfHeight, halfWidth);
    return [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

@end

@implementation UIColor (DXRPrivate)


@end

@implementation NSString (DXRPrivate)
- (NSRange)dxr_fullRange {
    return NSMakeRange(0, self.length);
}

- (NSString *)dxr_md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *md5 = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5 appendFormat:@"%02x", result[i]];
    }
    
    return [md5 lowercaseString];
}

- (NSString *)dxr_base64 {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
}
@end
