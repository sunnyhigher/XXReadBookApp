//
//  XXReadChapterModel.h
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

/****************    阅读章节模型   ****************/

#import <Foundation/Foundation.h>

@interface XXReadChapterModel : NSObject

/**
 名称
 */
@property (nonatomic, copy) NSString *bookName;


/**
 章节名称
 */
@property (nonatomic, copy) NSString *chapterName;

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
@property (nonatomic) NSRange contentPageRangArray;


/**
 上一章章节名称
 */
@property (nonatomic, copy) NSString *lastChapterName;


/**
 下一章章节名称
 */
@property (nonatomic, copy) NSString *nextChapterName;




@end














































































































