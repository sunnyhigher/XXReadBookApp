//
//  XXReadUtilites.m
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import "XXReadUtilites.h"

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
    NSMutableArray <XXReadChapterListModel *> *readChapterListModels = [NSMutableArray new];
    
    NSString *parten = @"第[0-9一二三四五六七八九十百千]*[章回节].*";
    
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:parten options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *results = [regularExpression matchesInString:content options:NSMatchingReportCompletion range:NSMakeRange(0, [content length])];
    
    if (results.count != 0) {
        __block NSRange lastRange = NSMakeRange(0, 0);
        [results enumerateObjectsUsingBlock:^(NSTextCheckingResult *object, NSUInteger index, BOOL * _Nonnull stop) {
            NSRange rang = [object range];
            // NSUInteger location = rang.location;
            XXReadChapterListModel *readChapterModel = [XXReadChapterListModel new];
            
            /// 开始
            if (index == 0) {
                readChapterModel.bookName = bookName;
                readChapterModel.chapterId = [NSNumber numberWithInteger:index + 1];
                readChapterModel.chapterName = @"开始";
            } else if (index == results.count - 1) { /// 最后一章
                readChapterModel.bookName = bookName;
                readChapterModel.chapterId = [NSNumber numberWithInteger:index + 1];
                readChapterModel.chapterName = [content substringWithRange:rang];
            } else { /// 中间章节
                readChapterModel.bookName = bookName;
                readChapterModel.chapterId = [NSNumber numberWithInteger:index + 1];
                readChapterModel.chapterName = [content substringWithRange:lastRange];
            }
            
            [readChapterListModels addObject:readChapterModel];
            lastRange = rang;
        }];
    } else {
        XXReadChapterListModel *readChapterModel = [XXReadChapterListModel new];
        readChapterModel.bookName = bookName;
        readChapterModel.chapterId = @(1);
        readChapterModel.chapterName = @"开始";
        [readChapterListModels addObject:readChapterModel];
    }
    
    return [NSArray arrayWithArray:readChapterListModels];
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

@end
