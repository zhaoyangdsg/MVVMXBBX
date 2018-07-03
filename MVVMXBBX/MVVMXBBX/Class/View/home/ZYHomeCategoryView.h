//
//  ZYHomeCategoryView.h
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/7/3.
//  Copyright © 2018年 me2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYHomeCategoryView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (strong,nonatomic) RACSubject *btn3ClkSubject;
@property (strong,nonatomic) RACCommand *btn4ClkCommand;
@end
