//
//  ZYHomeTopicView.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/3.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomeTopicView.h"
#import "ZYHomeViewModel.h"
@interface ZYHomeTopicView()
@property(nonatomic,strong) ZYHomeViewModel *viewModel;
@end

@implementation ZYHomeTopicView
- (IBAction)btn1Click:(id)sender {
    if (self.btn1ClickSubject) {
        [self.btn1ClickSubject sendNext:self.btn1];
    }
}
- (IBAction)btn2Click:(id)sender {
    if (self.btn2ClickSubject) {
        [self.btn2ClickSubject sendNext:self.btn2];
    }
}

- (IBAction)btn3Click:(id)sender {
    if (self.btn3ClickSubject) {
        [self.btn3ClickSubject sendNext:self.btn3];
    }
}

- (void)bindHomeViewModel:(ZYHomeViewModel *)viewModel {
    self.viewModel = viewModel;
    UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:viewModel.topic1Img]]];
    [self.btn1 setImage: img1 forState:UIControlStateNormal];
    
    UIImage *img2 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:viewModel.topic2Img]]];
    [self.btn2 setImage: img2 forState:UIControlStateNormal];
    
    UIImage *img3 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:viewModel.topic3Img]]];
    [self.btn3 setImage: img3 forState:UIControlStateNormal];
    
    
}
@end
