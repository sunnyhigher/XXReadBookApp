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
@interface XXReadRecordModel : NSObject

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
@property (nonatomic, strong) NSNumber *location;

@end
