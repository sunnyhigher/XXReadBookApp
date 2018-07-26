//
//  XXReadManager.h
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXReadRecordModel.h"
#import "XXReadChapterListModel.h"

typedef  NS_ENUM(NSInteger,XXFileFormatType){
    XXFileFormatTypeTxt,
    XXFileFormatTypeEpub
};

/**
 阅读模型
 总模型，用于记录当前文件阅读的各项数据
 */
@interface XXReadModel : NSObject

/// 小说名称
@property (nonatomic, copy) NSString *bookName;


/**
 章节列表数组，用于存储章节目录，不包含章节内容
 */
@property (nonatomic, strong) NSArray <XXReadChapterListModel *> *readChapterListModels;

/**
 阅读记录模型
 */
@property (nonatomic, strong) XXReadRecordModel *readRecordModel;

/// 类方法，获取阅读模型
+ (instancetype)readModelBookName:(NSString *)bookName;

+ (Boolean)isExistReadModel:(NSString *)bookName;

- (XXReadChapterListModel *)getReadChapterListModel:(NSString *)chapterID;

- (void)save;


@end
