//
//  NSURLResponse+ZY.h
//  MVVMXBBX
//
//  Created by 扬扬 on 2018/6/3.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLResponse (ZY)
/** data */
@property (nonatomic,strong)NSData *data;
/** error */
@property (nonatomic,strong)NSError *error;
@end
