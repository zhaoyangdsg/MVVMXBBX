//
//  ZYBaseHttpTool.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/1.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYBaseHttpTool.h"
//#import <objc/runtime.h>


@implementation ZYBaseHttpTool
static ZYBaseHttpTool* _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    
    return _instance;
}

+ (instancetype)shareTool {
    return  [[self alloc]init];
}

- (id)copy {
    return _instance;
}


- (id)mutableCopy {
    return _instance;
}



@end
