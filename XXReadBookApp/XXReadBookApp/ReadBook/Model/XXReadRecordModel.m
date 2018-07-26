//
//  XXReadRecordModel.m
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import "XXReadRecordModel.h"

@implementation XXReadRecordModel

MJCodingImplementation

+ (instancetype)readRecordModelBookName:(NSString *)bookName isUpdateFont:(Boolean)isUpdateFont isSave:(Boolean)isSave {
    XXReadRecordModel *readRecordModel = [XXReadRecordModel new];
    PINCache *cache = [[PINCache alloc] initWithName:bookName rootPath:[XXReadUtilites readKeyedArchiverBookName:bookName]];
    if ([cache containsObjectForKey:NSStringFromClass([self class])]) {
        readRecordModel = [cache objectForKey:NSStringFromClass([self class])];
        [readRecordModel updateFont:isSave];
        
    } else {
        readRecordModel.bookName = bookName;
    }
    
    return readRecordModel;
}

- (void)save {
    PINCache *cache = [[PINCache alloc] initWithName:self.bookName rootPath:[XXReadUtilites readKeyedArchiverBookName:self.bookName]];
    [cache setObject:self forKey:NSStringFromClass([self class])];
}

- (void)updateFont:(Boolean)isSave {
    [self.readChapterModel updateFontIsSave:YES];
    self.customMankRangeModel = [self.readChapterModel customMankRange:self.customMankRangeModel];
    if (isSave) {
        [self save];
    }
}

- (void)modifyChapterID:(NSString *)chapterID updateFont:(Boolean)isUpdateFont save:(Boolean)isSave {
    PINCache *cache = [[PINCache alloc] initWithName:self.bookName rootPath:[XXReadUtilites readKeyedArchiverBookName:self.bookName]];
    if ([cache containsObjectForKey:chapterID]) {
        self.readChapterModel = [XXReadChapterModel readChapterModelBookName:self.bookName chapterId:chapterID];
        if (isSave) {
            [self save];
        }
    } else {
        [self modifyChapterID:chapterID updateFont:isUpdateFont save:isSave];
    }
}

@end
