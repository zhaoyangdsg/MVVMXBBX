//
//  ZYCategoryScrollView.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/12.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYCategoryScrollView.h"

@interface ZYCategoryScrollView()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIScrollView *categoryView;
@property (nonatomic,strong) NSMutableArray *titleAry;
@property (nonatomic,strong) NSMutableArray *viewNameAry;
@end

@implementation ZYCategoryScrollView


- (instancetype)init {
    if (self = [super init]) {
        [self setupSubview];
    }
    return self;
}
- (void)setupSubview {
    [self setupItems];
    [self setupCategoryView];
    [self setupScrollView];
}

- (void)setupItems {
    for (ZYCategoryScrollViewItem *item in self.items) {
        if (item) {
            [self.titleAry addObject:item.title];
            [self.viewNameAry addObject:item.viewName];
        }
    }
}

- (void)setupCategoryView {
    [self addSubview:self.categoryView];
    if (self.titleAry.count <= 5) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
    }
}

- (void)setupScrollView {
    [self addSubview:self.scrollView];
    
}
- (UIScrollView *)scrollView {
    UIScrollView *view = [[UIScrollView alloc]init];
    _scrollView = view;
    return view;
}
- (UIScrollView *)categoryView {
    UIScrollView *view = [[UIScrollView alloc]init];
    _categoryView = view;
    return view;
}
@end



@implementation ZYCategoryScrollViewItem
- (instancetype)initWithTitle:(NSString *)title andViewName:(NSString *) viewName {
    if (self = [super init]) {
        self.title = title;
        self.viewName = viewName;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}


@end
