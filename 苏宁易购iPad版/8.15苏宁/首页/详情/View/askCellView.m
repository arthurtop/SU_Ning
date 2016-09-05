//
//  askCellView.m
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "askCellView.h"

@implementation askCellView


+(id)createAskCell
{
    return [[[NSBundle mainBundle]loadNibNamed:@"askCellView" owner:nil options:nil]lastObject];
}

-(void)setModel:(askModel *)model
{
    _model = model;
    self.userName.text = _model.username;
    self.userQuestion.text = _model.question;
    self.time.text = _model.time;
    self.answer.text = _model.answer;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goodClick {
    _goodButton.selected = YES;
}
- (IBAction)notGoodClick {
    self.notGoodButton.selected = YES;
}
@end
