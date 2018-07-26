//
//  XXReadUtilites.h
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXReadChapterListModel.h"

@interface XXReadUtilites : NSObject

/**
 获取文件名称
 
 @param url 文件路径
 @return 文件名称
 */
+ (NSString *)getFileName:(NSURL *)url;


/**
 获取章节列表模型

 @param bookName 小说名称
 @param content 小说内容
 @return 章节模型列表
 */
+ (NSArray <XXReadChapterListModel *> *)separateChapterListsBookName:(NSString *)bookName content:(NSString *)content;


/**
 URL 解码
 
 @param url 文件路径
 @return 解码后的文本内容
 */
+ (NSString *)encodeWithURL:(NSURL *)url;


/**
 内容排版整理
 对内容进行整理排版 比如去掉多余的空格或者段头留2格等等
 @param content 章节内容
 @return 整理后内容
 */
+ (NSString *)contentTypesettingContent:(NSString *)content;

/// 获取路径
+ (NSString *)readKeyedArchiverBookName:(NSString *)bookName;

@end
