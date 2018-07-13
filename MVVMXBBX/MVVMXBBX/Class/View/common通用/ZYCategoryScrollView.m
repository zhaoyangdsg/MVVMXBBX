//
//  ZYCategoryScrollView.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/12.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYCategoryScrollView.h"
#import "objc/runtime.h"

@interface ZYCategoryScrollView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIScrollView *categoryView;
@property (nonatomic,strong) NSMutableArray *titleAry;
@property (nonatomic,strong) NSMutableArray *viewNameAry;
@property (nonatomic,strong) NSMutableArray *btnAry;
@property (nonatomic,assign) int currentIdx;
@end

@implementation ZYCategoryScrollView


- (instancetype)init {
    if (self = [super init]) {
//        [self setupSubview];
        self.backgroundColor = UIColor.brownColor;
        self.titleAry = [NSMutableArray array];
        self.viewNameAry = [NSMutableArray array];
        self.btnAry = [NSMutableArray array];
        self.currentIdx = 0;
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
    if (self.categoryPersent == 0) {
        self.categoryPersent = 0.1f;
    }
    
//    self.categoryView.backgroundColor = UIColor.blueColor;
//    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.equalTo(self);
//        make.height.equalTo(self).multipliedBy(self.categoryPersent);
//    }];
    NSLog(@"%f %f",self.frame.size.width,self.frame.size.height) ;
    self.categoryView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*self.categoryPersent);
    [self addSubview:self.categoryView];
    float width,height,x,y;
    height = self.categoryView.height;
    y = 0;
    if (self.titleAry.count <= 5) {
        width = self.categoryView.width / self.titleAry.count;
    }else {
        width = self.categoryView.width / 5;
    }
    for (int i = 0; i<self.titleAry.count; i++) {
        x = i * width;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, width, height);
        [btn setTitle:self.titleAry[i] forState:UIControlStateNormal];
        
        NSAttributedString *normalAttbtStr = [[NSAttributedString alloc]initWithString:self.titleAry[i] attributes:@{@"NSAccessibilityFontTextAttribute":@15,
                                                                   @"NSAccessibilityForegroundColorTextAttribute":UIColor.blackColor}];
        [btn setAttributedTitle:normalAttbtStr forState:UIControlStateNormal];
        NSAttributedString *selectedAttbtStr = [[NSAttributedString alloc]initWithString:self.titleAry[i] attributes:@{@"NSAccessibilityFontTextAttribute":@17,
                                                                   @"NSAccessibilityForegroundColorTextAttribute":UIColor.redColor}];
        [btn setAttributedTitle:selectedAttbtStr forState:UIControlStateSelected];
        
        [self.categoryView addSubview:btn];
        [self.btnAry addObject:btn];
    }
    self.categoryView.contentSize = CGSizeMake(width*self.titleAry.count, 0);
}

- (void)setupScrollView {
    [self addSubview:self.scrollView];
    self.scrollView.backgroundColor = UIColor.redColor;
    self.scrollView.frame = CGRectMake(0, self.height*self.categoryPersent, self.width, self.height*(1-self.categoryPersent));
    self.scrollView.contentSize = CGSizeMake(self.viewNameAry.count*self.scrollView.width, 0);
    float x,y,width,height;
    y = 0;
    width = self.scrollView.width;
    height = self.scrollView.height;
    for (int i = 0;i<self.viewNameAry.count;i++) {
        x = i*width;
        NSString *viewName = self.viewNameAry[i];
        if (viewName) {
            id viewClass = [[NSClassFromString(viewName) alloc ]init];
            // 拿到class
            if (viewClass) {
                UIView *view;
                // class 是view
                if ([viewClass isKindOfClass:UIView.class]) {
                    view = [viewClass new];
                } else if ([viewClass  isKindOfClass:UIViewController.class]) { // class 是controller
                    view = ((UIViewController *)viewClass).view;
                } else { // class 是其他类
                    view = [UIView new];
                    view.backgroundColor = UIColor.whiteColor;
                }
                view.frame = CGRectMake(x, y, width, height);
                [self.scrollView addSubview:view];
            }else { // 没拿到class
                
            }
        }
    }
    
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *view = [[UIScrollView alloc]init];
        view.pagingEnabled = YES;
        view.delegate = self;
        _scrollView = view;
    }
    return _scrollView;
}
- (UIScrollView *)categoryView {
    if (!_categoryView) {
        UIScrollView *view = [[UIScrollView alloc]init];
        view.pagingEnabled = NO;
        _categoryView = view;
    }
    return _categoryView;
}
- (void)setItems:(NSMutableArray *)items {
    _items = items;
    [self setupSubview];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _currentIdx = fabs(scrollView.contentOffset.x)/scrollView.width;
    ((UIButton *)self.btnAry[self.currentIdx]).selected = YES;
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
