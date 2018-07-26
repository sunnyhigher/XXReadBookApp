//
//  XXReadUtilites.m
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import "XXReadUtilites.h"
#import "NSString+BinAdd.h"
#import "XXReadChapterModel.h"
#import "XXCustomMankRange.h"

@implementation XXReadUtilites

#pragma mark -
#pragma mark - -- 获取名称名称

/**
 获取文件名称
 
 @param url 文件路径
 @return 文件名称
 */
+ (NSString *)getFileName:(NSURL *)url {
    
    /// 获取带后缀文件名称（为了避免名称相同，后缀不同的情况发生）
    NSString *lastPathComponent = url.path.lastPathComponent;
    return lastPathComponent;
}

#pragma mark -
#pragma mark - -- 解析Context
/**
 获取章节列表模型
 
 @param bookName 小说名称
 @param content 小说内容
 @return 章节模型列表
 */
+ (NSArray <XXReadChapterListModel *> *)separateChapterListsBookName:(NSString *)bookName content:(NSString *)content {
    
    /// 创建存储章节列表模型数组
    NSMutableArray <XXReadChapterListModel *> *readChapterListModels = [NSMutableArray new];
    
    /// 正则搜索规则
    NSString *parten = @"第[0-9一二三四五六七八九十百千]*[章回节].*";
    
    /// 搜索
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionCaseInsensitive error:nil];
    
    /// 搜索结果
    NSArray *results = [regularExpression matchesInString:content options:NSMatchingReportCompletion range:NSMakeRange(0, [content length])];
    
    /// 未搜索到匹配章节
    if (results.count != 0) {
        
        /// 记录每次截取后的 Rang
        __block NSRange lastRange = NSMakeRange(0, 0);
        
        /// 上一章模型
        __block XXReadChapterModel *lastReadChapterModel = [XXReadChapterModel new];
        
        [results enumerateObjectsUsingBlock:^(NSTextCheckingResult *object, NSUInteger index, BOOL * _Nonnull stop) {
            NSRange rang = [object range];
            NSUInteger location = rang.location;
            
            /// 创建章节内容模型
            XXReadChapterModel *readChapterModel = [XXReadChapterModel new];
            /// 书名
            readChapterModel.bookName = bookName;
            
            /// 章节 id
            readChapterModel.chapterId = [NSString stringWithFormat:@"%ld", index + 1];
            
            /// 开始
            if (index == 0) {
                
                /// 章节名称
                readChapterModel.chapterName = @"";
                
                /// 本章内容
                readChapterModel.content = [self contentTypesettingContent:[content substringWithRange:NSMakeRange(0, location)]];
                
            } else if (index == results.count - 1) { /// 最后一章
                /// 章节名称
                readChapterModel.chapterName = [content substringWithRange:lastRange];
                
                /// 本章内容
                readChapterModel.content = [self contentTypesettingContent:[content substringWithRange:NSMakeRange(lastRange.location, content.length - lastRange.location)]];
            } else { /// 中间章节
                /// 章节名称
                readChapterModel.chapterName = [content substringWithRange:lastRange];
                
                /// 本章内容
                readChapterModel.content = [self contentTypesettingContent:[content substringWithRange:NSMakeRange(lastRange.location, location - lastRange.location)]];
                
            }
                        
            // 设置上下章ID
            readChapterModel.lastChapterId = lastReadChapterModel.chapterId;
            lastReadChapterModel.nextChapterId = readChapterModel.chapterId;
            
            /// 将章节进行分页并进行本地存储
            if (index + 1 == results.count) {
                [readChapterModel updateFontIsSave:YES];
            }
            if ([lastReadChapterModel.content isNotBlank]) {
                [lastReadChapterModel updateFontIsSave:YES];
            }
            
            /// 添加章节列表模型
            [readChapterListModels addObject:[self getReadChapterListModel:readChapterModel]];

            
            lastReadChapterModel = readChapterModel;
            lastRange = rang;
            
        }];
    } else {
        XXReadChapterModel *readChapterModel = [XXReadChapterModel new];
        readChapterModel.bookName = bookName;
        readChapterModel.chapterId = @"1";
        readChapterModel.chapterName = @"开始";
        [readChapterListModels addObject:[self getReadChapterListModel:readChapterModel]];
    }
    
    return [NSArray arrayWithArray:readChapterListModels];
}

+ (XXReadChapterListModel *)getReadChapterListModel:(XXReadChapterModel *)readChapterModel {
    XXReadChapterListModel *readChapterListModel = [XXReadChapterListModel new];
    readChapterListModel.bookName = readChapterModel.bookName;
    readChapterListModel.chapterId = readChapterModel.chapterId;
    readChapterListModel.chapterName = readChapterModel.chapterName;
    return readChapterListModel;
}

#pragma mark -
#pragma mark - -- URL 解码
/**
 URL 解码
 
 @param url 文件路径
 @return 解码后的文本内容
 */
+ (NSString *)encodeWithURL:(NSURL *)url {
    
    /// 判断url路径是否为空
    NSAssert(url != nil, @" NSAssert ---- url 文件路径为空 ----");
    if (!url) {
        return @"";
    }
    
    /// NSUTF8StringEncoding 解析
    NSString *content = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    /// 进制编码解析
    if (!content) {
        content = [NSString stringWithContentsOfURL:url encoding:0x80000632 error:nil];
    }
    if (!content) {
        content = [NSString stringWithContentsOfURL:url encoding:0x80000631 error:nil];
    }
    if (!content) {
        return @"";
    }
    return content;
}

/**
 内容排版整理
 对内容进行整理排版 比如去掉多余的空格或者段头留2格等等
 @param content 章节内容
 @return 整理后内容
 */
+ (NSString *)contentTypesettingContent:(NSString *)content {
    // 替换单换行
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    // 替换换行 以及 多个换行 为 换行加空格
    content = [content replacingPattern:@"\\s*\\n+\\s*" template:@"\n　　"];
    
    // 返回处理后的内容
    return content;
}

+ (NSString *)readKeyedArchiverBookName:(NSString *)bookName {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    cachePath = [NSString stringWithFormat:@""];
    return cachePath;
}

@end
