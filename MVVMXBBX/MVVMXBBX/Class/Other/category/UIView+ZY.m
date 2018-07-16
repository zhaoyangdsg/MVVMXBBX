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
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x {
    return  self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint cent = self.center;
    cent.x = centerX;
    self.center = cent;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint cent = self.center;
    cent.y = centerY;
    self.center = cent;
}
- (CGFloat)centerY {
    return self.center.y;
}
@end
