//
//  ZYCategoryScrollView.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/12.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYCategoryScrollView : UIView
@property (nonatomic,strong)NSMutableArray *items;
@property (nonatomic,assign)float categoryViewHeight;
@property (nonatomic,assign)int defaultIdx;
@end

@interface ZYCategoryScrollViewItem : NSObject
//+ (instancetype)alloc UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)copy UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithTitle:(NSString *)title andViewName:(NSString *) viewName;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *viewName;
@end
