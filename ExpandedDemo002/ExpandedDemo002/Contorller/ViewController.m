//
//  ViewController.m
//  ExpandedDemo
//
//  Created by Allison on 17/2/23.
//  Copyright © 2017年 Allison. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "ViewModel.h"
#import "ViewCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "HYBNewsCell.h"
#import "YYFPSLabel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation ViewController
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"ExpandedDemo";
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 5, 60, 30)]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];

    for (NSUInteger i = 0; i<1000; i++) {
        
        ViewModel *model = [[ViewModel alloc]init];
        model.title=  @"我喜欢出发--汪国真-散文-我喜欢出发--汪国真-散文";
        model.desc = @"凡是到达了的地方，都属于昨天。哪怕那山再青，那水再秀，那风再温柔。太深的流连便成了一种羁绊，绊住的不仅有双脚，还有未来。\n 怎么能不喜欢出发呢？没见过大山的巍峨，真是遗憾；见了大山的巍峨没见过大海的浩瀚仍然遗憾；见了大海的浩瀚没见过大漠的广袤，依旧遗憾；见了大漠的广袤没见过森林的神秘，还是遗憾。世界上有不绝的风景，我有不老的心情。\n 我自然知道，大山有坎坷，大海有浪涛，大漠有风沙，森林有猛兽。即便这样，我依然喜欢。\n 打破生活的平静便是另一番景致，一种属于年轻的景致。真庆幸，我还没有老。即便真老了又怎么样，不是有句话叫老当益壮吗?\n 于是，我还想从大山那里学习深刻，我还想从大海那里学习勇敢，我还想从大漠那里学习沉着，我还想从森林那里学习机敏。我想学着品味一种缤纷的人生。\n 人能走多远？这话不是要问两脚而是要问志向；人能攀多高？这事不是要问双手而是要问意志。于是，我想用青春的热血给自己树起一个高远的目标。不仅是为了争取一种光荣，更是为了追求一种境界。目标实现了，便是光荣；目标实现不了，人生也会因这一路风雨跋涉变得丰富而充实；在我看来，这就是不虚此生。\n 是的，我喜欢出发，愿你也喜欢。";
        model.isExpanded = YES;
        [self.dataSource addObject:model];
        
    }
    
    
    [self.tableView reloadData];

}

#pragma mark -UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    HYBNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[HYBNewsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ViewModel *model = nil;
    if (indexPath.row < self.dataSource.count) {
        model = [self.dataSource objectAtIndex:indexPath.row];
    }
    [cell configCellWithModel:model];
    
    cell.expandBlock = ^(BOOL isExpand) {
        model.isExpanded = isExpand;
        [tableView reloadRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    };
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewModel *model = nil;
    if (indexPath.row < self.dataSource.count) {
        model = [self.dataSource objectAtIndex:indexPath.row];
    }
    
    NSString *stateKey = nil;
    if (model.isExpanded) {
        stateKey = @"expanded";
    } else {
        stateKey = @"unexpanded";
    }
    
    return [HYBNewsCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        HYBNewsCell *cell = (HYBNewsCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%d", model.uid],
                 kHYBCacheStateKey : stateKey,
                 // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
                 // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
                 kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
                 };
    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
