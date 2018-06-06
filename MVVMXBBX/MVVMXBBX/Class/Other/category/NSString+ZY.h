//
//  NSString+ZY.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/6.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZY)
/// document 沙盒路径
- (NSString *)documentPath;
/// cache 沙盒路径
- (NSString *)cachePath;
/// library 沙盒路径
- (NSString *)libPath;
/// 临时 沙盒路径
- (NSString *)tempPath;
@end
