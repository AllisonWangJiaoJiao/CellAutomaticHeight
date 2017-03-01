//
//  HYBNewsCell.h
//  CellAutoHeightDemo
//
//  Created by huangyibiao on 15/9/1.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewModel;

typedef void(^HYBExpandBlock)(BOOL isExpand);

@interface HYBNewsCell : UITableViewCell

@property (nonatomic, copy) HYBExpandBlock expandBlock;

- (void)configCellWithModel:(ViewModel *)model;

@end
