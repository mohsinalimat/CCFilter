//
//  CCViewController.m
//  CCFilter
//
//  Created by huangcheng on 09/10/2015.
//  Copyright (c) 2015 huangcheng. All rights reserved.
//

#import "CCViewController.h"
#import <Masonry/Masonry.h>
#import "CNNAucSelView.H"

@interface CCViewController ()<CNNAucSelViewDelegate>

@property (nonatomic,strong) CNNAucSelView *selFilterView;

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.view addSubview:self.selFilterView];
    self.selFilterView.dataOfFliterBar = [self getFilterBarTitleArray];
    __weak typeof(self) weakSelf = self;
    [self.selFilterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@(44));
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray*)getFilterBarTitleArray{
    return [NSMutableArray arrayWithObjects:@"品牌",@"价格",@"年限",@"所在地", nil];
}
- (NSMutableArray*)getFilterBarDataArrayAt:(NSInteger)index{
    if (index == 1) {
        return [NSMutableArray arrayWithObjects:@"宝马",@"保时捷",@"宾利",@"阿斯顿马丁", nil];
    }else if (index == 2){
        return [NSMutableArray arrayWithObjects:@"一年以内",@"两年以内",@"三年以内",nil];
    }else if (index == 3){
        return [NSMutableArray arrayWithObjects:@"1万以下",@"10万以下",@"30万以下",@"30万以上", nil];
    }else if (index == 4){
        return [NSMutableArray arrayWithObjects:@"杭州(定位)",@"北京",@"上海",@"重庆",@"天津",@"广州",@"深圳",@"北京",@"上海",@"重庆",@"天津",@"广州",@"深圳",@"北京",@"上海",@"重庆",@"天津",@"广州",@"深圳", nil];
    }else{
        return nil;
    }
}

- (CNNAucSelView *)selFilterView{
    if (_selFilterView == nil) {
        _selFilterView = [[CNNAucSelView alloc]init];
        [_selFilterView  setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _selFilterView.maxTableHeight = [UIScreen mainScreen].bounds.size.height - 64*2;
        _selFilterView.delegate = self;
    }
    return _selFilterView;
}

#pragma mark CNNAucSelViewDelegate

- (void)selView:(CNNAucSelView*)selView didSelectedFilterBar:(id)selectedItem{
    //加载筛选的不同数据
    NSNumber *number = (NSNumber*)selectedItem;
    [selView setDataArray:[self getFilterBarDataArrayAt:[number integerValue]]];
}

//返回选择的筛选条件，处理界面刷新工作
- (void)selView:(CNNAucSelView*)selView didSelectedItem:(id)selected{
    NSDictionary *dic = (NSDictionary*)selected;
    NSLog(@"dic %@",dic);
}

@end
