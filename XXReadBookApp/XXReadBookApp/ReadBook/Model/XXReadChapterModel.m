//
//  XXReadChapterModel.m
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import "XXReadChapterModel.h"
#import "XXReadConfig.h"
#import "XXReadParserManager.h"
#import "XXReadUtilites.h"

@implementation XXReadChapterModel

MJCodingImplementation

- (void)updateFontIsSave:(Boolean)isSave {
    
    NSDictionary *readAttribute = [[XXReadConfig shareInstance] readAttribute];
    self.contentPageRangArray = [XXReadParserManager parserPageRangeString:self.content attrs:readAttribute];
    self.contentPageCount = [NSNumber numberWithInteger:self.contentPageRangArray.count];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (isSave) {
            [self save];
        }
    });
}


- (void)save {
    PINCache *cache = [[PINCache alloc] initWithName:self.bookName rootPath:[XXReadUtilites readKeyedArchiverBookName:self.bookName]];
    [cache setObject:self forKey:self.chapterId];
//    NSLog(@"%@成功", self.chapterId);
}

+ (instancetype)readChapterModelBookName:(NSString *)bookName chapterId:(NSString *)chapterId {
    
    PINCache *cache = [[PINCache alloc] initWithName:bookName rootPath:[XXReadUtilites readKeyedArchiverBookName:bookName]];
    XXReadChapterModel *readChapterModel = [XXReadChapterModel new];
    /// 通过书名 章节ID 获得阅读章节 没有则创建传出
    if ([cache containsObjectForKey:chapterId]) {
        readChapterModel = (XXReadChapterModel *)[cache objectForKey:chapterId];
        [readChapterModel updateFontIsSave:YES];
    } else {
        readChapterModel.bookName = bookName;
        readChapterModel.chapterId = chapterId;
    }
    return readChapterModel;
}

- (XXCustomMankRange *)customMankRange:(XXCustomMankRange *)lastMankRange {
    for (XXCustomMankRange *makeRange in self.contentPageRangArray) {
        if (lastMankRange.location < (makeRange.location + makeRange.length)) {
            return makeRange;
        }
    }
    return [self.contentPageRangArray firstObject];
}

@end
