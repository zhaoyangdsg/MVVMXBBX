//
//  UIImage+ZY.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/5/18.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "UIImage+ZY.h"

@implementation UIImage (ZY)
+ (UIImage *)imageWithUrlStr:(NSString *)str {
    
    NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:str]];
    if (data) {
       return [UIImage imageWithData:data];
    }else {
        return [UIImage imageNamed:@"placeHolder"];
    }
}
@end
