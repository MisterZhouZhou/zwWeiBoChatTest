//
//  ZWMessageViewController.m
//  ZW微博
//
//  Created by rayootech on 15/11/1.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "ZWMessageViewController.h"

@interface ZWMessageViewController ()

@end

@implementation ZWMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *chat=[[UIBarButtonItem alloc]initWithTitle:@"发起聊天" style:UIBarButtonItemStyleBordered target:self action:@selector(chatClick)];
 
    self.navigationItem.rightBarButtonItem=chat;
}

#pragma mark-发起聊天
-(void)chatClick{

    ZWLog(@"%s",__func__);
}

#pragma mark - Table view data sourc
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test-message-%d", indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    HWTest1ViewController *test1 = [[HWTest1ViewController alloc] init];
//    test1.title = @"测试1控制器";
//    // 当test1控制器被push的时候，test1所在的tabbarcontroller的tabbar会自动隐藏
//    // 当test1控制器被pop的时候，test1所在的tabbarcontroller的tabbar会自动显示
//    //    test1.hidesBottomBarWhenPushed = YES;
//    
//    // self.navigationController === HWNavigationController
//    [self.navigationController pushViewController:test1 animated:YES];
   
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
