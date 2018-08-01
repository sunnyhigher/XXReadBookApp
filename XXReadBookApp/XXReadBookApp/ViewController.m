//
//  ViewController.m
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import "ViewController.h"
#import "XXReadParserManager.h"
#import "XXReadChapterModel.h"
#import "XXReadUtilites.h"

#import "XXReadPageController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)readClick:(id)sender {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"《师士传说》" withExtension:@"txt"];
    [XXReadParserManager parserLocalModelWithURL:fileURL
                               readParserModel:^(XXReadModel *model){
                                   NSLog(@"%@", [model mj_JSONString]);
                                   XXReadPageController *controller = [XXReadPageController new];
                                   controller.readModel = model;
                                   [self.navigationController pushViewController:controller animated:YES];
                               }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
