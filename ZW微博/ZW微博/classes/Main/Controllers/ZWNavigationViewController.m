//
//  ZWNavigationViewController.m
//  ZW微博
//
//  Created by rayootech on 15/11/1.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "ZWNavigationViewController.h"

@interface ZWNavigationViewController ()<UINavigationControllerDelegate>

@property(nonatomic,strong)id popDelegate;
@end

@implementation ZWNavigationViewController

+(void)initialize{

    //设置整个项目的item的主题样式
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    
    //设置普通状态
    NSMutableDictionary *textAttrs=[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]=[UIColor orangeColor];
    textAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    //设置不可用状态
    NSMutableDictionary *disabletextAttrs=[NSMutableDictionary dictionary];
    disabletextAttrs[NSForegroundColorAttributeName]=[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disabletextAttrs[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disabletextAttrs forState:UIControlStateDisabled];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _popDelegate=self.interactivePopGestureRecognizer.delegate;
    
    
    self.delegate=self;
}

#pragma mark-UINavigation---POP
//导航控制器跳转完成时调用
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{

    if (viewController==self.viewControllers[0]) {//显示根控制器
        //还原滑动手势代理
        self.interactivePopGestureRecognizer.delegate=_popDelegate;
    }else
    {
        //实现滑动返回功能
        //清空滑动发挥手势的代理，就能够实现滑动功能
        self.interactivePopGestureRecognizer.delegate=nil;
      
    }
    
}

/**
 *  重写这个方法目的，可以拦截所有push进来的控制器
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
 
    if (self.viewControllers.count>0) {//这时push进来的控制器不是第一个控制器
        /*自动显示和隐藏tabbar*/
        viewController.hidesBottomBarWhenPushed=YES;
        
        /*设置导航栏上面的内容*/
        //设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        
        // 设置右边的更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
        
        
    }
    [super pushViewController:viewController animated:YES];
}

- (void)back
{
    // 因为self本来就是一个导航控制器，self.navigationController这里是nil的
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
