//
//  NSNumber+ZY.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/28.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "NSNumber+ZY.h"

@implementation NSNumber (ZY)
- (NSString *)keep2String {
    return  [NSString stringWithFormat:@"%.2f", self.doubleValue];
}
@end
