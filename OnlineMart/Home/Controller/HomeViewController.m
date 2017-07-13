
//
//  HomeViewController.m
//  OnlineMart
//
//  Created by Sekorm on 2017/7/12.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HomeViewController.h"
#import "GoodsBlocksCell.h"
#import "GoodsSingleCell.h"
#import "GoodsDoubleCell.h"
#import "GoodsMultipleCell.h"
#import "GoodsLayout.h"
#import "GroupModel.h"
#import "GoodsModel.h"

/***  当前屏幕宽度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/***  当前屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) GoodsLayout *myLayout;
@property (nonatomic,strong) NSArray *groups;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:self.scrollView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.groups.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    GroupModel *groupModel = self.groups[section];
    return groupModel.goodsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GroupModel *groupModel = self.groups[indexPath.section];
    switch (groupModel.type) {
        case GoodsTypeBlocks: {
            GoodsBlocksCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsBlocksCell" forIndexPath:indexPath];
            return cell;
        }
        case GoodsTypeSingle: {
            GoodsSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsSingleCell" forIndexPath:indexPath];
            return cell;
            
        }
        case GoodsTypeDouble: {
            GoodsDoubleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsDoubleCell" forIndexPath:indexPath];
            return cell;
            
        }
        case GoodsTypeMultiple: {
            GoodsMultipleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsMultipleCell" forIndexPath:indexPath];
            return cell;
            
        }
    }
    return nil;
}


- (UICollectionView *)collectionView {
    
    if(!_collectionView) {
        
        self.myLayout = [[GoodsLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:self.myLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"GoodsBlocksCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsBlocksCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"GoodsSingleCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsSingleCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"GoodsDoubleCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsDoubleCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"GoodsMultipleCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsMultipleCell"];
        _collectionView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (NSArray *)groups {
    
    if (!_groups) {
        
        NSArray *goodsArray = @[[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init],[[GoodsModel alloc] init]];
        
        GroupModel *blocksModel = [[GroupModel alloc] initWithType:GoodsTypeBlocks sectionTitle:nil goods:[goodsArray subarrayWithRange:NSMakeRange(0, 8)]];
        
        GroupModel *singleModel = [[GroupModel alloc] initWithType:GoodsTypeSingle sectionTitle:nil goods:[goodsArray subarrayWithRange:NSMakeRange(0, 5)]];
        singleModel.type = GoodsTypeSingle;
        
        GroupModel *multipleModel = [[GroupModel alloc] initWithType:GoodsTypeMultiple sectionTitle:nil goods:[goodsArray subarrayWithRange:NSMakeRange(0, 5)]];
        multipleModel.type = GoodsTypeMultiple;
        
        GroupModel *doubleModel = [[GroupModel alloc] initWithType:GoodsTypeDouble sectionTitle:nil goods:goodsArray];
        doubleModel.type = GoodsTypeDouble;
        
        _groups = @[blocksModel,singleModel,multipleModel,doubleModel];
    }
    return _groups;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        CGFloat width = SCREEN_WIDTH;
        CGFloat height = 180;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, - height, width, height)];
        
        for (int i = 0; i < 6; i ++) {
            CGFloat x = i * width;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, width, height)];
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"timg-%d",i]];
            [_scrollView addSubview:imageView];
        }
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(width * 6, 0);
    }
    return _scrollView;
}
@end
