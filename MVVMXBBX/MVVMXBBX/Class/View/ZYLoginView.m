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
@property (weak, nonatomic) IBOutlet UITextField *LogUserField;
@property (weak, nonatomic) IBOutlet UITextField *LogPwdField;
@property (strong,nonatomic) ZYLogViewModel *logViewModel;

@end
@implementation ZYLoginView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.LogUserField addTarget:self action:@selector(userChange:) forControlEvents:(UIControlEventValueChanged)];
    
}
- (IBAction)loginAction {
    [self.logViewModel goLogInSuccess:^(id json) {
        NSLog(@"登录成功 %@",json);
    } fail:^(id error) {
        NSLog(@"登录失败 %@",error);
    }];
}
- (void)userChange:(UITextField *)userField{
    self.logViewModel.user = userField.text;
}
- (IBAction)pwdChange:(UITextField *)sender {
    self.logViewModel.pwd = sender.text;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
