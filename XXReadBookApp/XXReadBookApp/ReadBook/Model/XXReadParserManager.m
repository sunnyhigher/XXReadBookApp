//
//  XXReadParserManager.m
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import "XXReadParserManager.h"
#import "XXReadUtilites.h"
#import "XXReadChapterListModel.h"

@interface XXReadParserManager ()

@end

@implementation XXReadParserManager

+ (void)parserLocalModelWithURL:(NSURL *)url readParserModel:(void (^)(XXReadModel *model))block {
    NSString *content = [XXReadUtilites encodeWithURL:url];
    
    /// 获取书名
    NSString *bookName = [XXReadUtilites getFileName:url];
    XXReadModel *readModel = [XXReadModel new];
    readModel.bookName = bookName;
    
    /// 获取章节目录列表数组
    readModel.readChapterListModels = [XXReadUtilites separateChapterListsBookName:bookName content:content];
    
    
    
    block(readModel);
}

@end
