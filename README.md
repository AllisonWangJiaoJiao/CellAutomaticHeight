注:demo运行前,会有几秒的空白,因为这里我是在主线程中模拟了1000条数据,所以会有些卡,各位大神莫吐槽,因为重点说的是cell的优化!
在项目中,自动计算cell高度用到的非常多,基本上凡是有表格布局的地方,都会牵扯到cell自动计算的高度.一般情况,如果数据条数比较少的情况下,我们可以用一下方法手动计算    

    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    CGSize size = [commentReplysArry[indexPath.row] boundingRectWithSize:CGSizeMake(tableView.frame.size.width-70-8, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
但是,如果数据量特别大,例如类似朋友圈的那样,就会出现滑动卡顿的现象,而且随着数据量的增多,卡顿会越来越严重.对于这个问题的处理,网上也有很多比较不错的方法,这里我介绍一个标哥的HYBMasonryAutoCellHeight开源三方,使用方法也比较简单,详见<https://github.com/CoderJackyHuang/HYBMasonryAutoCellHeight.git>,里面有具体用法,左边是没有优化的,FPS(每秒刷新的次数)会掉的很快,右边是优化过的,FPS基本保持不变.

优化前:

![Mou icon](http://img.hb.aicdn.com/8b2cc3a9068618c85445ee054f98f68848023a0c383b08-8UXxa8_fw658)

优化后:

![Mou icon](http://img.hb.aicdn.com/b59fa68629055bfd6684b2e005d0872a990109ac2cd1f0-sFLGq5_fw658)
