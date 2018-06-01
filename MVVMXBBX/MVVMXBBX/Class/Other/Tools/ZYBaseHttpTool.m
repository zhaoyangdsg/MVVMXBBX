//
//  ZYBaseHttpTool.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/1.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYBaseHttpTool.h"

@implementation ZYBaseHttpTool

+ (instancetype)shareTool {
    static ZYBaseHttpTool* tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[ZYBaseHttpTool alloc]init];
    });
    return tool;
}

@end
