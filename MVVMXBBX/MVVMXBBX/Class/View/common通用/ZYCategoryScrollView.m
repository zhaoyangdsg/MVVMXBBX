//
//  ZYCategoryScrollView.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/12.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYCategoryScrollView.h"
#import "objc/runtime.h"

static const float kBtmLineWidth = 15;
static const float kBtmLineHeight = 2;

@interface ZYCategoryScrollView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIScrollView *categoryView;
@property (nonatomic,strong) NSMutableArray<NSString *> *titleAry;
@property (nonatomic,strong) NSMutableArray *viewNameAry;
@property (nonatomic,strong) NSMutableArray<UIButton *> *btnAry;
@property (nonatomic,strong) NSMutableArray<UIView *> *viewAry;
@property (nonatomic,assign) int currentIdx;
@property (nonatomic,assign) float scrollViewWidth;
@property (nonatomic,assign) float categoryBtnWidth;
@property (nonatomic,weak) UIView *btmLine;

@end


@implementation ZYCategoryScrollView

- (instancetype)init {
    if (self = [super init]) {
        self.titleAry = [NSMutableArray array];
        self.viewNameAry = [NSMutableArray array];
        self.btnAry = [NSMutableArray array];
        self.currentIdx = 0;
    }
    return self;
}

- (void)layoutSubviews {
    [self setupSubview];
}
- (void)setupSubview {
    [self setupItems];
    [self setupCategoryView];
    [self setupScrollView];
    // 初始化设置
    [self setupDefaultData];
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
    // 默认高度
    if (self.categoryViewHeight == 0) {
        self.categoryViewHeight = 40;
    }
    
    self.categoryView.backgroundColor = UIColor.whiteColor;
    self.categoryView.frame = CGRectMake(0, 0, self.frame.size.width, self.categoryViewHeight);
    [self addSubview:self.categoryView];
    
    float width,height,x,y;
    height = self.categoryView.height;
    y = 0;
    
    if (self.titleAry.count <= 5) {
        width = self.categoryView.width / self.titleAry.count;
    }else {
        width = self.categoryView.width / 5;
    }
    _categoryBtnWidth = width;
    for (int i = 0; i<self.titleAry.count; i++) {
        x = i * width;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, width, height);
        
        NSMutableAttributedString *normalAttbtStr = [[NSMutableAttributedString alloc]initWithString:self.titleAry[i]];
        [normalAttbtStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, _titleAry[i].length)];
        [normalAttbtStr addAttribute:NSForegroundColorAttributeName value:UIColor.grayColor range:NSMakeRange(0,self.titleAry[i].length)];
        [btn setAttributedTitle:normalAttbtStr forState:UIControlStateNormal];
        
        NSAttributedString *selectedAttbtStr =
        [[NSAttributedString alloc]initWithString:self.titleAry[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightBold],
                                                                                NSForegroundColorAttributeName:UIColor.redColor}];
        [btn setAttributedTitle:selectedAttbtStr forState:UIControlStateSelected];
        
        [self.categoryView addSubview:btn];
        [self.btnAry addObject:btn];
    }
    self.categoryView.contentSize = CGSizeMake(width*self.titleAry.count, 0);
    
    // 添加下划线
    [self setupBottomLine];
}

- (void)setupBottomLine {
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.redColor;
    view.frame = CGRectMake(0, self.categoryView.height-kBtmLineHeight, kBtmLineWidth, kBtmLineHeight);
    view.hidden = YES;
    _btmLine = view;
    [self.categoryView addSubview:_btmLine];
}

- (void)setupScrollView {
    [self addSubview:self.scrollView];
    self.scrollView.backgroundColor = UIColor.redColor;
    self.scrollView.frame = CGRectMake(0, self.categoryViewHeight, self.width, (self.height-self.categoryViewHeight));
    self.scrollView.contentSize = CGSizeMake(self.viewNameAry.count*self.scrollView.width, 0);
    // 用于监听手势时,渐变的标准距离
    _scrollViewWidth = self.width;
}

- (void)setupDefaultData {
    // _defaultIdx 默认为0
    _currentIdx = _defaultIdx;
    [self hand_moveViewPositionWithIdx:_defaultIdx];
}

// 根据index 初始化并添加view
- (void)setUpScrollViewWithIdx:(int) idx {
 
    // 如果已经加入 return
    if (self.viewAry[idx] && [self.viewAry[idx] isKindOfClass:UIView.class]) {
        return;
    }
    // 没有加入view 添加
    float x,y,width,height;
    y = 0;
    width = self.scrollView.width;
    height = self.scrollView.height;
    x = idx*width;
    NSString *viewName = self.viewNameAry[idx];
    UIView *view;
    if (viewName) {
        id viewClass = [[NSClassFromString(viewName) alloc ]init];
        
        // 拿到class
        if (viewClass) {
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
            
        }else { // 没拿到class
            view = [UIView new];
            view.backgroundColor = UIColor.whiteColor;
        }
    }else {
        view = [UIView new];
        view.backgroundColor = UIColor.whiteColor;
    }
    [self.scrollView addSubview:view];
    // 添加view 到相应的index
    [self.viewAry setObject:view atIndexedSubscript:idx];
}

// 根据index 设置当前显示的view 和 btn.selected
- (void)moveViewPositionWithIdx:(int)idx {
    // 设置选中的btn
    UIButton *btn = self.btnAry[idx];
    // 如果已经选中 则return
    if (btn.isSelected) {
        return;
    }else { // 否则 设置btn.selected 并且加载view
        for (UIButton *bt in _btnAry) {
            bt.selected = NO;
        }
        btn.selected = YES;
    }
    
    // 如果btn在屏幕外,移动categoryView,让btn显示在最后一个
    if (idx*_categoryBtnWidth > self.categoryView.width ) {
        [UIView animateWithDuration:0.5 animations:^{
            self.categoryView.contentOffset = CGPointMake(idx*_categoryBtnWidth - self.categoryView.width, 0);
        } ];
    }
    
    // 添加view
    [self setUpScrollViewWithIdx:idx];
    
}

// 通过设置index触发
- (void)hand_moveViewPositionWithIdx:(int)idx {
    [self moveViewPositionWithIdx:idx];
    // 让scrollView 移动到相应位置
    self.scrollView.contentOffset = CGPointMake(idx * self.scrollView.width,0 ) ;
    
    [self setBtmLinePositionWith:idx];
}

// 根据index 设置btnLine的位置 frame
- (void)setBtmLinePositionWith:(int)idx {
    // line的x
    self.btmLine.hidden = NO;
    float lineX = self.categoryBtnWidth * idx + (self.categoryBtnWidth - kBtmLineWidth)/2;
    self.btmLine.frame = CGRectMake(lineX, self.categoryView.height-kBtmLineHeight, kBtmLineWidth, kBtmLineHeight);
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *view = [[UIScrollView alloc]init];
        view.pagingEnabled = YES;
        view.delegate = self;
        view.bounces = NO;
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
    
}

// scrollview减速结束后
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 移动scrollView
    // 减速后 当前的index
    _currentIdx = fabs(scrollView.contentOffset.x)/scrollView.width;
    
    // 设置btmLine 的frame
    [self setBtmLinePositionWith:_currentIdx];
   // 滑动触发添加view 移动view
    [self moveViewPositionWithIdx:_currentIdx];
}



// 拖拽时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offsetX = scrollView.contentOffset.x;
    NSLog(@"%f",offsetX);
    float btmLineLength = (offsetX-_currentIdx*self.scrollView.width)/self.scrollView.width * self.categoryBtnWidth ;
    NSLog(@"%f",btmLineLength);
    if (btmLineLength > 0) {
        self.btmLine.width = kBtmLineWidth + btmLineLength;
        UIButton *btn = self.btnAry[_currentIdx+1];
        if (btn) {
            // r1: normal颜色 r2: select颜色
            // 选中颜色: select->normal : normal-select
            // 将被选中颜色: normal->select : select-normal
            CGFloat r1,g1,b1,a1,r2,g2,b2,a2,r3,g3,b3,a3;
            [UIColor.grayColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
            [UIColor.redColor getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
            UIColor *cur_color = [UIColor colorWithRed:(r1-r2) green:(g1-g2) blue:(b1-b2) alpha:(a1-a2)];
            UIColor *next_color = [UIColor colorWithRed:(r2-r1) green:(g2-g1) blue:(b2-b1) alpha:(a2-a1)];
            [btn setTitleColor:next_color forState:UIControlStateNormal];
            [self.btnAry[_currentIdx] setTitleColor:cur_color forState:UIControlStateSelected];
        }
    }else if (btmLineLength < 0) {
        float lineX = self.categoryBtnWidth * _currentIdx + (self.categoryBtnWidth - kBtmLineWidth)/2;
        self.btmLine.x = lineX + btmLineLength;
        self.btmLine.width = kBtmLineWidth - btmLineLength;
    }else {
        [self setBtmLinePositionWith:_currentIdx];
    }
    // 动态 修改btmLine的长度
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
