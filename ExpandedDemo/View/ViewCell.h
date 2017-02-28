//
//  ViewCell.h
//  MasonryDemo
//
//  Created by SIMPLE PLAN on 16/3/24.
//  Copyright © 2016年 SIMPLE PLAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewModel.h"

typedef void(^TestBlock)(NSIndexPath *indexPath);

@interface ViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) ViewModel *model;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) TestBlock block;

- (void)configCellWithModel:(ViewModel *)model;

+ (CGFloat)heightWithModel:(ViewModel *)model;

@end
