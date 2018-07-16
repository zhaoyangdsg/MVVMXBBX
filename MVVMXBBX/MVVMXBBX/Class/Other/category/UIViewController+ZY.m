//
//  UIViewController+ZY.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/5/18.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "UIViewController+ZY.h"
#import "objc/runtime.h"
@implementation UIViewController (ZY)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = self.class;
//        objc_setAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>, <#id  _Nullable value#>, <#objc_AssociationPolicy policy#>)
//        [UIViewController new].hidesBottomBarWhenPushed = YES;
//    });
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

//- (bool)hidesBottomBarWhenPushed {
//    return YES;
//}

//- (void)setHidesBottomBarWhenPushed:(bool)hidesBottomBarWhenPushed {
//    objc_setAssociatedObject(self, <#const void * _Nonnull key#>, <#id  _Nullable value#>, <#objc_AssociationPolicy policy#>)
//}

//- (BOOL)isHideTab {
//    
//    if (objc_getAssociatedObject(self, @"isHideTab")) {
//        return (BOOL)objc_getAssociatedObject(self, @"isHideTab");
//    }else {
//        return NO;
//    }
//}
//- (void)setIsHideTab:(BOOL)isHideTab {
////    objc_setAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>, <#id  _Nullable value#>, <#objc_AssociationPolicy policy#>)
//    objc_setAssociatedObject(self, @"isHideTab", @(isHideTab), OBJC_ASSOCIATION_ASSIGN);
//}
@end
