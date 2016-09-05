//
//  DSZZYGShopHeaderView.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGShopHeaderView.h"
#import "DSZZYGShopModel.h"
#import "MJExtension.h"
 NSMutableArray *ZYGheaderarray;
@implementation DSZZYGShopHeaderView
+(void)initialize{
    ZYGheaderarray=[[NSMutableArray alloc]init];
}

+(instancetype)loadNib{
    return [[[NSBundle mainBundle]loadNibNamed:@"DSZZYGShopHeader" owner:nil options:nil]lastObject];
}

-(NSMutableArray*)allHeader:(NSMutableArray*)array dict:(NSMutableDictionary *)dic shop:(DSZZYGShopModel*)model{
    _allHeader=array;
    ZYGheaderarray=_allHeader;
    self.selectHeader.selected=NO;
    if ([self.shopmodel.shopname isEqualToString:model.shopname]) {
        NSString *string=dic[model.shopname];
        int i=[string intValue];
        if (i==0) {
             [[NSNotificationCenter defaultCenter]postNotificationName:@"shopselect" object:nil userInfo:@{@"array":ZYGheaderarray}];
        }
        
    }
    if (dic==nil) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shopselect" object:nil userInfo:@{@"array":ZYGheaderarray}];
    }
   
    return _allHeader;
}


//选择点击方法
- (IBAction)selectHeaderView:(UIButton *)sender {

     NSString *string=self.nameLabel.text;
    if (_selectHeader.selected==YES) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shopdele" object:nil userInfo:@{@"name":string}];
        }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:@"shopselect" object:nil userInfo:@{@"name":string}];
     }
}



-(void)setheader:(NSArray*)array{
    NSString *name;
    BOOL allselect=YES;
    for (NSDictionary *dic in array) {
         name=dic[@"storename"];
        if ([dic[@"selectthing"] intValue]==0) {
            allselect=NO;
            break;
        }
    }
    self.nameLabel.text=name;
    if (allselect) {
        self.selectHeader.selected=YES;
    }else{
        self.selectHeader.selected=NO;
    }
    
}
@end
