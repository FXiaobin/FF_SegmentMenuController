//
//  FFTopOptionTagView.h
//  MenuOption
//
//  Created by fanxiaobin on 2017/4/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FFTopOptionTageViewConfigure;


@interface FFTopOptionTagView : UIView

@property (nonatomic,strong) UIButton *selectedBtn;

@property (nonatomic,strong) UIImageView *bottomLine;

-(instancetype)initWithFrame:(CGRect)frame configuer:(FFTopOptionTageViewConfigure *)optionConfig;

/** 滚动标题选中居中 */
- (void)scrollTitleSelectededCenterWithIndex:(NSInteger)index;

@property (nonatomic,copy) void (^selectedBtnIndexBlock) (UIButton *sender, NSInteger index);

@end
