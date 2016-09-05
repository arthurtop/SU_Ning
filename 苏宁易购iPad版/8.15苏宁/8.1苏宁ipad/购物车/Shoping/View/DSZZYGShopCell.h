//
//  DSZZYGShopCell.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZZYGThingsModel;
@class DSZZYGShopModel;
@class DSZZYGShopCell;
@class DSZZYGshopDatabase;
@protocol DSZZYGShopCellDelegate <NSObject>

-(void)tabledata;

@end


@interface DSZZYGShopCell : UITableViewCell<UIAlertViewDelegate>
{
    DSZZYGshopDatabase *shopdata;
}
//输出口
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *thingimage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *number;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property(assign,nonatomic)NSString *thingid;

@property(weak,nonatomic)DSZZYGShopModel   *shopmodel;
@property(weak ,nonatomic)DSZZYGThingsModel *thingmodel;
//点击btn
- (IBAction)deleNum:(id)sender;
- (IBAction)addNum:(id)sender;
- (IBAction)select:(UIButton *)sender;


//cell设置
-(void)setcell:(NSDictionary*)dic;


//
@property(nonatomic,weak)id<DSZZYGShopCellDelegate>delegate;
@end
