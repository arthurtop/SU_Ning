//
//  DSZSYFejModel.m
//  8.2二级界面
//
//  Created by lovena on 15/8/2.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZSYFejModel.h"

@implementation DSZSYFejModel

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_title forKey:@"_title"];
    [encoder encodeDouble:_list_price forKey:@"_list_price"];
    [encoder encodeObject:_purchase_deadline forKey:@"_purchase_deadline"];
    [encoder encodeObject:_deal_id forKey:@"_deal_id"];
    [encoder encodeObject:_image_url forKey:@"_image_url"];
    [encoder encodeObject:_desc forKey:@"_desc"];
    [encoder encodeDouble:_current_price forKey:@"_current_price"];
    [encoder encodeObject:_purchase_count forKey:@"_purchase_count"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        self.title = [decoder decodeObjectForKey:@"_title"];
        self.list_price = [decoder decodeDoubleForKey:@"_list_price"];
        
        self.purchase_deadline = [decoder decodeObjectForKey:@"_purchase_deadline"];
        self.deal_id = [decoder decodeObjectForKey:@"_deal_id"];
        self.image_url = [decoder decodeObjectForKey:@"_image_url"];
        self.desc = [decoder decodeObjectForKey:@"_desc"];
        self.current_price = [decoder decodeDoubleForKey:@"_current_price"];
        self.purchase_count = [decoder decodeObjectForKey:@"_purchase_count"];
    }
    return self;
}




@end
