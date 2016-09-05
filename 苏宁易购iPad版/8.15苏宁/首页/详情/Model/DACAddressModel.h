//
//  DACAddressModel.h
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DACAddressModel : NSObject<NSCoding>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,assign)BOOL flag;
@property(nonatomic,assign)BOOL isDefault;
@end
