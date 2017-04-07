//
//  FFOptionPagerView.m
//  MenuOption
//
//  Created by fanxiaobin on 2017/4/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "FFOptionPagerView.h"
#import "FFTopOptionTagView.h"

#define FF_ScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation FFTopOptionTageViewConfigure

@end

@interface FFOptionPagerView ()

@property (nonatomic,strong) NSMutableArray *childViewControllers;

@end

@implementation FFOptionPagerView

-(instancetype)initWithFrame:(CGRect)frame viewControllers:(NSArray *)viewControllers configuer:(FFTopOptionTageViewConfigure *)config{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat topHeight = config.topViewHeight > 0 ? config.topViewHeight : 44.0;
        ///添加顶部选项菜单
        _topView = [[FFTopOptionTagView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, topHeight) configuer:config];
        __weak typeof(self) weakSelf = self;
        _topView.selectedBtnIndexBlock = ^(UIButton *sender, NSInteger index) {
            [weakSelf.bottomScrollView setContentOffset:CGPointMake(FF_ScreenWidth * index, 0) animated:YES];
            [weakSelf loadCurrentControllerWithIndex:index];
        };
        
        [self addSubview:_topView];
        
        //添加滚动视图
        self.bottomScrollView = [[UIScrollView alloc] init];
        self.bottomScrollView.frame = CGRectMake(0, topHeight, FF_ScreenWidth, self.bounds.size.height - topHeight);
        self.bottomScrollView.pagingEnabled = YES;
        self.bottomScrollView.bounces = NO;
        self.bottomScrollView.delegate = self;
        self.bottomScrollView.showsVerticalScrollIndicator = NO;
        self.bottomScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.bottomScrollView];
        
        
        NSMutableArray *childViewControllers = [NSMutableArray arrayWithCapacity:viewControllers.count];
        
        
        for (int i = 0; i < viewControllers.count; i++) {
            id obj = viewControllers[i];
            if ([obj isKindOfClass:[UIViewController class]]) {
                UIViewController *vc = [[obj alloc] init];
                [childViewControllers addObject:vc];
                
            }else if ([obj isKindOfClass:[NSString class]]){
                Class cls = NSClassFromString(obj);
                UIViewController *VC = [[cls alloc] init];
                [childViewControllers addObject:VC];
            }
        }
        
        self.childViewControllers = childViewControllers;
        
        self.bottomScrollView.contentSize = CGSizeMake(FF_ScreenWidth * childViewControllers.count, self.bottomScrollView.bounds.size.height);
        
        
        
        
        if (config.isLoadAll) {
            
            for (int j = 0; j < childViewControllers.count; j++) {
                
                UIViewController *subVC = childViewControllers[j];
                subVC.view.frame = CGRectMake(FF_ScreenWidth * j, 0, FF_ScreenWidth, self.bottomScrollView.bounds.size.height);
                
                [self.bottomScrollView addSubview:subVC.view];

            }
         
        }else{
            
            
        }
        
        
        /// 默认选中
        UIViewController *vc = childViewControllers[config.defaultIndex];
        vc.view.frame = CGRectMake(FF_ScreenWidth * config.defaultIndex, 0, FF_ScreenWidth, self.bottomScrollView.bounds.size.height);
        [self.bottomScrollView addSubview:vc.view];
        [_topView scrollTitleSelectededCenterWithIndex:config.defaultIndex];
        [_bottomScrollView setContentOffset:CGPointMake(config.defaultIndex * FF_ScreenWidth, 0) animated:NO];
        
    }
    return self;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / FF_ScreenWidth;
    
    [_topView scrollTitleSelectededCenterWithIndex:index];
    
    
    [self loadCurrentControllerWithIndex:index];
   
 
}

- (void)loadCurrentControllerWithIndex:(NSInteger)index{
    
    UIViewController *vc = _childViewControllers[index];
    if (vc.isViewLoaded) {
        return;
    }
    vc.view.frame = CGRectMake(FF_ScreenWidth * index, 0, FF_ScreenWidth, self.bottomScrollView.bounds.size.height);
    
    [self.bottomScrollView addSubview:vc.view];
    
}

@end
