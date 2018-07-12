//
//  ZYHomeItem.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/5.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomeItem.h"

@implementation ZYHomeItem
+ (void)initialize {
    // 设置数组属性的model
    [ZYHomeItem mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"featureList":@"ZYHomeTopicItem",
                 @"recommend":@"ZYHomeProductItem",
                 @"result":@"ZYHomeAdItem"
                 };
    }];
}
@end
