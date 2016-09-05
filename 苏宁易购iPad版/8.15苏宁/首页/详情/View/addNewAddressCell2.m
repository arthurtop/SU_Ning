//
//  addNewAddressCell2.m
//  8.2二级界面
//
//  Created by app33 on 15/8/5.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "addNewAddressCell2.h"
#import "UIViewExt.h"
@implementation addNewAddressCell2

+(id)createNewAddressCell2
{
    return [[[NSBundle mainBundle]loadNibNamed:@"addNewAddressCell2" owner:nil options:nil]lastObject];
}

-(DACLocationModel *)locate
{
    if (_locate == nil) {
        _locate = [[DACLocationModel alloc] init];
    }
    
    return _locate;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
    self.isClicked = NO;
    _provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    _cities = [[_provinces objectAtIndex:0] objectForKey:@"cities"];
    
    self.locate.state = [[_provinces objectAtIndex:0] objectForKey:@"state"];
    self.locate.city = [[_cities objectAtIndex:0] objectForKey:@"city"];
    
    _areas = [[_cities objectAtIndex:0] objectForKey:@"areas"];
    if (_areas.count > 0) {
        self.locate.district = [_areas objectAtIndex:0];
    } else{
        self.locate.district = @"";
    }
    
    if (self.height==48) {
        _pickView.hidden = YES;
    }
    else
    {
        _pickView.hidden = NO;
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 20;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [_provinces count];
            break;
        case 1:
            return [_cities count];
            break;
        case 2:
            return [_areas count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
            return [[_provinces objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[_cities objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if ([_areas count] > 0) {
                return [_areas objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
            _cities = [[_provinces objectAtIndex:row] objectForKey:@"cities"];
            [self.pickView selectRow:0 inComponent:1 animated:YES];
            [self.pickView reloadComponent:1];
            
            _areas = [[_cities objectAtIndex:0] objectForKey:@"areas"];
            [self.pickView selectRow:0 inComponent:2 animated:YES];
            [self.pickView reloadComponent:2];
            
            self.locate.state = [[_provinces objectAtIndex:row] objectForKey:@"state"];
            self.locate.city = [[_cities objectAtIndex:0] objectForKey:@"city"];
            if ([_areas count] > 0) {
                self.locate.district = [_areas objectAtIndex:0];
            } else{
                self.locate.district = @"";
            }
            break;
        case 1:
            _areas = [[_cities objectAtIndex:row] objectForKey:@"areas"];
            [_pickView selectRow:0 inComponent:2 animated:YES];
            [_pickView reloadComponent:2];
            
            self.locate.city = [[_cities objectAtIndex:row] objectForKey:@"city"];
            if ([_areas count] > 0) {
                self.locate.district = [_areas objectAtIndex:0];
            } else{
                self.locate.district = @"";
            }
            break;
        case 2:
            if ([_areas count] > 0) {
                self.locate.district = [_areas objectAtIndex:row];
            } else{
                self.locate.district = @"";
            }
            break;
        default:
            break;
    }
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",self.locate.state,self.locate.city,self.locate.district];
    NSUserDefaults *defaluts = [NSUserDefaults standardUserDefaults];
    [defaluts setObject:[NSString stringWithFormat:@"%@ %@ %@",self.locate.state,self.locate.city,self.locate.district] forKey:@"str"];
    [defaluts synchronize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
