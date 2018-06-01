//
//  UIViewController+ZY.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/5/18.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "UIViewController+ZY.h"

@implementation UIViewController (ZY)
    - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
        [self.view endEditing:true];
    }
@end
