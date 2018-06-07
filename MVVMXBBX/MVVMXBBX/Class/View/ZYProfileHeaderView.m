//
//  ZYProfileHeaderView.m
//  MVVMXBBX
//
//  Created by 肇扬 on 2018/5/18.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYProfileHeaderView.h"
#import "UIImage+ZY.h"
#import "ZYProfileHeaderViewModel.h"

@interface ZYProfileHeaderView()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@end

@implementation ZYProfileHeaderView

- (void)setViewModel:(ZYProfileHeaderViewModel *)viewModel {
    _viewModel = viewModel;
    NSString *imgUrl = [NSString stringWithFormat:@"http://images.xiaobaibao.com/%@",viewModel.avatar];
    self.avatarImgView.image = [UIImage imageWithUrlStr:imgUrl];
    self.nameLabel.text = viewModel.name;
    self.levelLabel.text = viewModel.level;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
