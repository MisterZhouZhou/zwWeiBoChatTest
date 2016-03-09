//
//  ZWHomeViewController.m
//  ZW微博
//
//  Created by rayootech on 15/11/1.
//  Copyright © 2015年 rayootech. All rights reserved.
//

#import "ZWHomeViewController.h"
#import "ZWTitileMenuTableViewController.h"

#import "ZWHomeTableViewCell.h"

#import "ZWTitleButton.h"
#import "ZWDropdownMenu.h"
#import "ZWOneViewController.h"
#import "ZWAccountTool.h"
#import "ZWAccount.h"
#import "MJExtension.h"
#import "ZWStatus.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "ZWStatusTool.h"
#import "ZWUserTool.h"
#import "ZWHomeFrame.h"
//#import "ZWUser.h"
@interface ZWHomeViewController ()<ZWDropdownMenuDelegate,UITableViewDataSource,UITableViewDelegate>

//数据
@property(nonatomic,strong)NSMutableArray *statusesFrames;

//表格
@property(nonatomic,strong)UITableView *mainTableView;

//导航条中奖标题
@property(nonatomic,strong)ZWTitleButton *mytitleBtn;
@end

@implementation ZWHomeViewController

static NSString *ID=@"cell";

-(UITableView *)mainTableView
{
    if (_mainTableView==nil) {
        _mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    }
    return _mainTableView;
}

-(NSMutableArray *)statusesFrames
{

    if (_statusesFrames==nil) {
        _statusesFrames=[NSMutableArray array];
    }
    return _statusesFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //设置表格
    [self.view addSubview:self.mainTableView];
    self.mainTableView.dataSource=self;
    self.mainTableView.delegate=self;
    self.mainTableView.backgroundColor=[UIColor lightGrayColor];
    self.mainTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    //设置导航栏内容
    [self setUpNav];

    //添加下拉刷新
     // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
     self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewStatus)];
     
     // 马上进入刷新状态
     [self.mainTableView.mj_header beginRefreshing];

    //添加上拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
    
    //请求当前用户的昵称
    [ZWUserTool userInfoWithSuccess:^(ZWUser *result) {
        
        //请求当前账号的用户信息
        //设置导航条的标题
        [self.mytitleBtn setTitle:result.name forState:UIControlStateNormal];
        
        //获取当前账号
        ZWAccount *account=[ZWAccountTool account];
        account.name=result.name;
//
        //保存当前账号
        [ZWAccountTool saveAccount:account];
        
        NSLog(@"%@",account);
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    
        
    }];
}

#pragma mark-UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.statusesFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //创建cell
    ZWHomeTableViewCell *cell=[ZWHomeTableViewCell cellWithTableView:tableView];

    cell.statusF=self.statusesFrames[indexPath.row];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    ZWHomeFrame *homeF=self.statusesFrames[indexPath.row];
    return homeF.cellHight;
}

#pragma mark-请求最新的微博数据
-(void)loadNewStatus
{
    
    __block typeof (self)WeakSelf=self;
    NSString *sinceId=nil;
    if (self.statusesFrames.count) {//有微博数据，才需要刷新最新的数据
        ZWStatus *s=[self.statusesFrames[0] status];
        sinceId=s.idstr;
    }
    [ZWStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        
        //展示最新的微博数
        [WeakSelf showNewStatusCount:statuses.count];
        
        NSMutableArray *staF=[NSMutableArray array];
        
        //进行模型转化
        for (ZWStatus *sta in statuses) {
            ZWHomeFrame *statusF=[[ZWHomeFrame alloc]init];
            statusF.status=sta;
            
            [staF addObject:statusF];
        }
        
        NSIndexSet *indexset=[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        [WeakSelf.statusesFrames insertObjects:staF atIndexes:indexset];
        
        [WeakSelf.mainTableView.mj_header endRefreshing];
        [WeakSelf.mainTableView reloadData];
    } failure:^(NSError *error) {
        if (error) {
            //加载失败提示
            [WeakSelf.view configBlankPage:ZWBlankPageScoreView hasData:NO hasError:YES reloadButtonBlock:^(id sender) {
                [WeakSelf loadNewStatus];
            }];
            
            [WeakSelf.mainTableView.mj_header endRefreshing];
            
            NSLog(@"%@",error);
        }
    }];

   }

#pragma mark-展示最新的微博数
-(void)showNewStatusCount:(NSInteger)count
{

    if (count==0)
        return;
    
    //展示最新的微博数
    CGFloat h=35;
    CGFloat y=CGRectGetMaxY(self.navigationController.navigationBar.frame)-h;
    CGFloat x=0;
    CGFloat w=self.view.width;
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    label.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.text=[NSString stringWithFormat:@"最新微博数%ld",count];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    //插入导航控制下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画往下面移动
    [UIView animateWithDuration:0.25 animations:^{
        
        label.transform=CGAffineTransformMakeTranslation(0, h);
        
    } completion:^(BOOL finished) {
        
        //往上面平移
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            
            //还原
            label.transform=CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            [label removeFromSuperview];
        }];
        
    }];

}

-(void)loadMoreStatus
{
    NSString *maxid=nil;
    if (self.statusesFrames.count) {//有微博数据，才需要刷新最新的数据
         ZWStatus *s=[[self.statusesFrames lastObject] status];
        long long maxId=[s.idstr longLongValue]-1;
        maxid=[NSString stringWithFormat:@"%lld",maxId];
    }
    [ZWStatusTool newStatusWithMaxId:maxid success:^(NSArray *statuses) {
        
        NSMutableArray *staF=[NSMutableArray array];
        //进行模型转化
        for (ZWStatus *sta in statuses) {
            ZWHomeFrame *statusF=[[ZWHomeFrame alloc]init];
            statusF.status=sta;
            
            [staF addObject:statusF];
        }
        
        [self.statusesFrames addObjectsFromArray:staF];
        
        [self.mainTableView.mj_footer endRefreshing];
        [self.mainTableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
        
}


#pragma mark-设置导航栏
-(void)setUpNav{

    //设置导航栏上面的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    //中间标题按钮
    ZWTitleButton *titleBtn=[[ZWTitleButton alloc]init];
    
    //设置图片和文字
    NSString *name=[ZWAccountTool account].name;
    [titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    
    //监听标题事件
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=titleBtn;
    
    self.mytitleBtn=titleBtn;
}



/**
 *  标题点击事件
 */
-(void)titleClick:(UIButton *)titleButton{
 
    //1.创建下拉菜单
    ZWDropdownMenu *menu=[ZWDropdownMenu menu];
    menu.delegate=self;
    
    //设置内容
    ZWTitileMenuTableViewController *titleVc=[[ZWTitileMenuTableViewController alloc]init];
    titleVc.view.height=150;
    titleVc.view.width=150;
    menu.contentController=titleVc;
    
    //显示
    [menu showFrom:titleButton];
}

#pragma mark-ZWDropdowMenuDelegate
/**
 *  下拉菜单被销毁
 */
- (void)dropdownMenuDidDismiss:(ZWDropdownMenu *)menu{
    UIButton *titleButton=(UIButton *)self.navigationItem.titleView;
    //箭头向上
    titleButton.selected=NO;
    
}
//下拉菜单
- (void)dropdownMenuDidShow:(ZWDropdownMenu *)menu{
 
    UIButton *titleButton=(UIButton *)self.navigationItem.titleView;
    //箭头向上
    titleButton.selected=YES;
}

- (void)friendSearch
{
    NSLog(@"friendSearch");
}

- (void)pop
{
    NSLog(@"pop");
    ZWOneViewController *oneVC=[[ZWOneViewController alloc]init];
    [self.navigationController pushViewController:oneVC animated:YES];
}

//点击首页时刷新
-(void)refresh
{
    // 马上进入刷新状态
    [self.mainTableView.mj_header beginRefreshing];
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
