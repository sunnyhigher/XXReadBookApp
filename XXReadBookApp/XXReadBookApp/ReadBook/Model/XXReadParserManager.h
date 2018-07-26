//
//  XXReadParserManager.h
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXReadModel.h"

@class XXCustomMankRange;
@interface XXReadParserManager : NSObject


/**
 解析txt文本内容
 
 @param url txt文本路径
 @param block 返回解析后模型
 */
 + (void)parserLocalModelWithURL:(NSURL *)url readParserModel:(void (^)(XXReadModel *model))block;

+ (NSArray <XXCustomMankRange *> *)parserPageRangeString:(NSString *)string attrs:(NSDictionary *)attrs;

@end
