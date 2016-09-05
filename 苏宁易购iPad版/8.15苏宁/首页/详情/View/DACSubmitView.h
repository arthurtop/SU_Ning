//
//  DACSubmitView.h
//  8.2二级界面
//
//  Created by mini on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DACSubmitView : UIView<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)returnClick;

+(id)createSubmitView;
@end
