//
//  DACAddressLIstView.h
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DACAddressModel.h"
@interface DACAddressLIstView : UIView<UITableViewDataSource,UITableViewDelegate>

+(id)createAddressListView;

- (IBAction)returnClick;

- (IBAction)addAddressClick;

@property (weak, nonatomic) IBOutlet UITableView *addressTableView;

@property(nonatomic,strong)NSArray *total;

@end
