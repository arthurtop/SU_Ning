//
//  DSZZYGAddressCell.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZZYGDataBase;
@class DSZZYGAddressCell;
@protocol DSZZYGAddressCellDelegate <NSObject>

-(void)pushEdit:(NSString*)string;
-(void)loadTable;

@end
@interface DSZZYGAddressCell : UITableViewCell<UIAlertViewDelegate>
{
    DSZZYGDataBase *base;
}
@property (weak, nonatomic) IBOutlet UILabel *peoplename;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addresslabel;
@property (weak, nonatomic) IBOutlet UIButton *addressselectBtn;

- (IBAction)selectAction:(UIButton *)sender;
- (IBAction)EditAddress:(UIButton *)sender;

@property(weak,nonatomic)id <DSZZYGAddressCellDelegate>delegate;

-(void)setcell:(NSDictionary*)dict;
@end
