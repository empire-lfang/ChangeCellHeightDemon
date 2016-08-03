//
//  CellModel.m
//  Cell的动态高度Demon
//
//  Created by daoxiu on 16/8/2.
//  Copyright © 2016年 aowokeji. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel
-(CGFloat)cellHeight{
        if (self.isHiden) {
            _cellHeight = 80;
        }else{
            _cellHeight = 230;
        }
    return _cellHeight;
}
@end
