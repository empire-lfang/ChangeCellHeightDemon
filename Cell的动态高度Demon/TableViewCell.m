//
//  TableViewCell.m
//  Cell的动态高度Demon
//
//  Created by daoxiu on 16/8/2.
//  Copyright © 2016年 aowokeji. All rights reserved.
//

#import "TableViewCell.h"
#import "CellModel.h"
#import "UIView+Extension.h"
@interface TableViewCell()
@property(nonatomic,weak)UIImageView *cellImageView;
@property(nonatomic,weak)UILabel *nameLab;
@property(nonatomic,weak)UIImageView *bottomImageView;
@property(nonatomic,weak)UIButton *clickBtn;

@end
@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *cellIamgeView = [[UIImageView alloc]init];
        [self.contentView addSubview:cellIamgeView];
        self.cellImageView = cellIamgeView;
        
        UILabel *nameLab = [[UILabel alloc]init];
        nameLab.textColor = [UIColor greenColor];
        [self.contentView addSubview:nameLab];
        self.nameLab = nameLab;
        
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clickBtn.backgroundColor = [UIColor blueColor];
        clickBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [clickBtn setTitle:@"点我看大的" forState:UIControlStateNormal];
        [self.contentView addSubview:clickBtn];
        
        [clickBtn addTarget:self action:@selector(changeCellHeight:event:) forControlEvents:UIControlEventTouchUpInside];
        clickBtn.selected = NO;
        self.clickBtn = clickBtn;
        
        UIImageView *bottomImageView = [[UIImageView alloc]init];
        bottomImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:bottomImageView];
        self.bottomImageView = bottomImageView;
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat space = 10;
    CGFloat nameX = space;
    CGFloat nameY = space;
    CGFloat nameW = 80;
    CGFloat nameH = 20;
    self.nameLab.frame = CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat cellImgX = space;
    CGFloat cellImgY = self.nameLab.bottom + space;
    CGFloat cellImgW = 40;
    CGFloat cellImgH = cellImgW;
    self.cellImageView.frame = CGRectMake(cellImgX, cellImgY, cellImgW, cellImgH);
    
    CGFloat clickX   = self.cellImageView.right + space;
    CGFloat clickY   = self.nameLab.bottom + space;
    CGFloat clickW   = 100;
    CGFloat clickH   = 40;
    self.clickBtn.frame = CGRectMake(clickX, clickY, clickW, clickH);
    
    if (self.model.isHiden) {
        self.bottomImageView.hidden = YES;
    }else{
        CGFloat bottomY = self.cellImageView.bottom + space;
        CGFloat bottomW = self.width;
        CGFloat bottomH = 150;
        self.bottomImageView.frame  = CGRectMake(0, bottomY,bottomW , bottomH);
    }
}
-(void)setModel:(CellModel *)model{
    _model = model;
    self.nameLab.text = model.name;
    self.cellImageView.image = [UIImage imageNamed:model.imgUrl];
    
    if(_model.isHiden){
        self.bottomImageView.hidden = YES;
    }else{
        self.bottomImageView.hidden = NO;
        self.bottomImageView.image = [UIImage imageNamed:model.imgUrl];
    }
    if (_model.isClick) {
        [self.clickBtn setTitle:@"再点收起来" forState:UIControlStateNormal];
    }else{
        [self.clickBtn setTitle:@"点我看大的" forState:UIControlStateNormal];
    }
}
-(void)changeCellHeight:(UIButton*)sender event:(id)event{
    BOOL selected = !self.model.isClick;
    if (selected) {
        [self.clickBtn setTitle:@"再点收起来" forState:UIControlStateNormal];
    }else{
        [self.clickBtn setTitle:@"点我看大的" forState:UIControlStateNormal];
    }
    
    NSSet *set              = [event allTouches];
    UITouch *touch          = [set anyObject];
    CGPoint point           = [touch locationInView:self.tableView];
    NSIndexPath *index  = [self.tableView indexPathForRowAtPoint:point];
    self.block(selected,index);
}
@end
