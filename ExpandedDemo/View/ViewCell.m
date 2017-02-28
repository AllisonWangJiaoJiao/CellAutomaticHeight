//
//  ViewCell.m
//  MasonryDemo
//
//  Created by SIMPLE PLAN on 16/3/24.
//  Copyright © 2016年 SIMPLE PLAN. All rights reserved.
//

#import "ViewCell.h"
#import "Masonry.h"


@implementation ViewCell

- (void)awakeFromNib {
    
}

#pragma mark - 初始化TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.backgroundColor = [UIColor greenColor];
        imgView.layer.cornerRadius = 35;
        imgView.layer.borderColor = [UIColor redColor].CGColor;
        imgView.layer.borderWidth = 1.0;
        [self.contentView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(70, 70));
            make.top.mas_equalTo(15);
        }];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        self.titleLabel.numberOfLines = 0;
       
        self.titleLabel.preferredMaxLayoutWidth = w - 100 - 15;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imgView.mas_right).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(imgView);
        }];
        
        self.descLabel = [[UILabel alloc] init];
        self.descLabel.textColor = [UIColor blackColor];
        self.descLabel.font = [UIFont systemFontOfSize:13];
        self.descLabel.numberOfLines = 0;
        self.descLabel.textAlignment = NSTextAlignmentLeft;
        self.descLabel.numberOfLines = 0;
        
        self.descLabel.preferredMaxLayoutWidth = w - 100 - 15;
        [self.contentView addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imgView.mas_right).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        }];
        self.descLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
        [self.descLabel addGestureRecognizer:tap];
        
        UILabel *lineLabel = [[UILabel alloc] init];
        lineLabel.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:lineLabel];
        [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLabel.mas_bottom).offset(19.5);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
        self.lineLabel = lineLabel;
    }
    
    return self;
}

- (void)configCellWithModel:(ViewModel *)model {
    self.model = model;
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
    //打印Bool值
    NSLog(@"isExpanded value: %@" ,model.isExpanded?@"YES":@"NO");
    
    if (model.isExpanded) {
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        }];
    } else {
        [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(self.titleLabel);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
            make.height.mas_equalTo(40);
        }];
    }
    
    NSLog(@"%@",self.descLabel);
    
}

- (void)onTap {
    
    //每次点击都会改变Bool值
    self.model.isExpanded = !self.model.isExpanded;
    
    if (self.block) {
        self.block(self.indexPath);
    }
    
    [self configCellWithModel:self.model];
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:1 animations:^{
        [self.contentView layoutIfNeeded];
    }];
}

+ (CGFloat)heightWithModel:(ViewModel *)model {
    ViewCell *cell = [[ViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    [cell configCellWithModel:model];
    
    [cell layoutIfNeeded];
    
    CGRect frame =  cell.descLabel.frame;
    return frame.origin.y + frame.size.height + 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
