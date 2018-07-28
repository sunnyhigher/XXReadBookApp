//
//  XXReadParserManager.m
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import "XXReadParserManager.h"
#import "XXReadUtilites.h"
#import "XXCustomMankRange.h"

@interface XXReadParserManager ()

@end

@implementation XXReadParserManager

+ (void)parserLocalModelWithURL:(NSURL *)url readParserModel:(void (^)(XXReadModel *model))block {
    
    /// 获取文本内容
    NSString *content = [XXReadUtilites encodeWithURL:url];
    
    /// 获取书名
    NSString *bookName = [XXReadUtilites getFileName:url];
    
    /// 阅读总模型
    XXReadModel *readModel = [XXReadModel readModelBookName:bookName];
    
    if (![XXReadModel isExistReadModel:bookName]) {
        readModel.bookName = bookName;
        /// 章节目录
        readModel.readChapterListModels = [XXReadUtilites separateChapterListsBookName:bookName content:content];
        [readModel.readRecordModel modifyChapterID:@"10" updateFont:YES save:YES];
        [readModel save];
    }
    
    block(readModel);
}

+ (NSArray <XXCustomMankRange *> *)parserPageRangeString:(NSString *)string attrs:(NSDictionary *)attrs {
    NSMutableArray *rangeArray = [NSMutableArray new];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string attributes:attrs];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), NULL);
    CFRange range = CFRangeMake(0, 0);
    NSInteger rangeOffset = 0;
    
    BOOL hasMorePages = YES;
    while (hasMorePages) {
        CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(rangeOffset, 0), path, NULL);
        range = CTFrameGetVisibleStringRange(frame);
        XXCustomMankRange *customMankRange = [XXCustomMankRange new];
        customMankRange.location = rangeOffset;
        customMankRange.length = range.length;
        [rangeArray addObject:customMankRange];
        rangeOffset += range.length;
        CFRelease(frame);
        
        if ((range.location + range.length) == attrString.length)  {
            hasMorePages = NO;
        }
    }
    CGPathRelease(path);
    CFRelease(frameSetter);
    return [NSArray arrayWithArray:rangeArray];
}



@end
