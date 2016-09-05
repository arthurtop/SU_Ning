//
//  addNewAddressView.h
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addNewAddressView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

- (IBAction)returnClick;

- (IBAction)finishDoneClick;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,assign)BOOL isclick;

@property(nonatomic,strong)NSMutableArray *total;

@property(nonatomic,copy)NSString *addstr;
+(id)createAddNewAddressView;
@end
