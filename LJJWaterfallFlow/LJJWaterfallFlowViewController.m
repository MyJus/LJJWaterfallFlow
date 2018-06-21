//
//  LJJWaterfallFlowViewController.m
//  LJJWaterfallFlow
//
//  Created by peony on 2018/6/21.
//  Copyright © 2018年 peony. All rights reserved.
//

#import "LJJWaterfallFlowViewController.h"
#import "LJJWaterfallView.h"

@interface LJJWaterfallFlowViewController ()

@property(nonatomic,strong)LJJWaterfallView *fview;
@property(nonatomic,retain)NSMutableArray *dataArray;

@end

@implementation LJJWaterfallFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"瀑布流";
    [self creatView];
}
- (LJJWaterfallView *)creatView{
    if (_fview == nil) {
        __weak typeof(self) weakSelf = self;
        _fview = [[LJJWaterfallView alloc] init];//也可以使用initWithFrame创建
        
        //注册cell,默认 UICollectionViewCell
        _fview.registerClassCell = @"TestCell";
        
        NSDictionary *infoDic = nil;
        if (self.infoBlock) {
            infoDic = self.infoBlock();
        }
        
        //设置参数
        _fview.setParamBlock = ^(LJJWaterfallLayout *layout) {
            //设置三列
            layout.columnCount = infoDic != nil ? [[infoDic objectForKey:@"columnCount"] integerValue] : 2;
            //设置间距
            layout.rowSpacing = infoDic != nil ? [[infoDic objectForKey:@"rowSpace"] floatValue] : 5.0;
            layout.columnSpacing = infoDic != nil ? [[infoDic objectForKey:@"columnSpace"] floatValue] : 5.0;
            //设置偏移
            layout.sectionInset = infoDic != nil ? UIEdgeInsetsMake([[infoDic objectForKey:@"top"] floatValue], [[infoDic objectForKey:@"left"] floatValue], [[infoDic objectForKey:@"bottom"] floatValue], [[infoDic objectForKey:@"right"] floatValue]) : UIEdgeInsetsZero;
        };
        
        //返回每个item的高度
        _fview.itemHeightBlock = ^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
            return [weakSelf.dataArray[indexPath.row][@"ratio"] floatValue] *itemWidth + 20;
        };
        
        //返回总个数
        _fview.numberOfRowsBlock = ^NSInteger{
            return weakSelf.dataArray.count;
        };
        
        //返回设置cell
        _fview.cellDataBlock = ^id(UICollectionViewCell *cell, NSIndexPath *indexPath) {
            /*
             1.直接设置cell
             或者
             2.也可以在cell遵循协议执行方法：
             - (void)updateData:(id)data indexPath:(NSIndexPath *)indexPath;
             */
            return weakSelf.dataArray[indexPath.row];
        };
        
        //点击cell
        _fview.didSelectAtIndexPathBlock = ^(NSIndexPath *indexPath) {
            NSLog(@"%ld",indexPath.row);
        };
        
        [self.view addSubview:_fview];
        
        //获取数据后刷新
        [_fview reloadData];
    }
    return _fview;
}



- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 100; ++i) {
            int index = arc4random()% 12 + 1;
            float ratio = ((arc4random() % 13) + 3.0) / 10.0;
            [self.dataArray addObject:@{@"title":[NSString stringWithFormat:@"第%d个",i],
                                        @"image":[NSString stringWithFormat:@"timg%d.jpg",index],
                                        @"ratio":[NSString stringWithFormat:@"%f",ratio]}];
        }
    }
    return _dataArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

/******************************** cell *****************************************/

@implementation TestCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}
- (void)updateData:(id)data indexPath:(NSIndexPath *)indexPath{
    NSDictionary *dc = data;
    
    self.imageView.image = [UIImage imageNamed:dc[@"image"]];
    self.titleLabel.text = dc[@"title"];
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-20);
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20);
    
    
}
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

@end



