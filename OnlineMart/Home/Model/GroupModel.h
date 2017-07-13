//
//  GroupModel.h
//  OnlineMart
//
//  Created by Sekorm on 2017/7/12.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    GoodsTypeBlocks,   //块状的，顶部九宫格排列的
    GoodsTypeSingle,   //单个
    GoodsTypeDouble,
    GoodsTypeMultiple,
} GoodsType;

@interface GroupModel : NSObject
@property (nonatomic,assign) GoodsType type;
@property (nonatomic,strong) NSArray *goodsArray;
@property (nonatomic,strong) NSString *sectionTitle;

- (instancetype)initWithType:(GoodsType)type sectionTitle:(NSString *)title goods:(NSArray *)goodsArray;
@end
