//
//  ZYHomePdtCell.m
//  MVVMXBBX
//
//  Created by 扬扬 on 2018/7/8.
//  Copyright © 2018年 me2. All rights reserved.
//

#import "ZYHomePdtCell.h"
#import "ZYHomePdtCellViewModel.h"

@interface ZYHomePdtCell()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *pdtNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *suitLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation ZYHomePdtCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)bindViewModel:(ZYHomePdtCellViewModel *)viewModel {
    [self.imgView sd_setImageWithURL:[NSURL URLWithString: [k_img_Url stringByAppendingString:viewModel.imgUrl]]];
    self.pdtNameLabel.text = viewModel.pdtName;
    self.suitLabel.text = viewModel.suit;
    self.priceLabel.text = [@"¥" stringByAppendingString:viewModel.money];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
