//
//  XXReadChapterListModel.h
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.

/****************    章节列表模型   ****************/

#import <Foundation/Foundation.h>

/**
 章节列表模型
 */
@interface XXReadChapterListModel : NSObject <NSCoding>

/**
 名称
 */
@property (nonatomic, copy) NSString *bookName;

/**
 章节id
 */
@property (nonatomic, copy) NSString *chapterId;

/**
 章节名称
 */
@property (nonatomic, copy) NSString *chapterName;




@end
