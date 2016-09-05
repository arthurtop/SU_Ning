//
//  DSZZYGBtn.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/13.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGBtn.h"
#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"login.data"]
@implementation DSZZYGBtn

-(void)setFrame:(CGRect)frame
{

        CGFloat w=20;
        CGFloat h=20;
    frame.size=CGSizeMake(w, h);
    [super setFrame:frame];
    self.layer.cornerRadius=self.frame.size.width/2;
    self.layer.masksToBounds=YES;
}
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor colorWithRed:249/255.0 green:46/255.0 blue:47/255.0 alpha:1];
        self.titleLabel.font=[UIFont systemFontOfSize:12];
        [self setTintColor:[UIColor whiteColor]];

    }
    //[self hiddenBtn];
    return self;
}

//徽章数量
-(void)buyNumber:(NSInteger)index
{
    _tel = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        if (_tel) {
            if (index==0) {
                 self.hidden=YES;
            }
            else{
            self.hidden=NO;
            [self setTitle:[NSString stringWithFormat:@"%i",index] forState:UIControlStateNormal];
                //NSLog(@"%@",[self titleLabel]);
            }
        }
        else{
            self.hidden=YES;
        }

}


@end
