//
//  ZYLogViewModel.m
//  MVVMXBBX
//
//  Created by me2 on 2018/5/10.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYLogViewModel.h"
#import "ZYProfileHeaderViewModel.h"
#import "ZYProfileHttpTool.h"
#import "ZYUserItem.h"
#import "ZYUserTool.h"
@interface ZYLogViewModel ()
//- (void)setIsEnable:(Boolean)isEnable;
@end
@implementation ZYLogViewModel

- (instancetype)init {
    
    if (self=[super init]) {
        //        [self addObserver:self forKeyPath:@"user" options:NSKeyValueObservingOptionNew context:nil];
        //        [self addObserver:self forKeyPath:@"pwd" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    
}

- (void)checkUserPwd {
    if (self.pwd.length >= 6 && self.user.length == 11 ) {
        self.isEnable = true;
    }else {
        self.isEnable = false;
    }
}
- (void)setIsLogging:(Boolean)isLogging {
    _isLogging = isLogging;
}

- (void)setIsEnable:(Boolean)isEnable {
    _isEnable = isEnable;
}

- (void)goLogInSuccess:(void(^)(id))successBlk fail:(void(^)(id))failBlk {
    // 访问网络
    NSLog(@"访问登录接口");
    [self setIsLogging:YES];
    [ZYProfileHttpTool.shareInstance loginWithUser:self.user password:self.pwd successHandler:^(id user) {
        NSLog(@"%@",user);
        [self setIsLogging:NO];
        if (user) {
            [[ZYUserTool shareInstance]saveUser:user];
            ZYProfileHeaderViewModel *model = [[ZYProfileHeaderViewModel alloc]initWithUser:user];
            successBlk(model);
        }else {
            failBlk(@"用户获取失败");
        }
        
    } failureHandler:^(id error) {
        NSLog(@"%@",error);
        [self setIsLogging:NO];
        failBlk(error);
    }];
    
}
- (void)setUser:(NSString *)user {
    _user = user;
    [self checkUserPwd];
}

- (void)setPwd:(NSString *)pwd {
    _pwd = pwd;
    [self checkUserPwd];
}


@end
