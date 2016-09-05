//
//  bigIimageController.h
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQModel.h"
@interface bigIimageController : UIViewController


//关闭按钮事件
- (IBAction)closeClick;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;//标题属性

@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;//大的滑动视图

@property (weak, nonatomic) IBOutlet UIScrollView *smallScrollView;

@property(nonatomic,strong)UIImageView *bgImage;

@property(nonatomic,strong)UIImageView *selectImage;//记录选中的背景图

@property(nonatomic,strong)XQModel *model;
@end
