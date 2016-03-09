//
//  ZWMainTabBarController.m
//  ZW微博
//
//  Created by rayootech on 15/11/1.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "ZWMainTabBarController.h"
#import "UIImage+ZWImgRender.h"
#import "ZWMainTabBar.h"
#import <objc/message.h>
#import "ZWNavigationViewController.h"
#import "ZWHomeViewController.h"
#import "ZWDiscoverViewController.h"
#import "ZWMessageViewController.h"
#import "ZWMineViewController.h"
#import "ZWComposeViewController.h"

#import "ZWUserTool.h"
#import "ZWUserResult.h"
@interface ZWMainTabBarController ()<ZWMainTabBarDelegate>


@property(nonatomic,strong)ZWHomeViewController *homeVC;

@property(nonatomic,strong)ZWMessageViewController *messageVC;
@property(nonatomic,strong)ZWMineViewController *meVC;
@end

@implementation ZWMainTabBarController

+(void)initialize{
    //获取所有TabBarItem的外观标识，设置标题字体颜色
    //    UITabBarItem *item=[UITabBarItem appearance];
    
    //获取当前的TabBarItem
     UITabBarItem *item=[UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *att=[NSMutableDictionary dictionary];
    att[NSForegroundColorAttributeName]=[UIColor orangeColor];
    [item setTitleTextAttributes:att forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置tab子控制器
    [self setUpChildControllers];
    
    //自定义tabbar
    ZWMainTabBar *tabBar=[[ZWMainTabBar alloc]initWithFrame:self.tabBar.bounds];
    tabBar.delegate=self;
    [self setValue:tabBar forKey:@"tabBar"];
    //objc和上面的效果一样
//    objc_msgSend(self,@selector(setTabBarItem:),tabBar);
    
    //请求微博的为读数
    
    [self requestUnreadMessage];
}

-(void)requestUnreadMessage
{
    //每隔一段时间请求一次未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(requestUnredMess) userInfo:self repeats:YES];
    
 }

-(void)requestUnredMess
{
    [ZWUserTool unreadWithSuccess:^(ZWUserResult *result) {
        //设置首页的为读数
        if (result.status) {
            self.homeVC.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",result.status];
        }
        
        //设置消息的为读数
        if (result.messageCount) {
            self.messageVC.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",result.messageCount];
        }
        
        //设置我的未读数
        if (result.follower) {
            self.meVC.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",result.follower];
            
        }
        
        //设置应用程序所有未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber=result.totalCount;
        
    } failure:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];

}

#pragma mark-设置tab子控制器
-(void)setUpChildControllers{
    //管理自控制器
    ZWHomeViewController *homeVC=[[ZWHomeViewController alloc]init];
    [self setUpOnceChildController:homeVC NorImg:@"tabbar_home" SelImg:@"tabbar_home_selected" title:@"首页"];
    homeVC.tabBarItem.tag=0;
    self.homeVC=homeVC;
    //消息
    ZWMessageViewController *messageVC=[[ZWMessageViewController alloc]init];
     [self setUpOnceChildController:messageVC NorImg:@"tabbar_message_center" SelImg:@"tabbar_message_center_selected" title:@"消息"];
    messageVC.tabBarItem.tag=1;
    self.messageVC=messageVC;
    //发现
    ZWDiscoverViewController *disscoverVC=[[ZWDiscoverViewController alloc]init];
     [self setUpOnceChildController:disscoverVC NorImg:@"tabbar_discover" SelImg:@"tabbar_discover_selected" title:@"发现"];
    disscoverVC.tabBarItem.tag=3;
    
    //我
    ZWMineViewController *meVC=[[ZWMineViewController alloc]init];
     [self setUpOnceChildController:meVC NorImg:@"tabbar_profile" SelImg:@"tabbar_profile_selected" title:@"我"];
    meVC.tabBarItem.tag=4;
    self.meVC=meVC;
}

#pragma mark-设置控制器属性
-(void)setUpOnceChildController:(UIViewController *)childvc NorImg:(NSString *)img SelImg:(NSString *)selimg title:(NSString *)title{
    
    childvc.title=title;
//    childvc.tabBarItem.badgeValue=@"10";
    childvc.tabBarItem.image=[UIImage imageNamed:img];
    if (iOS7) {
        childvc.tabBarItem.selectedImage=[UIImage UIImageRenderingModeWithString:selimg];
    }else
    {
       childvc.tabBarItem.selectedImage=[UIImage imageNamed:selimg];
    }
    
    
    //把控制器包装成导航控制器
    ZWNavigationViewController *nav=[[ZWNavigationViewController alloc]initWithRootViewController:childvc];
    
    [self addChildViewController:nav];
}

//当点击tabBar上按钮时会调用
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

    if (item.tag==0) {//点击首页，刷新
        [self.homeVC refresh];
        self.homeVC.tabBarItem.badgeValue=0;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  点击加号事件代理方法
 *
 *  @param tabBar ZWMainTabBar
 */
-(void)tabBarDidClickPlusButton:(ZWMainTabBar *)tabBar
{
    //创建控制器对象
    ZWComposeViewController *compVC=[[ZWComposeViewController alloc]init];
    ZWNavigationViewController *nav=[[ZWNavigationViewController alloc]initWithRootViewController:compVC];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
