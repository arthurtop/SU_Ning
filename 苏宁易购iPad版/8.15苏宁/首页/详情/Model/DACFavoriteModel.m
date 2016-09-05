//
//  DACFavoriteModel.m
//  8.2二级界面
//
//  Created by mini on 15/8/6.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DACFavoriteModel.h"

@implementation DACFavoriteModel
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:_deal_id forKey:@"dealid"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
        self.deal_id = [aDecoder decodeObjectForKey:@"dealid"];
    }
    return self;
}

@end
