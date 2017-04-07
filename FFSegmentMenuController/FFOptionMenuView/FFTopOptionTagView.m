//
//  FFTopOptionTagView.m
//  MenuOption
//
//  Created by fanxiaobin on 2017/4/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "FFTopOptionTagView.h"
#import "UIButton+EdgeInsets.h"
#import "FFOptionPagerView.h"

#define FF_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define FF_BtnTag        234223




@interface FFTopOptionTagView ()

@property (nonatomic,strong) FFTopOptionTageViewConfigure *optionConfigur;

@property (nonatomic,strong) UIScrollView *scrollView;

@end


@implementation FFTopOptionTagView

-(instancetype)initWithFrame:(CGRect)frame configuer:(FFTopOptionTageViewConfigure *)optionConfig{
    
    if (self = [super initWithFrame:frame]) {
        
        _optionConfigur = optionConfig;
        
        self.backgroundColor = optionConfig.topViewBGColor ? optionConfig.topViewBGColor : [UIColor whiteColor];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        self.bottomLine = [[UIImageView alloc] init];
        self.bottomLine.backgroundColor = optionConfig.bottomLineColor ? optionConfig.bottomLineColor : [UIColor orangeColor];
        [_scrollView addSubview:self.bottomLine];
        
        CGFloat bottomLineHeight = optionConfig.bottomLineHeight > 0 ? optionConfig.bottomLineHeight : 2.0;
        CGFloat lineWidthScale = optionConfig.bottomWidthScale > 0 ? optionConfig.bottomWidthScale : 1.0;
        CGFloat itemSpace = optionConfig.itemSpace > 0 ? optionConfig.itemSpace : 10.0;
        
        CGFloat totalWidth = 0.0;
        
        NSArray *titleArr = optionConfig.titleArr;
        NSArray *imageArr = optionConfig.normalImageArr;
        NSArray *selectedImageArr = optionConfig.selectedImageArr;
        
        for (int i = 0; i < titleArr.count; i++) {
            
            NSString *title = titleArr[i];
            
            ///默认按文字数量计算宽度
            CGFloat singleWidth = [title boundingRectWithSize:CGSizeMake(FF_ScreenWidth, self.bounds.size.height) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16.0]} context:nil].size.width + 20.0;
            
            if (optionConfig.fixOptionWidth > 0) {
                singleWidth = optionConfig.fixOptionWidth;
            }
            
            UIButton *button;
            
            if (optionConfig.isAverage) {   ///平均分配
                
                _scrollView.contentSize = CGSizeMake(FF_ScreenWidth, self.bounds.size.height);
                
                singleWidth = FF_ScreenWidth / titleArr.count - itemSpace;
                
                if (optionConfig.bottomLineType == FFTopOptionTagViewBottomLineTypeBottom){
                    button = [[UIButton alloc] initWithFrame:CGRectMake((singleWidth+ itemSpace) * i, 0, singleWidth+itemSpace, self.bounds.size.height - bottomLineHeight - 1.0)];
                }else{
                    button = [[UIButton alloc] initWithFrame:CGRectMake((singleWidth+ itemSpace) * i, bottomLineHeight + 1.0, singleWidth+itemSpace, self.bounds.size.height - bottomLineHeight - 1.0)];
                }
                
                
            }else{
                
                if (imageArr.count > 0 && (optionConfig.showType == FFTopOptionTagViewShowTypeImageLeft || optionConfig.showType == FFTopOptionTagViewShowTypeImageRight)) {
                    singleWidth += 30.0;
                }
                if (optionConfig.bottomLineType == FFTopOptionTagViewBottomLineTypeBottom){
                    button = [[UIButton alloc] initWithFrame:CGRectMake(totalWidth, 0, singleWidth, self.bounds.size.height - bottomLineHeight - 1.0)];
                }else{
                    button = [[UIButton alloc] initWithFrame:CGRectMake(totalWidth, bottomLineHeight+1.0, singleWidth, self.bounds.size.height - bottomLineHeight - 1.0)];
                }
                
                
                totalWidth += (singleWidth + itemSpace);
                _scrollView.contentSize = CGSizeMake(totalWidth-itemSpace, self.bounds.size.height);
            }
            
            [button setBackgroundColor:[UIColor cyanColor]];
            button.titleLabel.font = [UIFont systemFontOfSize:15.0];
            
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:optionConfig.normalTitleColor ? optionConfig.normalTitleColor : [UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:optionConfig.selectedTitleColor ? optionConfig.selectedTitleColor : [UIColor orangeColor] forState:UIControlStateSelected];
            button.tag = FF_BtnTag + i;
            [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
            
            if (imageArr.count > 0) { ///如果有图片就显示
                NSString *normalImageName = imageArr[i];
                NSString *selectedImageName = selectedImageArr[i];
                [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
                
                FFTopOptionTagViewShowType showType = optionConfig.showType;
                if (showType == FFTopOptionTagViewShowTypeImageTop) {
                    [button setImagePositionWithType:FFImagePositionTypeTop spacing:2.0];
                }else if (showType == FFTopOptionTagViewShowTypeImageDown){
                    [button setImagePositionWithType:FFImagePositionTypeBottom spacing:2.0];
                }else if (showType == FFTopOptionTagViewShowTypeImageLeft){
                    [button setImagePositionWithType:FFImagePositionTypeLeft spacing:2.0];
                }else if (showType == FFTopOptionTagViewShowTypeImageRight){
                    [button setImagePositionWithType:FFImagePositionTypeRight spacing:2.0];
                }
                
            }
            
            if (i == 0) {
                button.selected = YES;
                self.selectedBtn = button;
                if (optionConfig.bottomLineType == FFTopOptionTagViewBottomLineTypeBottom) { //
                    self.bottomLine.frame = CGRectMake(CGRectGetMinX(button.frame)+ (CGRectGetWidth(button.frame) *(1.0 - lineWidthScale))/2.0, CGRectGetMaxY(button.frame)+1.0, CGRectGetWidth(button.frame) * lineWidthScale, bottomLineHeight);
                }else{
                   self.bottomLine.frame = CGRectMake(CGRectGetMinX(button.frame)+ (CGRectGetWidth(button.frame) *(1.0 - lineWidthScale))/2.0, 0, CGRectGetWidth(button.frame) * lineWidthScale, bottomLineHeight);
                }
                
            }
            
            [_scrollView addSubview:button];
            
            
        }
      
        
        
    }
    
    return self;
}



- (void)buttonClickAction:(UIButton *)sender{
    NSInteger index = sender.tag - FF_BtnTag;
    NSLog(@"--- index = %ld",index);
    [self scrollTitleSelectededCenterWithIndex:index];
    
    
    if (self.selectedBtnIndexBlock) {
        self.selectedBtnIndexBlock(sender, index);
    }
    
    
    
}

/** 滚动标题选中居中 */
- (void)scrollTitleSelectededCenterWithIndex:(NSInteger)index {
    
    UIButton *centerBtn = (UIButton *)[self viewWithTag:FF_BtnTag + index];
    
    
    
    // 计算偏移量
    CGFloat offsetX = centerBtn.center.x - FF_ScreenWidth * 0.5;
    
    if (offsetX < 0) offsetX = 0;
    
    // 获取最大滚动范围
    CGFloat maxOffsetX = _scrollView.contentSize.width - FF_ScreenWidth;
    
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    
    // 滚动标题滚动条
    [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    
    UIButton *sender = centerBtn;
    
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    
    CGFloat bottomLineHeight = _optionConfigur.bottomLineHeight > 0 ? _optionConfigur.bottomLineHeight : 2.0;
    CGFloat lineWidthScale = _optionConfigur.bottomWidthScale > 0 ? _optionConfigur.bottomWidthScale : 1.0;
    
    if (_optionConfigur.bottomLineType == FFTopOptionTagViewBottomLineTypeBottom) { //
        [UIView animateWithDuration:0.15 animations:^{
            self.bottomLine.frame = CGRectMake(CGRectGetMinX(sender.frame)+ (CGRectGetWidth(sender.frame) *(1.0 - lineWidthScale))/2.0, CGRectGetMaxY(sender.frame)+1.0, CGRectGetWidth(sender.frame) * lineWidthScale, bottomLineHeight);
        }];
    }else{
        [UIView animateWithDuration:0.15 animations:^{
            self.bottomLine.frame = CGRectMake(CGRectGetMinX(sender.frame)+ (CGRectGetWidth(sender.frame) *(1.0 - lineWidthScale))/2.0, 0, CGRectGetWidth(sender.frame) * lineWidthScale, bottomLineHeight);
        }];
        
    }
}

@end
