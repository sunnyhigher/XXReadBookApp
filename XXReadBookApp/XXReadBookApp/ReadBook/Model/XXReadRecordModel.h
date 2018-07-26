//
//  XXReadRecordModel.h
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

/****************    阅读记录   ****************/

#import <Foundation/Foundation.h>
#import "XXReadChapterModel.h"
#import "XXCustomMankRange.h"
@interface XXReadRecordModel : NSObject <NSCoding>

/**
 小说名称
 */
@property (nonatomic, copy) NSString *bookName;

/**
 当前阅读模型
 */
@property (nonatomic, strong) XXReadChapterModel *readChapterModel;

/**
 当前章节阅读到的初始location
 */
@property (nonatomic, strong) XXCustomMankRange *customMankRangeModel;

/// 通过书名 获得阅读记录模型 没有则进行创建传出
+ (instancetype)readRecordModelBookName:(NSString *)bookName isUpdateFont:(Boolean)isUpdateFont isSave:(Boolean)isSave;

- (void)modifyChapterID:(NSString *)chapterID updateFont:(Boolean)isUpdateFont save:(Boolean)isSave;

@end
