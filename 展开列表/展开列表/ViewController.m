//
//  ViewController.m
//  展开列表
//
//  Created by 罗小友 on 2017/12/5.
//  Copyright © 2017年 csair.etms. All rights reserved.
//

#import "ViewController.h"
#import "LXYOpenListTableView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
//有几组
@property (nonatomic ,strong) NSMutableArray *sectionArr;
//每一组有多少行
@property (nonatomic ,strong) NSMutableArray *indexRowArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    //添加tableView
   // [self addTableView];
    CGFloat x = 50;
    CGFloat y = 64;
    CGFloat w = self.view.frame.size.width - 2 * x;
    CGFloat h = self.view.frame.size.height - 2 * y;
    self.tableView.frame = CGRectMake(x, y, w, h);
    LXYOpenListTableView *tableView = [[LXYOpenListTableView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(instancetype)init
{
    return self;
}

//初始化一个tableView
-(void)addTableView
{
    CGFloat x = 50;
    CGFloat y = 64;
    CGFloat w = self.view.frame.size.width - 2 * x;
    CGFloat h = self.view.frame.size.height - 2 * y;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [self makeSuoreArray];
}

#pragma  数组
-(void)makeSuoreArray
{
    _sectionArr = [NSMutableArray array];
    _indexRowArr = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        //添加每一组cell
        NSMutableArray *cellArr = [NSMutableArray array];
        for(int j = 0; j < arc4random()%10 + 1; j ++){
            NSString * cellStr = [NSString stringWithFormat:@"第%d行cell",j];
            [cellArr addObject:cellStr];
        }
        [_sectionArr addObject:cellArr];
        [_indexRowArr addObject:@"0"];
    }
     NSLog(@"%@",_sectionArr);
}



#pragma arguments datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArr.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.sectionArr[section];
    return array.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *sectionHeardLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(0, 0, self.view.frame.size.width,(self.view.frame.size.height - 2 * 64)/6)];
    sectionHeardLabel.text = [NSString stringWithFormat:@"第%ld组",(long)section];
    sectionHeardLabel.backgroundColor = [UIColor orangeColor];
    sectionHeardLabel.textAlignment = NSTextAlignmentCenter;
    sectionHeardLabel.textColor = [UIColor redColor];
    sectionHeardLabel.tag = section + 10;
    sectionHeardLabel.userInteractionEnabled = YES;
    
    //圆角
    sectionHeardLabel.layer.cornerRadius = 10;
    sectionHeardLabel.layer.borderWidth = 1;
    sectionHeardLabel.layer.masksToBounds = YES;
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openlist:)];
    [sectionHeardLabel addGestureRecognizer:tap];
    return sectionHeardLabel;
    
    
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lxy"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"lxy"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组的第%ld行",(long)indexPath.section,(long)indexPath.row];
    cell.clipsToBounds = YES;
    return cell;
}



#pragma 手势
-(void)openlist:(UITapGestureRecognizer *)tap
{
    NSLog(@"我点击了%ld行",tap.view.tag);
    int index = tap.view.tag % 10;
    NSMutableArray *indexArray = [NSMutableArray array];
    NSArray *arr = _sectionArr[index];
    for (int i = 0; i < arr.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:index];
        [indexArray addObject:indexPath];
    }
    if ([_indexRowArr[index] isEqualToString:@"0"]) {
        self.indexRowArr[index] = @"1";
        [self.tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];
    }else
    {
        self.indexRowArr[index] = @"0";
        [_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.indexRowArr[indexPath.section] isEqualToString:@"0"])
    {
        return 0;
    }else{
        return 64;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (self.view.frame.size.height - 2 * 64)/6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}


//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded {
//    <#code#>
//}

@end
