//
//  ViewController.m
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/6/8.
//  Copyright © 2018 段新瑞. All rights reserved.
//

#import "ViewController.h"
#import "XXReadParserManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)readClick:(id)sender {
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"《师士传说》" withExtension:@"txt"];
    [XXReadParserManager parserLocalModelWithURL:fileURL
                               readParserModel:^(XXReadModel *model){
                                   NSLog(@"%@", model);
                               }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
