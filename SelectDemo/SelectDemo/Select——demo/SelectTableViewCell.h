//
//  SelectTableViewCell.h
//  SelectDemo
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 zhengShengJiaoYu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectTableViewCell;
@class BtnAndLabelView;

@protocol SelectTableViewCellDelegate <NSObject>
@optional
- (void)selectTableViewCell:(SelectTableViewCell *)SelectCell allBtnDidClicked:(UIButton *)btn;

- (void)selectTableViewCell:(SelectTableViewCell *)SelectCell otherBtnDidClicked:(UIButton *)btn;

@end


@interface SelectTableViewCell : UITableViewCell

///选中的button 所在的视图
@property (nonatomic,strong)BtnAndLabelView * selectedView;

@property (nonatomic,assign)id<SelectTableViewCellDelegate>delegate;
@property (nonatomic,strong)NSArray * titleArray;
@end

/**
 *  一个button、label的视图
 */

@interface BtnAndLabelView : UIView
@property (nonatomic,strong)UIButton * selectBtn;
@property (nonatomic,strong)UILabel * nameLabel;
@end
