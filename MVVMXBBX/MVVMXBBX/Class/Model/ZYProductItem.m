//
//  ZYProductItem.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/12.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYProductItem.h"

@implementation ZYProductItem
+ (void)initialize {
    [ZYProductItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"pdtId":@"id"};
    }];
    
    [ZYProductItem mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"ensureShowList":@"ZYProductEnsureItem"};
    }];
    
}
@end

@implementation ZYProductEnsureItem

@end

