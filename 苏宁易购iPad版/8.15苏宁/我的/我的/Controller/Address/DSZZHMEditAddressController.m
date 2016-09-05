//
//  DSZZHMEditAddressController.m
//  8.1苏宁ipad
//
//  Created by app01 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZHMEditAddressController.h"
#import "FMDB.h"
#import "Common.h"
#import "DSZZHMProvinceModel.h"
#import "DSZZHMCityModel.h"

@interface DSZZHMEditAddressController ()

//方便给pickView的每段每行赋值
@property(retain,nonatomic)NSArray *citys;
@property(retain,nonatomic)NSArray *districts;


//数据库对象
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *queue;

//用于向数据库添加数据
//用户姓名
@property(copy,nonatomic)NSString *username;
//用户电话
@property(copy,nonatomic)NSString *userTel;
//用户地址
@property(copy,nonatomic)NSString *userAddress;
//用户详细地址
@property(copy,nonatomic)NSString *userDetailAddress;

@property(copy,nonatomic)NSString *userdefaultAddress;
@end


@implementation DSZZHMEditAddressController

-(instancetype)init{
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"My" bundle:nil];
    DSZZHMEditAddressController *vc = [story instantiateViewControllerWithIdentifier:@"edit"];
    return vc;
}


-(void)viewWillLayoutSubviews{
    
    _changeAddress.hidden = YES;
    _detail.top = _AddressCell.bottom;
    _detaultCellLine.hidden = YES;
    _defaultCell.top = _detail.bottom+22;
    
    //在这里给数组赋值，防止setInfor被多次调用数组内有重复的值
    _infoArray = [[NSArray alloc]init];
    _infoArray = [self infoArray];
    
    
//    //设置地址标签默认为pickView的第一行
//    DSZZHMProvinceModel *p = _infoArray[0];
//    _province.text = p.province;
//    NSArray *c = p.citys;
//    DSZZHMCityModel *m = c[0];
//    _city.text = m.city;
//    _district.text = m.district[0];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    // 0.获得沙盒中的数据库文件名
    NSString *filename = [NSString stringWithFormat:@"%@/Documents/resgist.sqlite",NSHomeDirectory()];
    //NSLog(@"%@",filename);
    
    // 1.创建数据库队列
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    
    // 2.创表 队列queue对象会自动创建数据库FMDatabase实例 该数据库实例是加过锁的实例 具有线程安全性
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists adress (  name text, tel text primary key, address text,detailAddress text ,defaultAddress text);"];
        
    }];

    
  }


-(NSArray *)infoArray{
    
    NSArray *array = [DSZZHMProvinceModel modelArrayWithFilename:@"city.plist"];
    _infoArray = array;
    return  _infoArray;
}



//完成编辑时保存数据
-(void)finish{
    
    _username = _name.text;
    _userTel = _tel.text;
    NSString *string = [NSString stringWithFormat:@"%@ %@ %@",_province.text,_city.text,_district.text];
    _userAddress = string;
    _userDetailAddress =  _detailAddress.text;
    if (_defaultAddressBtn.on) {
        _userdefaultAddress = @"1";
    }else{
        _userdefaultAddress = @"0";
    }
    
    
    if (_userAddress.length == 0 ||_username.length == 0 || _userTel.length == 0 || _userDetailAddress.length == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"添加失败，请完善信息" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"addError" object:@"error"];
        
        return;
    }
    //判断手机号是否合理
    NSString *str = [_userTel substringToIndex:2];
    if (!([str isEqualToString:@"13"]||[str isEqualToString:@"15"]||[str isEqualToString:@"18"]||[str isEqualToString:@"14"])) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你的手机号真长这样么" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"addError" object:@"error"];
        return;
    }
    if (_userTel.length != 11) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你的手机号这么长真的好么" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"addError" object:@"error"];
        return;
    }

    
    //插入数据
    
    if ([_userdefaultAddress isEqualToString:@"1" ]) {

        [self.queue inDatabase:^(FMDatabase *db) {
           [db executeUpdate:@"update adress set defaultAddress = '0' where  defaultAddress = '1'"];
        }];
    
    }

    
    [self.queue inDatabase:^(FMDatabase *db) {
        
    [db executeUpdate:@"insert or replace into adress (name,tel,address,detailaddress,defaultAddress ) values (?, ?,?,?,?);",_username , _userTel,_userAddress,_userDetailAddress ,_userdefaultAddress];
        
    }];
    
    
}



//点击改变地址
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    if (_flag == NO) {
        _changeAddress.hidden = NO;
        _detail.top = _changeAddress.bottom;
        _detaultCellLine.hidden = NO;
        _defaultCell.top = _detail.bottom+22;
        [_arrowBtn setImage:[UIImage imageNamed:@"cellUp.png"] forState:UIControlStateNormal];
        _flag = YES;
        
    }else{
        _changeAddress.hidden = YES;
        _detail.top = _AddressCell.bottom;
        _detaultCellLine.hidden = YES;
        _defaultCell.top = _detail.bottom+22;
        [_arrowBtn setImage:[UIImage imageNamed:@"cellDown.png"] forState:UIControlStateNormal];
        _flag = NO;
    }
    
}

//分几个转盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return  3;
}

//转盘中有几行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    DSZZHMProvinceModel *provinceModel = [[DSZZHMProvinceModel alloc]init];
    DSZZHMCityModel *cityModel = [[DSZZHMCityModel alloc]init];
    
    if (component == 0) {
        return _infoArray.count;
    }if (component == 1) {
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        provinceModel = _infoArray[selectedRow];
        _citys = provinceModel.citys;
        return _citys.count;
    }else{
        NSInteger selectedRow = [pickerView selectedRowInComponent:1];
        cityModel = _citys[selectedRow];
        NSArray *district = cityModel.district;
        _districts = district;
        return district.count;
    }
    
}


//每行的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    
    DSZZHMCityModel *modle = [[DSZZHMCityModel alloc]init];
    
    if (component == 0) {
        DSZZHMProvinceModel *modle = _infoArray[row];
        return modle.province;
    }
    if (component == 1) {
        modle = _citys[row];
        return modle.city;
    }
    return _districts[row];
    
}

//选中某时各个标签的变化
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
   
   
    if (component == 0) {
        
        [pickerView reloadComponent:1];
        //选择指定的item
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        [pickerView reloadComponent:2];
        //选择指定的item
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        DSZZHMProvinceModel *p = _infoArray[row];
        _province.text = p.province;
        DSZZHMCityModel *c = _citys[0];
        _city.text = c.city;
        _district.text = _districts[0];
        
    }
    if (component == 1) {
        //[pickerView selectRow:0 inComponent:1 animated:YES];
        
        [pickerView reloadComponent:2];
        //选择指定的item
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        DSZZHMCityModel *c = _citys[row];
        _city.text = c.city;
        _district.text = _districts[0];
        

        
    }else{
        
        [pickerView selectRow:row inComponent:2 animated:YES];
        _district.text = _districts[row];
    }
    
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
