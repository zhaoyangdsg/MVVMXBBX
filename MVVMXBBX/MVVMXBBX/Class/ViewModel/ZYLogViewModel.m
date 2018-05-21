//
//  ZYLogViewModel.m
//  MVVMXBBX
//
//  Created by me2 on 2018/5/10.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYLogViewModel.h"
#import "ZYProfileHeaderViewModel.h"
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
    
}

- (void)setIsEnable:(Boolean)isEnable {
    NSLog(@"setIsEnable %d",isEnable);
    NSLog(@"%d %d",true,false);
    [self setValue:@(isEnable) forKey:@"_isEnable"];
}

- (void)goLogInSuccess:(void(^)(id))successBlk fail:(void(^)(id))failBlk {
    NSLog(@"user: %@ pwd: %@ ", self.user,self.pwd);
    // 访问网络
    NSLog(@"访问登录接口");
    Boolean isSuccess = true;
    if (isSuccess) {
        ZYProfileHeaderViewModel *model = [[ZYProfileHeaderViewModel alloc]initWithUser];
        
        successBlk(model);
    }else {
        failBlk(@"登录失败,获得失败原因");
    }
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
