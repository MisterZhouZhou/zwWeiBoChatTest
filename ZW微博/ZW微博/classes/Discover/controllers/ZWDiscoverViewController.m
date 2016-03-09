//
//  ZWDiscoverViewController.m
//  ZW微博
//
//  Created by rayootech on 15/11/1.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "ZWDiscoverViewController.h"

@interface ZWDiscoverViewController ()

@end

@implementation ZWDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建搜索框
    UITextField *searchBar=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    searchBar.placeholder=@"大家都在搜";
    searchBar.background=[UIImage imageNamed:@"searchbar_textfield_background"];
    searchBar.font=FontSize(13);
    
    //设置左边的View
    UIImageView *imageV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    imageV.width+=10;
    imageV.contentMode=UIViewContentModeCenter;
    searchBar.leftView=imageV;
    searchBar.leftViewMode=UITextFieldViewModeAlways;
    
   //设置titleView为搜索框
    self.navigationItem.titleView=searchBar;
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
