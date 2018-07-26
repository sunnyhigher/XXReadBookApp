//
//  XXReadManager.m
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import "XXReadModel.h"
#import "XXReadUtilites.h"
#import "XXReadRecordModel.h"
@interface XXReadModel () <NSCoding>


@end

@implementation XXReadModel
MJCodingImplementation

+ (Boolean)isExistReadModel:(NSString *)bookName {
    PINCache *cache = [[PINCache alloc] initWithName:bookName rootPath:[XXReadUtilites readKeyedArchiverBookName:bookName]];
    return [cache containsObjectForKey:NSStringFromClass([self class])];
}

+ (instancetype)readModelBookName:(NSString *)bookName {
    PINCache *cache = [[PINCache alloc] initWithName:bookName rootPath:[XXReadUtilites readKeyedArchiverBookName:bookName]];
    XXReadModel *readModel = [XXReadModel new];
    /// 通过书名 章节ID 获得阅读章节 没有则创建传出
    if ([cache containsObjectForKey:NSStringFromClass([self class])]) {
        readModel = [cache objectForKey:NSStringFromClass([self class])];
    } else {
        readModel.bookName = bookName;
        
    }
    
    /// 阅读记录，刷新字体
    readModel.readRecordModel = [XXReadRecordModel readRecordModelBookName:bookName isUpdateFont:YES isSave:YES];
    return readModel;
}

- (XXReadChapterListModel *)getReadChapterListModel:(NSString *)chapterID {
    for (XXReadChapterListModel *readChapterListModel in self.readChapterListModels) {
        if ([readChapterListModel.chapterId isEqualToString:chapterID]) {
            return readChapterListModel;
        }
    }
    return nil;
}

- (void)save {
    PINCache *cache = [[PINCache alloc] initWithName:self.bookName rootPath:[XXReadUtilites readKeyedArchiverBookName:self.bookName]];
    [cache setObject:self forKey:NSStringFromClass([self class])];
}



@end
