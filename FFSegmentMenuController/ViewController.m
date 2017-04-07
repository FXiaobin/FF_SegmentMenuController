//
//  ViewController.m
//  MenuOption
//
//  Created by fanxiaobin on 2017/4/7.
//  Copyright © 2017年 fanxiaobin. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"


#import "FFTopOptionTagView.h"
#import "FFOptionPagerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    NSArray *vcsArray_sel= @[@"tabbar_home_selected_os7",@"tabbar_home_selected_os7",@"tabbar_home_selected_os7",@"tabbar_home_selected_os7",@"tabbar_home_selected_os7",@"tabbar_home_selected_os7",@"tabbar_home_selected_os7"];
    NSArray *vcsArray = @[@"tabbar_home",@"tabbar_home",@"tabbar_home",@"tabbar_home",@"tabbar_home",@"tabbar_home",@"tabbar_home"];
    NSArray *titleArray = @[@"反倒是但是",@"法施工方丰",@"给对方",@"法",@"给对",@"法施工方丰",@"给对方功夫"];
    
   
    FFTopOptionTageViewConfigure *config = [[FFTopOptionTageViewConfigure alloc] init];
    //config.isAverage = YES;
    config.normalTitleColor = [UIColor grayColor];
    config.selectedTitleColor = [UIColor orangeColor];
    config.titleArr = titleArray;
    config.normalImageArr = vcsArray;
    config.selectedImageArr = vcsArray_sel;
    
    //config.bottomWidthScale = 0.6;
    //config.fixOptionWidth = 150;
    
    config.bottomLineHeight = 5;
    config.bottomLineType = 0;
    config.itemSpace = 5.0;
    
    config.showType = FFTopOptionTagViewShowTypeImageLeft;
    
    
    //FFTopOptionTagView *tagView = [[FFTopOptionTagView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44.0) configuer:config];
    
    //[self.view addSubview:tagView];
    //config.defaultIndex = 2;
    
    config.isLoadAll = NO;
    
    
    NSArray *viewControllers = @[@"OneViewController",@"OneViewController",@"OneViewController",@"OneViewController",@"OneViewController",@"OneViewController",@"OneViewController"];
    FFOptionPagerView *pageView = [[FFOptionPagerView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20) viewControllers:viewControllers configuer:config];
    pageView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:pageView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
