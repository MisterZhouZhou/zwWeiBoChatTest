//
//  ZWComposeViewController.m
//  ZW微博
//
//  Created by rayootech on 16/2/7.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import "ZWComposeViewController.h"

#import "ZWAccountTool.h"
#import "ZWAccount.h"
#import "ZWTextView.h"
#import "ZWHttpTool.h"
#import "ZWComposToolBar.h"
#import "ZWComposPhotoView.h"
#import "AFNetworking.h"
#import "ZWEmotionKeyboard.h"
#import "ZWEmotion.h"

@interface ZWComposeViewController ()<UITextViewDelegate,ZWComposToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,weak)ZWTextView *textView;

@property(nonatomic,weak)ZWComposToolBar *toolbar;

@property(nonatomic,weak)ZWComposPhotoView *photoView;//相册View

@property(nonatomic,strong)ZWEmotionKeyboard *emotionKyeboard;//表情键盘

@property(nonatomic,assign)BOOL switchKeyboardYoR;

@end

@implementation ZWComposeViewController

#pragma mark-懒加载
-(ZWEmotionKeyboard *)emotionKyeboard
{
    if (_emotionKyeboard==nil) {
        self.emotionKyeboard=[[ZWEmotionKeyboard alloc]init];
        self.emotionKyeboard.width=self.view.width;
        self. emotionKyeboard.height=216;
    }
    return _emotionKyeboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //设置导航内容
    [self setUpNavgationBar];
    
    //添加输入控件
    [self setUpTextViewd];
    
    //添加工具条
    [self setUpToolbar];
    
    //添加相册
    [self setUpPhotoView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    //设置第一响应者
    [self.textView becomeFirstResponder];
}

-(void)setUpPhotoView
{
    ZWComposPhotoView *photoView=[[ZWComposPhotoView alloc]init];
    photoView.y=100;
    photoView.width=self.view.width;
    photoView.height=self.view.height;
    [self.textView addSubview:photoView];
    self.photoView=photoView;
}


-(void)setUpToolbar
{
    ZWComposToolBar *toolbar=[[ZWComposToolBar alloc]init];
    toolbar.width=self.view.width;
    toolbar.height=44;
    toolbar.delegate=self;
    toolbar.y=self.view.height-toolbar.height;
    [self.view addSubview:toolbar];
    
    self.toolbar=toolbar;
}

-(void)setUpNavgationBar
{
    
    /*设置导航栏上面的内容*/
    //设置左边的返回按钮
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:0 target:self action:@selector(dismiss)];
    //右边
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    rightItem.enabled=NO;
    self.navigationItem.rightBarButtonItem=rightItem;
    
    NSString *name=[ZWAccountTool account].name;
    //设置标题
    if (name) {
    UILabel *titleView=[[UILabel alloc]init];
    titleView.width=200;
    titleView.height=44;
    titleView.textAlignment=NSTextAlignmentCenter;
    titleView.numberOfLines=0;
    
    NSString *prefix=@"发微博";
    NSString *str=[NSString stringWithFormat:@"%@\n%@",prefix,name];
    NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc]initWithString:str];
    [attrStr addAttribute:NSFontAttributeName value:FontSize(16) range:[str rangeOfString:prefix]];
    [attrStr addAttribute:NSFontAttributeName value:FontSize(12) range:[str rangeOfString:name]];
    
    titleView.attributedText=attrStr;
    
    self.navigationItem.titleView=titleView;
    }
    else{
        self.title=@"发微博";
    }
    
}



#pragma mark-添加输入控件
-(void)setUpTextViewd
{
    ZWTextView *textView=[[ZWTextView alloc]init];
    textView.frame=self.view.bounds;
    textView.alwaysBounceVertical=YES;
    textView.font=[UIFont systemFontOfSize:15];
    textView.placeholder=@"分享新鲜事...";
    textView.delegate=self;
    [self.view addSubview:textView];
    self.textView=textView;
    
    [self.textView becomeFirstResponder];
    
    [ZWNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    //键盘监听事件
    [ZWNotificationCenter addObserver:self selector:@selector(keyBoardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //表情选中的通知
    [ZWNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:ZWEmotionDidSelectNotification object:nil];
    
    //删除文字的通知
    [ZWNotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:ZWEmotionDidDeleteNotification object:nil];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-取消
-(void)dismiss
{
    [self.view resignFirstResponder];
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark-发送微博
-(void)compose
{
    if (self.photoView.photos.count) {
        //发布带有图片的
        [self sendWithImage];
    }else
    {
        [self sendWithOutImage];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark-发布带有图片的
-(void)sendWithImage
{
    NSString *urlStr=@"https://upload.api.weibo.com/2/statuses/upload.json";
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    //评价请求参数
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=[ZWAccountTool account].access_token;
    params[@"status"]=self.textView.text;
    
    [mgr POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        UIImage *image=[self.photoView.photos firstObject];
        
        NSData *data=UIImageJPEGRepresentation(image, 1.0);
        
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark-发布没有图片的
-(void)sendWithOutImage
{
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=[ZWAccountTool account].access_token;
    params[@"status"]=self.textView.fullText;
    NSLog(@"%@",self.textView.fullText);
    NSString *urlStr=@"https://api.weibo.com/2/statuses/update.json";
    [ZWHttpTool POST:urlStr parameters:params success:^(id responseObject) {
        
        
        [MBProgressHUD showSuccess:@"发布成功"];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"发布失败"];
        
    }];
}

-(void)dealloc
{
    [ZWNotificationCenter removeObserver:self];
}

#pragma mark-文本框内容发生改变调用
-(void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled=self.textView.hasText;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark-通知事件
-(void)emotionDidDelete
{
    [self.textView deleteBackward];
    
}

//表情被选中了
-(void)emotionDidSelect:(NSNotification *)notification
{
  
   ZWEmotion *emotion= notification.userInfo[ZWSelectedEmotionKey];
   
    [self.textView insertEmotion:emotion];
}

-(void)keyBoardFrameChanged:(NSNotification *)notification
{
    
    if (self.switchKeyboardYoR) return;
    
    NSDictionary *userInfo=notification.userInfo;
    double duration=[userInfo[@"UIKeyboardAnimationDurationUserInfoKey"]doubleValue];
    //键盘的frame
    CGRect keyboardF=[userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        if (keyboardF.origin.y>self.view.height) {
            self.toolbar.y=self.view.height-self.toolbar.height;
        }
        else{
            self.toolbar.y=keyboardF.origin.y-self.toolbar.height;
        }
    }];
}

-(void)composeToolBar:(ZWComposToolBar *)toolbar didClickButton:(ZWToolBarType)buttonType
{

//    NSLog(@"%ld",index);
    switch (buttonType) {
        case ZWToolBarTakePhoto://照相
            NSLog(@"照相");
            [self openCamera];
            
            break;
        case ZWToolBarGetPicture://照片
             NSLog(@"照片");
            [self openAlbum];
            break;
        case ZWToolBarAtSomeBody://@
             NSLog(@"@");
            break;
        case ZWToolBarShareSomething://#
             NSLog(@"#");
            break;
        case ZWToolBarSmile://表情
             NSLog(@"表情");
            [self switchKeyboard];
            break;
        default:
            break;
    }
}

#pragma mark-选择表情
/**
 *  进行键盘的切换
 */
-(void)switchKeyboard
{
    if (self.textView.inputView==nil) {
        //替换键盘
//        ZWEmotionKeyboard *emotionKeyboard=[[ZWEmotionKeyboard alloc]init];
        self.textView.inputView=self.emotionKyeboard;
        
        //显示键盘图片
        self.toolbar.isshowKeyBoard=YES;
    }
    else{
        self.textView.inputView=nil;
        
        //显示表情图标
         self.toolbar.isshowKeyBoard=NO;
    }
    
    //开始切换键盘
    self.switchKeyboardYoR=YES;
    
    //退出键盘
    [self.view endEditing:YES];
    
    //结束切换键盘
    self.switchKeyboardYoR=NO;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //弹出键盘
        [self.textView becomeFirstResponder];
        
        self.switchKeyboardYoR=NO;
    });
}

#pragma mark-拍照
-(void)openCamera
{
    [self openImagePickViewController:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark-相册
-(void)openAlbum
{
    [self openImagePickViewController:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void)openImagePickViewController:(UIImagePickerControllerSourceType)type
{

    if (![UIImagePickerController isSourceTypeAvailable:type])  return;
    
    UIImagePickerController *ipc=[[UIImagePickerController alloc]init];
    
    ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    ipc.delegate=self;
    
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark-UIImagePickerController Delegate
//从相册中选择完照片后调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *selecedImg=info[UIImagePickerControllerOriginalImage];
    
    //添加图片到photoView中
    [self.photoView addPhoto:selecedImg];
    
    
}


@end
