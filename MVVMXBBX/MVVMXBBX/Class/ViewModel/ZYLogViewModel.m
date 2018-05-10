//
//  ZYLogViewModel.m
//  MVVMXBBX
//
//  Created by me2 on 2018/5/10.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYLogViewModel.h"

@implementation ZYLogViewModel

- (void)goLogInSuccess:(blk)successBlk fail:(blk)failBlk {
    NSLog(@"user: %@ pwd: %@ ", self.user,self.pwd);
    // 访问网络
    NSLog(@"访问登录接口");
    Boolean isSuccess = true;
    if (isSuccess) {
        successBlk(@"登录成功,获得user信息");
    }else {
        failBlk(@"登录失败,获得失败原因");
    }
}
@end
