//
//  FFOptionPagerView.h
//  MenuOption
//
//  Created by fanxiaobin on 2017/4/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FFTopOptionTagViewBottomLineType) {
    FFTopOptionTagViewBottomLineTypeBottom = 0,
    FFTopOptionTagViewBottomLineTypeTop,
    
};

///是否带图片
typedef NS_ENUM(NSInteger, FFTopOptionTagViewShowType) {
    FFTopOptionTagViewShowTypeNone = 0,
    FFTopOptionTagViewShowTypeImageLeft,
    FFTopOptionTagViewShowTypeImageRight,
    FFTopOptionTagViewShowTypeImageTop,
    FFTopOptionTagViewShowTypeImageDown
};

@interface FFTopOptionTageViewConfigure : NSObject

/// 静态-平均分配屏幕宽度
@property (nonatomic) BOOL isAverage;

/// 是否一次性加载所有页面
@property (nonatomic) BOOL isLoadAll;

/// 默认选中的索引
@property (nonatomic) NSInteger defaultIndex;

/// 每个选项的宽度固定值 (如果设置了这个值,则每个按钮的宽度都一样, 此时isAverage需设置为NO)
@property (nonatomic) CGFloat fixOptionWidth;

/// 每个选项之间的间距
@property (nonatomic) CGFloat itemSpace;

/// 顶部滚动视图的高度 默认44.0
@property (nonatomic) CGFloat topViewHeight;
@property (nonatomic,strong) UIColor *topViewBGColor;

/// 有图片时 图片显示的方式
@property (nonatomic) FFTopOptionTagViewShowType showType;

@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *normalImageArr;
@property (nonatomic,strong) NSArray *selectedImageArr;

/// 标题和指示线的颜色
@property (nonatomic,strong) UIColor *normalTitleColor;
@property (nonatomic,strong) UIColor *selectedTitleColor;
@property (nonatomic,strong) UIColor *bottomLineColor;

/// 指示线的宽度和高度
@property (nonatomic) FFTopOptionTagViewBottomLineType bottomLineType;
@property (nonatomic) CGFloat bottomLineHeight;
@property (nonatomic) CGFloat bottomWidthScale; //底线的宽度占按钮宽度的比例 (不能超多1.0)



@end


@class FFTopOptionTagView;

@interface FFOptionPagerView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *bottomScrollView;

@property (nonatomic,strong) FFTopOptionTagView *topView;

-(instancetype)initWithFrame:(CGRect)frame viewControllers:(NSArray *)viewControllers configuer:(FFTopOptionTageViewConfigure *)config;

@end
