//
//  ZYSharedable.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/1.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZYSharedable <NSObject>
@required
+ (instancetype)shareInstance;
@end
