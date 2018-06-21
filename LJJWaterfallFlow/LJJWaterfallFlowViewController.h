//
//  LJJWaterfallFlowViewController.h
//  LJJWaterfallFlow
//
//  Created by peony on 2018/6/21.
//  Copyright © 2018年 peony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJJWaterfallFlowViewController : UIViewController

@property (nonatomic, copy) id (^infoBlock)(void);

@end


@interface TestCell:UICollectionViewCell

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLabel;



@end

