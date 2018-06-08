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

@end
