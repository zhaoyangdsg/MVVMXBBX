//
//  ZYProfileHeaderViewModel.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/5/18.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYProfileHeaderViewModel : NSObject
@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *level;
@property(nonatomic,copy)NSString *name;
- (instancetype)initWithUser;
@end
