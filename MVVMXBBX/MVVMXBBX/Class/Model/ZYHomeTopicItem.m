//
//  ZYHomeTopicItem.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/4.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomeTopicItem.h"

@implementation ZYHomeTopicItem
+ (void)initialize {
    [ZYHomeTopicItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"pdtId":@"id"};
    }];
}
@end
