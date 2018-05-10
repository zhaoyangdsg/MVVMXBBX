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
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
@implementation ZYLoginView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.logViewModel = [[ZYLogViewModel alloc]init];
    [self.LogUserField addTarget:self action:@selector(userChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self setKVO];
    [self.loginBtn setEnabled:false];
    
    
}
- (IBAction)loginAction {
    [self.logViewModel goLogInSuccess:^(id json) {
        NSLog(@"登录成功 %@",json);
    } fail:^(id error) {
        NSLog(@"登录失败 %@",error);
    }];
}
- (void)userChange:(UITextField *)userField{
//    UITextField *field = userField;
    self.logViewModel.user = userField.text;
}
- (IBAction)pwdChange:(UITextField *)sender {
    self.logViewModel.pwd = sender.text;
}

- (void)setKVO {
    [self.logViewModel addObserver:self forKeyPath:@"_isEnable" options:NSKeyValueObservingOptionNew context:nil];
    [self.logViewModel addObserver:self forKeyPath:@"_isLogging" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"_isEnable"]) {
        NSLog(@"change %@",change);
        
//        Boolean isEnable = (Boolean)[change valueForKey:@"new"];
//        NSLog(@"isEnable %d",[change  );
        NSNumber *num = [change objectForKey:@"new"];
        if ([num boolValue]) {
            NSLog(@"it's true");
        }
        
        [self.loginBtn setEnabled: [num boolValue]];
        
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
