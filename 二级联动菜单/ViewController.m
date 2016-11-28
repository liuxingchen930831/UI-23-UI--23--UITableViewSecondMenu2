//
//  ViewController.m
//  二级联动菜单
//
//  Created by liuxingchen on 16/11/28.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "ViewController.h"
#import "XCCategoryItem.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *subCategoryTableView;
/** 存放模型数组 */
@property(nonatomic,strong)NSArray * categorys ;
@end

@implementation ViewController
-(NSArray *)categorys
{
    if (_categorys ==nil) {
        
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"categories" ofType:@"plist"]];
        NSMutableArray *categorys = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            XCCategoryItem *item = [XCCategoryItem catgoryWithDict:dict];
            [categorys addObject:item];
        }
        _categorys = categorys;
    }
    return _categorys;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //taleview默认选择某一行
    [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //选中左边
    if(tableView == self.categoryTableView )
        return self.categorys.count;
    
    //选中右边
    /**
     indexPathForSelectedRow:返回当前那一行被选中
     */
    //根据category选中哪行来显示subcategory的数据
    XCCategoryItem *item = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
    
    return item.subcategories.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.categoryTableView){
        static NSString *categoryCellID = @"categoryCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellID];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryCellID];
        }
        XCCategoryItem *item = self.categorys[indexPath.row];
        cell.textLabel.text = item.name;
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        cell.imageView.image = [UIImage imageNamed:item.icon];
        cell.imageView.highlightedImage = [UIImage imageNamed:item.highlighted_icon];
        return cell;
    }else{
        static NSString *subCategoryCellID = @"subCategoryCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:subCategoryCellID];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:subCategoryCellID];
        }
        //获得左边被选中的模型
        XCCategoryItem *item = self.categorys[self.categoryTableView.indexPathForSelectedRow.row];
        cell.textLabel.text = item.subcategories[indexPath.row];
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        [self.subCategoryTableView reloadData];
    }
}
@end
