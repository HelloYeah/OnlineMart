//
//  GoodsLayout.m
//  OnlineMart
//
//  Created by Sekorm on 2017/7/12.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "GoodsLayout.h"

/***  当前屏幕宽度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/***  当前屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface GoodsLayout ()
/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArr;
@property (nonatomic,assign) CGFloat contentHeight;

@end

@implementation GoodsLayout

- (void)prepareLayout{
    
    [super prepareLayout];
    // 清楚之前所有的布局属性
    [self.attrsArr removeAllObjects];
    
    self.contentHeight = 0;
    
    for (int j = 0; j < [self.collectionView numberOfSections]; j++) {
        NSInteger count = [self.collectionView numberOfItemsInSection:j];
        for (int i = 0; i < count; i++) {
            // 创建位置
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:j];
            // 获取indexPath位置上cell对应的布局属性
            UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArr addObject:attrs];
        }
    }
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 创建布局属性
    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        CGFloat w = 78;
        CGFloat h = 78;
        NSInteger col = SCREEN_WIDTH / 78;
        CGFloat margin = (SCREEN_WIDTH - col * 78) / (col + 1);
        CGFloat x = indexPath.item % col * (78 + margin) + margin;
        CGFloat y = indexPath.item / col * (78 + margin) + margin;
        attrs.frame = CGRectMake(x, y, w, h);
        self.contentHeight = y + h;
    
    }else if (indexPath.section == 1) {
        
        CGFloat margin = 12.5;
        CGFloat x = 12.5;
        CGFloat w = SCREEN_WIDTH - 25;
        CGFloat h = 150;
        CGFloat y = self.contentHeight + margin;
        attrs.frame = CGRectMake(x, y, w, h);
        self.contentHeight += h + margin;
    
    }else if (indexPath.section == 2) {
        
        NSInteger col = 4;
        CGFloat margin = 12.5;
        CGFloat w = (SCREEN_WIDTH - (col + 1) * margin) / col;
      
        if(indexPath.item == 0) {
            
            CGFloat x = margin;
            CGFloat width = w * 2 + margin;
            CGFloat y = self.contentHeight + margin;
            attrs.frame = CGRectMake(x, y, width, width);
            
        }else {
        
            CGFloat x = w * 2 + margin + (indexPath.item - 1) % 2 * (w + margin) + 2 * margin;
            CGFloat y = self.contentHeight + (indexPath.item - 1) / 2 * (w + margin) + margin;
            attrs.frame = CGRectMake(x, y, w, w);
            if (indexPath.item == [self.collectionView numberOfItemsInSection:2] - 1) {
                self.contentHeight = y + w;
            }
        }
        
    }else if (indexPath.section == 3) {
        
        NSInteger col = 2;
        CGFloat margin = 12.5;
        CGFloat w = (SCREEN_WIDTH - (col + 1) * margin) / col;
        CGFloat h = 240;
        
        CGFloat x = indexPath.item % col * (w + margin) + margin;
        CGFloat y = self.contentHeight + indexPath.item / col * (h + margin) + margin;;
        attrs.frame = CGRectMake(x, y, w, h);
        
        if (indexPath.item == [self.collectionView numberOfItemsInSection:3] - 1) {
            self.contentHeight = y + h + margin;
        }
    }
    return attrs;
}

/**
 * 决定cell的布局属性
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    return self.attrsArr;
}


/**
 * 内容的高度
 */
- (CGSize)collectionViewContentSize{
    
    return CGSizeMake(0, self.contentHeight);
}

#pragma mark 懒加载
- (NSMutableArray *)attrsArr{
    if (!_attrsArr) {
        _attrsArr = [NSMutableArray array];
    }
    return _attrsArr;
}


@end
