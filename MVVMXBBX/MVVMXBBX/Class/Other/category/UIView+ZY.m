//
//  UIView+ZY.m
//  MVVMXBBX
//
//  Created by 扬扬 on 2018/5/14.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "UIView+ZY.h"

@implementation UIView (ZY)
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width {
    return  self.frame.size.width;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height {
    return  self.frame.size.height;
}

@end
