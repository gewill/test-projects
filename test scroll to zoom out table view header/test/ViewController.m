//
//  ViewController.m
//  test
//
//  Created by Will on 3/18/16.
//  Copyright © 2016 gewill.org. All rights reserved.
//

// UITableView 是 UIScrollView 的子类。
//所以 UIScrollView 的代理方法，在UITableView 上同样能够得到适用。
//既然如此那么我们就能够知道，在表格下拉的过程中，需要让头部的图片能够有稍微放大的效果出现，我们可以根据滚动视图滚动监听事件，通过获取表格下拉的拉伸量，从而去改变图片的大小即可！

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UIImageView *headImageView; //头部图片
@property(nonatomic, strong) UITableView *tableView;     //列表
@property(nonatomic, strong) NSMutableArray *infoArray;  //数据源数组

@end
//屏幕宽、高 宏定义
#define IPHONE_W ([UIScreen mainScreen].bounds.size.width)
#define IPHONE_H ([UIScreen mainScreen].bounds.size.height)

@implementation ViewController

static CGFloat kImageOriginHight = 300;

- (void)viewDidLoad {

  [super viewDidLoad];

  //将视图添加到界面上
  [self.view addSubview:self.tableView];
  [self.tableView addSubview:self.headImageView];
}

#pragma mark-- 滚动视图的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  /**
   *  关键处理：通过滚动视图获取到滚动偏移量从而去改变图片的变化
   */
  //获取滚动视图y值的偏移量
  CGFloat yOffset = scrollView.contentOffset.y;
  NSLog(@"yOffset===%f", yOffset);
  CGFloat xOffset = (yOffset + kImageOriginHight) / 2;

  if (yOffset < -kImageOriginHight) {
    CGRect f = self.headImageView.frame;
    f.origin.y = yOffset;
    f.size.height = -yOffset;
    f.origin.x = xOffset;
    // int abs(int i); // 处理int类型的取绝对值
    // double fabs(double i); //处理double类型的取绝对值
    // float fabsf(float i); //处理float类型的取绝对值
    f.size.width = IPHONE_W + fabs(xOffset) * 2;

    self.headImageView.frame = f;
  }
}
#pragma mark-- 表视图代理

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 44;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *identify = @"MyCellIndifer";
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:identify];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identify];
  }
  cell.textLabel.text = [self.infoArray objectAtIndex:indexPath.row];
  return cell;
}

#pragma mark-- get 初始化操作

- (UITableView *)tableView {
  if (_tableView == nil) {
    _tableView = [[UITableView alloc]
        initWithFrame:CGRectMake(0, 0, IPHONE_W, IPHONE_H)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor lightGrayColor];
    //内容由kImageOriginHight 处开始显示。
    _tableView.contentInset = UIEdgeInsetsMake(kImageOriginHight, 0, 0, 0);
  }
  return _tableView;
}

- (NSMutableArray *)infoArray {
  if (_infoArray == nil) {
    _infoArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 40; i++) {
      [_infoArray addObject:@"这是一个测试！"];
    }
  }
  return _infoArray;
}

- (UIImageView *)headImageView {
  if (_headImageView == nil) {
    _headImageView =
        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"111"]];
    _headImageView.frame =
        CGRectMake(0, -kImageOriginHight, IPHONE_W, kImageOriginHight);
  }
  return _headImageView;
}
@end
