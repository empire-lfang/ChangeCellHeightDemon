//
//  ViewController.m
//  Cell的动态高度Demon
//
//  Created by daoxiu on 16/8/2.
//  Copyright © 2016年 aowokeji. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "CellModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation ViewController
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (int i =0 ; i<10; i++) {
            CellModel *model = [[CellModel alloc]init];
            model.name = [NSString stringWithFormat:@"我是%dcell",i];
            model.isHiden = YES;
            model.isClick = NO;
            model.imgUrl = [NSString stringWithFormat:@"image%d.jpg",i];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
#pragma mark - 数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.tableView = self.tableView;
    cell.model = self.dataSource[indexPath.row];
    
     __weak typeof (self)weakSelf = self;
    cell.block = ^void(BOOL selected,NSIndexPath *index){

        if (selected) {
            CellModel *model = [CellModel new];
            model = weakSelf.dataSource[index.row];
            model.isHiden = NO;
            model.isClick = selected;
            [weakSelf.dataSource replaceObjectAtIndex:index.row withObject:model];
        }else{
            CellModel *newModel = [CellModel new];
            newModel = weakSelf.dataSource[index.row];
            newModel.isHiden = YES;
            newModel.isClick = selected;
            [weakSelf.dataSource replaceObjectAtIndex:index.row withObject:newModel];
        }
        [weakSelf.tableView reloadData];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.dataSource[indexPath.row] cellHeight];
}

@end
