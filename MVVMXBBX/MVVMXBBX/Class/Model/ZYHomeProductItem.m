//
//  ZYHomeProductItem.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/4.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomeProductItem.h"

@implementation ZYHomeProductItem
+ (void)initialize {
    [ZYHomeProductItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"pdtId":@"id"};
    }]; 
}
@end
