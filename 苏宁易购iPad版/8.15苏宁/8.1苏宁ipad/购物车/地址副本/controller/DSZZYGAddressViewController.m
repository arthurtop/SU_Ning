//
//  DSZZYGAddressViewController.m
//  8.1苏宁ipad
//
//  Created by app15 on 15/8/4.
//  Copyright (c) 2015年 lovena. All rights reserved.
//

#import "DSZZYGAddressViewController.h"
#import "DSZZYGAddViewController.h"

#import "DSZZYGAddressTopview.h"
#import "DSZZYGAddressCell.h"

#import "DSZZYGDataBase.h"
@interface DSZZYGAddressViewController ()<UITableViewDataSource,UITableViewDelegate,DSZZYGAddressCellDelegate>
{
    NSArray *array;
    BOOL realy;
    UITableView *table;
}
@end

@implementation DSZZYGAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadnav];
    self.title=@"我的收货地址";
    realy=NO;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //数据
    DSZZYGDataBase *daz=[[DSZZYGDataBase alloc]init];
    [daz createDatabase];
    [daz createTable];
    array=[daz query];
    if (array.count==0) {
        [self loadtop];
    }else{
        //表
        [self loadtable];
    }
    realy=YES;
}

-(void)loadnav{
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navBack"] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    left.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem=left;

    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"新增地址" style:UIBarButtonItemStyleDone target:self action:@selector(add)];
    right.tintColor=[UIColor orangeColor];
    self.navigationItem.rightBarButtonItem=right;

}

-(void)loadtop{
    DSZZYGAddressTopview *top=[DSZZYGAddressTopview loadnib];
    self.view=top;
}
-(void)loadtable{
    table=[[UITableView alloc]init];
    if (realy==0) {
        table.frame=CGRectMake(0, 0, 800, self.view.frame.size.height);
    }else{
        table.frame=CGRectMake(0, 64, 800, self.view.frame.size.height);
    }
    
    table.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:table];
    table.delegate=self;
    table.dataSource=self;
    table.separatorStyle=0;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)add{
    DSZZYGAddViewController *add=[[DSZZYGAddViewController alloc]init];
    
    [self.navigationController pushViewController:add animated:NO];
}

#pragma cell代理
-(void)pushEdit:(NSString *)string{
    DSZZYGAddViewController *add=[[DSZZYGAddViewController alloc]init];
    [add cellphone:string];
    [self.navigationController pushViewController:add animated:NO];
}

-(void)loadTable{
    //数据
    DSZZYGDataBase *daz=[[DSZZYGDataBase alloc]init];
    [daz createDatabase];
    [daz createTable];
    array=[daz query];
    [table reloadData];
}
#pragma mark--tabledata
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *string=@"cell";
    DSZZYGAddressCell *cell=[tableView dequeueReusableCellWithIdentifier:string];
    if (cell==nil) {
        cell=[[DSZZYGAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:string];
    }
    NSDictionary *dic=array[indexPath.row];
    [cell  setcell:dic];
    cell.selectionStyle=0;
    cell.delegate=self;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
