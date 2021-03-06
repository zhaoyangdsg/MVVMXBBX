//
//  ZYLogViewModel.h
//  MVVMXBBX
//
//  Created by me2 on 2018/5/10.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^blk)(id)  ;
@interface ZYLogViewModel : NSObject
@property(nonatomic,copy,readwrite) NSString *user;
@property(nonatomic,copy,readwrite) NSString *pwd;
@property(nonatomic,readonly,assign) Boolean isLogging;
@property(nonatomic,readonly,assign) Boolean isEnable;
- (void)goLogInSuccess:(void(^)(id))successBlk fail:(void(^)(id))failBlk;
@end
