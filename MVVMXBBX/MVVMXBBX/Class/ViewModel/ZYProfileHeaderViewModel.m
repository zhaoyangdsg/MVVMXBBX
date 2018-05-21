//
//  ZYProfileHeaderViewModel.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/5/18.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYProfileHeaderViewModel.h"

@implementation ZYProfileHeaderViewModel

- (instancetype)initWithUser {
    if (self = [super init]) {
        self.avatar = @"image.xiaobaibao.com/xxxx.jpg";
        int level = 1;
        if (level==1) {
            self.level = @"小白达人";
        }else {
            self.level = @"未认证";
        }
        self.name = @"姓名";
    }
    return self;
}
@end
