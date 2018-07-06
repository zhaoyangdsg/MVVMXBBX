//
//  ZYHomeItem.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/5.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYHomeItem : NSObject
/// 专题
@property (nonatomic,strong) NSArray *featureList;
/// 推荐产品
@property (nonatomic,strong) NSArray *recommend;
/// 轮播图
@property (nonatomic,strong) NSArray *result;
@end
