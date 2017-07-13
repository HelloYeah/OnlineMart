//
//  GroupModel.m
//  OnlineMart
//
//  Created by Sekorm on 2017/7/12.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "GroupModel.h"
@implementation GroupModel
- (instancetype)initWithType:(GoodsType)type sectionTitle:(NSString *)title goods:(NSArray *)goods {

    self = [super init];
    self.type = type;
    self.goodsArray = goods;
    self.sectionTitle = title;
    return self;
}


@end
