//
//  ZYHomeCategoryView.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/3.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomeCategoryView.h"

@implementation ZYHomeCategoryView
- (IBAction)btn1Click:(id)sender {
  
}
- (IBAction)btn2Click:(id)sender {
}
- (IBAction)btn3Click:(id)sender {
    if (self.btn3ClkSubject) {
        [self.btn3ClkSubject sendNext:self.btn3];
    }
}
- (IBAction)btn4Click:(id)sender {
    if (self.btn4ClkCommand) {
        [[self.btn4ClkCommand execute:nil] subscribeNext:^(NSString *x) {
            NSLog(@"categoryView %@",x);
        }];;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self bindViewModel];
}

- (void)bindViewModel {
    
}

@end
