//
//  ZYLoginView.m
//  MVVMXBBX
//
//  Created by me2 on 2018/5/9.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYLoginView.h"
#import "ZYLogViewModel.h"

@interface ZYLoginView()
//@property (strong,nonatomic) ZYLogViewModel *logViewModel;


@end
@implementation ZYLoginView

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.logViewModel = [[ZYLogViewModel alloc]init];
    [self.loginBtn setEnabled:false];
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
