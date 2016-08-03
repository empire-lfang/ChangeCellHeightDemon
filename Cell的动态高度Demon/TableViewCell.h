//
//  TableViewCell.h
//  Cell的动态高度Demon
//
//  Created by daoxiu on 16/8/2.
//  Copyright © 2016年 aowokeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellModel;
typedef void(^Block)(BOOL,NSIndexPath*);
@interface TableViewCell : UITableViewCell
@property(nonatomic,strong)CellModel *model;
@property(nonatomic,copy)Block block;
@property(nonatomic,weak)UITableView *tableView;
@end
