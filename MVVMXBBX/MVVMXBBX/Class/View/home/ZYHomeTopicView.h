//
//  ZYHomeTopicView.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/3.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYHomeViewModel;
@interface ZYHomeTopicView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (strong, nonatomic) RACSubject *btn1ClickSubject;
@property (strong, nonatomic) RACSubject *btn2ClickSubject;
@property (strong, nonatomic) RACSubject *btn3ClickSubject;

- (void)bindHomeViewModel:(ZYHomeViewModel *)viewModel;
@end
