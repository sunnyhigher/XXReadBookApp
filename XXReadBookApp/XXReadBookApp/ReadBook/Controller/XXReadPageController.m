//
//  XXReadPageController.m
//  XXReadBookApp
//
//  Created by 段新瑞 on 2018/8/1.
//  Copyright © 2018年 段新瑞. All rights reserved.
//

#import "XXReadPageController.h"

@interface XXReadPageController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;

@end

@implementation XXReadPageController


#pragma mark -
#pragma mark -- life cycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark -
#pragma mark -- UIPageViewControllerDelegate


#pragma mark -
#pragma mark -- CustomDelegate


#pragma mark -
#pragma mark -- event reponse


#pragma mark -
#pragma mark -- private methods


#pragma mark -
#pragma mark -- getters and setters
-(UIPageViewController *)pageViewController {
    
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}

@end
