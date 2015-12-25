//
//  TableViewController.m
//  test auto height cell
//
//  Created by Will on 12/25/15.
//  Copyright © 2015 gewill.org. All rights reserved.
//

#import "TableViewCell.h"
#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.estimatedRowHeight = 160; //  随便设个不那么离谱的值
  self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return 1100;
}

- (TableViewCell *)tableView:(UITableView *)tableView
       cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                        forIndexPath:indexPath];
  cell.avatar.image = [UIImage imageNamed:@"avatar"];
  cell.name.text = [NSString stringWithFormat:@"%ld", indexPath.row % 2];
  cell.time.text = [NSString stringWithFormat:@"%@", [NSDate date]];
  cell.source.text = @"Weibo.com";

  NSMutableString *str = [NSMutableString new];
  for (long i = 1; i < indexPath.row; i++) {
    [str appendString:@"The 1989 World Tour (Live)"];
  }
  cell.text.text = str;

  if (indexPath.row % 3 == 1) {
    cell.pic.image = [UIImage imageNamed:@"pic"];
  } else {
    cell.pic.image = nil;
  }
  return cell;
}

@end
