//
//  DSZZYGShopHeaderView.h
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSZZYGShopModel;

@interface DSZZYGShopHeaderView : UIView

@property (assign, nonatomic)  BOOL sele;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectHeader;

@property(weak ,nonatomic)NSMutableArray *allHeader;
@property(weak,nonatomic)DSZZYGShopModel   *shopmodel;
- (IBAction)selectHeaderView:(UIButton *)sender;

-(void)setheader:(NSArray*)array;
+(instancetype)loadNib;
-(NSMutableArray*)allHeader:(NSMutableArray*)array dict:(NSMutableDictionary *)dic shop:(DSZZYGShopModel*)model;
@end
