# FFSegmentMenuController
类似网易新闻 今日头条等新闻客户端顶部导航菜单

屏幕快照 2017-04-10 上午10.45.27

使用方法:

1. 拖入FFOptionMenuView文件夹

2. 导入头文件:
#import "FFTopOptionTagView.h"
#import "FFOptionPagerView.h"

3. 添加代码:
 
    NSArray *images_sel= @[@"tabbar_home_selected_os7",@"tabbar_home_selected_os7",@"tabbar_home_selected_os7",@"tabbar_home_selected_os7",@"tabbar_home_selected_os7",@"tabbar_home_selected_os7",@"tabbar_home_selected_os7"];
    NSArray *images = @[@"tabbar_home",@"tabbar_home",@"tabbar_home",@"tabbar_home",@"tabbar_home",@"tabbar_home",@"tabbar_home"];
    NSArray *titleArray = @[@"反倒是但是",@"法施工方丰",@"给对方",@"法",@"给对",@"法施工方丰",@"给对方功夫"];
    
   ///配置各种数据 (支持自适应宽度 固定宽度  可带图片 并且可设置图片和文字的位置)
    FFTopOptionTageViewConfigure *config = [[FFTopOptionTageViewConfigure alloc] init];
 
    //config.isAverage = YES;
    config.normalTitleColor = [UIColor grayColor];
    config.selectedTitleColor = [UIColor orangeColor];
    config.titleArr = titleArray;
    config.normalImageArr = images;
    config.selectedImageArr = images_sel;
    
    //config.bottomWidthScale = 0.6;
    //config.fixOptionWidth = 150;
    
    config.bottomLineHeight = 5;
    config.bottomLineType = 0;
    config.itemSpace = 5.0;
    
    config.showType = FFTopOptionTagViewShowTypeImageLeft;
    config.isLoadAll = NO;
    
    /// 初始化 并添加到 self.view上即可
   NSArray *viewControllers = @[@"OneViewController",@"OneViewController",@"OneViewController",@"OneViewController",@"OneViewController",@"OneViewController",@"OneViewController"];
    FFOptionPagerView *pageView = [[FFOptionPagerView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20) viewControllers:viewControllers configuer:config];
    pageView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:pageView];
