
//
//  SelectTableViewCell.m
//  YouJiaoYuan
//
//  Created by mac on 16/1/13.
//  Copyright © 2016年 zhengShengJiaoYu. All rights reserved.
//
#define WS(weakSelf)  __weak __typeof(&*self)(weakSelf) = self;
#define UIWidth [[UIScreen mainScreen] bounds].size.width

#import "SelectTableViewCell.h"
#import "Masonry.h"


@implementation SelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildUI];
    }
    return self;
}
- (void)buildUI{
    WS(weakSelf);
    for (int i = 0; i < 3; i++) {
        BtnAndLabelView * blView = [[BtnAndLabelView alloc]init];
        blView.tag = 2000 + i;
        [blView.selectBtn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:blView];
        
        [blView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.contentView.mas_top).offset(5);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-5);
            make.width.mas_equalTo(weakSelf.contentView.frame.size.width / 3);
            make.centerX.mas_equalTo(i * UIWidth / 24 * 7 - UIWidth / 24 * 7);
        }];
    }
    
}
- (void)setTitleArray:(NSArray *)titleArray
{
    for (int i = 0; i < titleArray.count ; i++) {
        BtnAndLabelView * btnV = (BtnAndLabelView *)[self.contentView viewWithTag:2000 + i];
        if ([titleArray[i] isEqualToString:@""]) {
            btnV.hidden = YES;
        }
        else
        {
            btnV.nameLabel.text = titleArray[i];
        }
    }
}
- (void)btnAction:(UIButton *)btn{
    
    if ([btn.superview isEqual:_selectedView]) {
        btn.selected = !btn.selected;
    }else
    {
        _selectedView.selectBtn.selected = NO;
        btn.selected = YES;
        _selectedView = (BtnAndLabelView *)btn.superview;
    }
    
    
    UILabel * title = [btn.superview viewWithTag:1000];
    if ([title.text isEqualToString:@"列全选"]) {
        if (_delegate && [_delegate respondsToSelector:@selector(selectTableViewCell:allBtnDidClicked:)]) {
            [_delegate selectTableViewCell:self allBtnDidClicked:btn];
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(selectTableViewCell:otherBtnDidClicked:)]) {
            [_delegate selectTableViewCell:self otherBtnDidClicked:btn];
        }
    }
}
@end


@implementation BtnAndLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /*  布局  */
        ///1、button
        self.selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"44.png"] forState:(UIControlStateNormal)];
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"33.png"] forState:(UIControlStateSelected)];
        [self addSubview:_selectBtn];
        
        
        
        ///2、label
        self.nameLabel = [UILabel new];
        [self addSubview:_nameLabel];
        self.nameLabel.tag = 1000;
        self.nameLabel.text = @"aaaaa";
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        
        WS(weakSelf);
        [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.selectBtn.mas_right);
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.centerY.equalTo(weakSelf.selectBtn);
        }];
    }
    return self;
}

@end