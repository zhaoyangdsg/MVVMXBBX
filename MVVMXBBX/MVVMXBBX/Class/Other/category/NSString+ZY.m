//
//  NSString+ZY.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/6/6.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "NSString+ZY.h"

@implementation NSString (ZY)
- (NSString *)documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask , YES)[0] stringByAppendingPathComponent:self ];
}

- (NSString *)tempPath {
    return  [NSTemporaryDirectory() stringByAppendingPathComponent:self];
}

- (NSString *)cachePath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:self];
}

- (NSString *)libPath {
     return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:self];
}
@end
