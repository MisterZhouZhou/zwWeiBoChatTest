//
//  ZWHomeTableViewCell.h
//  ZW微博
//
//  Created by rayootech on 16/1/31.
//  Copyright © 2016年 rayootech. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWHomeFrame;
@interface ZWHomeTableViewCell : UITableViewCell

@property(nonatomic,strong)ZWHomeFrame *statusF;

+(instancetype)cellWithTableView:(UITableView *)tableview;

@end
