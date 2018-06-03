//
//  NSURLResponse+ZY.m
//  MVVMXBBX
//
//  Created by 扬扬 on 2018/6/3.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "NSURLResponse+ZY.h"
#import <objc/runtime.h>
@implementation NSURLResponse (ZY)
- (void)setData:(NSData *)data {
    objc_setAssociatedObject(self, @"data", data, 1);
}
- (NSData *)data {
    return objc_getAssociatedObject(self, @"data");
}

- (void)setError:(NSError *)error {
    objc_setAssociatedObject(self, @"error", error, 1);
}
- (NSError *)error {
    return  objc_getAssociatedObject(self, @"error");
}
@end
