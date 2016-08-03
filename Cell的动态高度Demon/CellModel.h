//
//  CellModel.h
//  Cell的动态高度Demon
//
//  Created by daoxiu on 16/8/2.
//  Copyright © 2016年 aowokeji. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CellModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,assign)BOOL isHiden;
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,assign)BOOL isClick;
@end
