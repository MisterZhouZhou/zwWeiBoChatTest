//
//  ZWMineViewController.m
//  ZW微博
//
//  Created by rayootech on 15/11/1.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "ZWMineViewController.h"

@interface ZWMineViewController ()

@end

@implementation ZWMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *settingItem=[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(profileClick)];
    self.navigationItem.rightBarButtonItem=settingItem;
}

-(void)profileClick{

    
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
