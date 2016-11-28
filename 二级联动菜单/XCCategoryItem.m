//
//  XCCategoryItem.m
//  二级联动菜单
//
//  Created by liuxingchen on 16/11/28.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "XCCategoryItem.h"

@implementation XCCategoryItem
+(instancetype)catgoryWithDict:(NSDictionary *)dict
{
    XCCategoryItem *item = [[self alloc]init];
    [item setValuesForKeysWithDictionary:dict];
    return item;
}
@end
