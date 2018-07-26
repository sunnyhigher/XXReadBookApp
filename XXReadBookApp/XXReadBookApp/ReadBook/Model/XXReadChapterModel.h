//
//  XXReadChapterModel.h
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

/****************    阅读章节模型   ****************/

#import <Foundation/Foundation.h>

@class XXCustomMankRange;
@interface XXReadChapterModel : NSObject <NSCoding> 

/**
 名称
 */
@property (nonatomic, copy) NSString *bookName;


/**
 章节名称
 */
@property (nonatomic, copy) NSString *chapterName;

/**
 章节id
 */
@property (nonatomic, copy) NSString *chapterId;

/**
 本章内容
 */
@property (nonatomic, copy) NSString *content;


/**
 本章共有多少页(需要通过字号字体间距等计算得出)
 */
@property (nonatomic, strong) NSNumber *contentPageCount;


/**
 每页的 Rang 数组(需通过字号字体间距等计算得出)
 */
@property (nonatomic, strong) NSArray <XXCustomMankRange *> *contentPageRangArray;


/**
 上一章章节名称
 */
@property (nonatomic, copy) NSString *lastChapterName;


/**
 下一章章节名称
 */
@property (nonatomic, copy) NSString *nextChapterName;


/**
 上一章章节id
 */
@property (nonatomic, copy) NSString *lastChapterId;


/**
 下一章章节id
 */
@property (nonatomic, copy) NSString *nextChapterId;

- (void)save;

+ (instancetype)readChapterModelBookName:(NSString *)bookName chapterId:(NSString *)chapterId;

/// 更新字号并保存
- (void)updateFontIsSave:(Boolean)isSave;

/// 阅读页数
- (XXCustomMankRange *)customMankRange:(XXCustomMankRange *)lastMankRange;



@end














































































































