//
//  DSZCityController.m
//  8.2二级界面
//
//  Created by app33 on 15/8/4.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "DSZCityController.h"
#import "CityModel.h"
#import "areaModel.h"
#import "MJExtension.h"
@interface DSZCityController ()
{
    NSString *city;
    NSString *city2;
    NSString *area;
}
@end

@implementation DSZCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加拾取器
    _pickerView = [[UIPickerView alloc]init];
    _pickerView.frame = CGRectMake(0, 0, 360, 200);
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
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
    [self.view addSubview:_pickerView];
}

-(DACLocationModel *)locate
{
    if (_locate == nil) {
        _locate = [[DACLocationModel alloc] init];
    }
    
    return _locate;
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
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView reloadComponent:1];
            
            _areas = [[_cities objectAtIndex:0] objectForKey:@"areas"];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            [self.pickerView reloadComponent:2];
            
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
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            [self.pickerView reloadComponent:2];
            
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
    if (_add!=nil) {
        _add(self.locate.state,self.locate.city,self.locate.district);
    }
    
    
}




//-(NSArray*)total
//{
//    _total = [NSArray array];
//    _total = [CityModel modelArrayWithFilename:@"area.plist"];
//    return _total;
//}
//
//-(NSArray*)total2
//{
//    _total2 = [NSMutableArray array];
//    NSArray *array = self.total;
//    for (NSDictionary *dic in array) {
//        areaModel *model = [[areaModel alloc]initWithDic:dic];
//        [_total2 addObject:model];
//    }
//    return _total2;
//}
////一共有多少行
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 3;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    NSInteger count = 0;
//    if (component==0) {
//        //返回所有省份
//        count = self.total.count;
//       // NSLog(@"%d",self.total.count);
//    }
//    if (component==1) {
//        //返回选中的省份有多少市
//        NSInteger index = [pickerView selectedRowInComponent:0];//选中哪一个省
//        CityModel *model = self.total[index];//取出模型
//        count = model.cities.count;
//        // NSLog(@"%d",model.cities.count);
//    }
//    if (component==2) {
//        NSInteger index = [pickerView selectedRowInComponent:0];//选中哪一个省
//        CityModel *model = self.total[index];//取出模型
//        NSInteger index2 = [pickerView selectedRowInComponent:1];
//        NSDictionary *dic = model.cities[index2];
//        areaModel *model2 = [[areaModel alloc]initWithDic:dic];
//        count = model2.areas.count;
//       // NSLog(@"%d",count);
//    }
//    return count;
//}
//
//#pragma mark 设置数据
//-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *str;
//    if (component==0) {
//        CityModel *model = self.total[row];
//        str = model.state;
//        [pickerView reloadComponent:1];
//    }
//    else if (component==1) {
//        [pickerView reloadComponent:2];//刷新第二行数据
//       // [pickerView selectRow:0 inComponent:2 animated:YES];
//        NSInteger inr = [pickerView selectedRowInComponent:0];
//        CityModel *model = self.total[inr];
//        NSDictionary *dic = model.cities[row];
//        areaModel *model2 = [[areaModel alloc]initWithDic:dic];
//        str = model2.city;
//        
//    }
//     else {
//        NSInteger inr = [pickerView selectedRowInComponent:0];
//        CityModel *model = self.total[inr];
//        NSDictionary *dic = model.cities[row];
//         NSInteger city1 = model.cities.count;
//        areaModel *model2 = [[areaModel alloc]initWithDic:dic];
//        // NSInteger row2 = [pickerView selectedRowInComponent:1];
//         NSInteger city2 = model2.areas.count;
//         if (row<=city2-1) {
//             str = model2.areas[row];
//            // NSLog(@"%@",str);
//         }
//        
//    }
//    return str;
//}
//
//#pragma mark 监听选中了某一列的某一行
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//   
//    if (component == 0) { // 改变了省份
//        // 刷新第1列的数据(重新刷新数据，重新调用数据源和代理的相应方法获得数据)
//        [pickerView reloadComponent:1];
//        //取出模型
//        CityModel *model = self.total[row];
//        city = model.state;
//        // 选中第1列的第0行
//        [pickerView selectRow:0 inComponent:1 animated:YES];
//    }else if(component==1){
//        [pickerView reloadComponent:2];
//        NSInteger inr = [pickerView selectedRowInComponent:0];
//        CityModel *model = self.total[inr];
//        NSDictionary *dic = model.cities[row];
//        NSInteger city1 = model.cities.count;
//        areaModel *model2 = [[areaModel alloc]initWithDic:dic];
//        city2 = model2.city;
//        // 选中第1列的第0行
//        [pickerView selectRow:0 inComponent:2 animated:YES];
//    }
//    else
//    {
//        NSInteger inr = [pickerView selectedRowInComponent:0];
//        CityModel *model = self.total[inr];
//        NSDictionary *dic = model.cities[row];
//        NSInteger city1 = model.cities.count;
//        areaModel *model2 = [[areaModel alloc]initWithDic:dic];
//        area = model2.areas[row];
//    }
//    _address = [NSString stringWithFormat:@"%@ %@ %@",city,city2,area];
//}


@end
