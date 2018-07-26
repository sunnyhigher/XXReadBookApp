//
//  DXRPrivates.h
//  MyDefine
//
//  Created by 段新瑞 on 2017/5/10.
//  Copyright © 2017年 段新瑞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIColor (DXRPrivate)



@end


@interface UIImage (DXRPrivate)

- (UIImage *)dxr_stretchableImage;

@end

@interface NSString (DXRPrivate)

- (NSRange)dxr_fullRange;

- (NSString *)dxr_md5;
- (NSString *)dxr_base64;

@end
