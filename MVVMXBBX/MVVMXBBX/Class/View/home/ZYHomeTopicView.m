//
//  ZYHomeTopicView.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/3.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomeTopicView.h"

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

@end
