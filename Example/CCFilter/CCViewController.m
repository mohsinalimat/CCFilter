//
//  CCViewController.m
//  CCFilter
//
//  Created by huangcheng on 09/10/2015.
//  Copyright (c) 2015 huangcheng. All rights reserved.
//

#import "CCViewController.h"
#import <Masonry/Masonry.h>
#import "CNNAucSelView.h"
#import "CNNAucFilterItemModel.h"

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
    return [NSMutableArray arrayWithObjects:@"人群",@"品牌",@"年龄",@"评级", nil];
}

- (NSInteger)getFilterBarDataStyle:(NSInteger)index{
    if (index == 2) {
        return 1;
    }else{
        return 0;
    }
}
- (NSMutableArray*)getFilterBarDataArrayAt:(NSInteger)index{
    if (index == 1) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        CNNAucFilterItemModel *model1 = [[CNNAucFilterItemModel alloc]init];
        model1.name = [NSString stringWithFormat:@"男"];
        model1.pinyin = [NSString stringWithFormat:@"1"];
        model1.upload = @"YY";
        [array addObject:model1];
        CNNAucFilterItemModel *model2 = [[CNNAucFilterItemModel alloc]init];
        model2.name = [NSString stringWithFormat:@"女"];
        model2.pinyin = [NSString stringWithFormat:@"2"];
        model2.upload = @"YYY";
        [array addObject:model2];
        return array;
    }else if (index == 2){
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (int i = 0 ; i < 100; i ++ ) {
            CNNAucFilterItemModel *model = [[CNNAucFilterItemModel alloc]init];
            model.name = [NSString stringWithFormat:@"%dname",i];
            model.pinyin = [NSString stringWithFormat:@"%dname",i];
            [array addObject:model];
        }
        return array;
    }else if (index == 3){
        NSMutableArray *array = [[NSMutableArray alloc]init];
        CNNAucFilterItemModel *model1 = [[CNNAucFilterItemModel alloc]init];
        model1.name = [NSString stringWithFormat:@"15岁以下"];
        model1.pinyin = [NSString stringWithFormat:@"1"];
        model1.upload = @"Y-Y";
        [array addObject:model1];
        CNNAucFilterItemModel *model2 = [[CNNAucFilterItemModel alloc]init];
        model2.name = [NSString stringWithFormat:@"15岁-20岁"];
        model2.pinyin = [NSString stringWithFormat:@"2"];
        model2.upload = @"YY-YY";
        [array addObject:model2];
        CNNAucFilterItemModel *model3 = [[CNNAucFilterItemModel alloc]init];
        model3.name = [NSString stringWithFormat:@"20岁-25岁"];
        model3.pinyin = [NSString stringWithFormat:@"3"];
        model3.upload = @"YYY-YYY";
        [array addObject:model3];
        return array;
    }else if (index == 4){
        NSMutableArray *array = [[NSMutableArray alloc]init];
        
        CNNAucFilterItemModel *model1 = [[CNNAucFilterItemModel alloc]init];
        model1.name = [NSString stringWithFormat:@"5星级"];
        model1.pinyin = [NSString stringWithFormat:@"1"];
        model1.upload = @"Y";
        [array addObject:model1];
        CNNAucFilterItemModel *model2 = [[CNNAucFilterItemModel alloc]init];
        model2.name = [NSString stringWithFormat:@"4星级"];
        model2.pinyin = [NSString stringWithFormat:@"2"];
        model2.upload = @"YY";
        [array addObject:model2];
        CNNAucFilterItemModel *model3 = [[CNNAucFilterItemModel alloc]init];
        model3.name = [NSString stringWithFormat:@"3星级"];
        model3.pinyin = [NSString stringWithFormat:@"3"];
        model3.upload = @"YYY";
        [array addObject:model3];
        CNNAucFilterItemModel *model4 = [[CNNAucFilterItemModel alloc]init];
        model4.name = [NSString stringWithFormat:@"2星级"];
        model4.pinyin = [NSString stringWithFormat:@"4"];
        model4.upload = @"YYYY";
        [array addObject:model4];
        return array;
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
    if ([number integerValue] != 2) {
        [selView loadWithData:[self getFilterBarDataArrayAt:[number integerValue]]withStyle:[self getFilterBarDataStyle:[number integerValue]]];
    }else{
        
        [selView loadWithData:[self getFilterBarDataArrayAt:[number integerValue]]withStyle:[self getFilterBarDataStyle:[number integerValue]]];
    }
}

//返回选择的筛选条件，处理界面刷新工作
- (void)selView:(CNNAucSelView*)selView didSelectedItem:(id)selected{
    NSDictionary *dic = (NSDictionary*)selected;
    CNNAucFilterItemModel *typeModel = [dic objectForKey:@(1)];
    CNNAucFilterItemModel *brandModel = [dic objectForKey:@(2)];
    CNNAucFilterItemModel *yearModel = [dic objectForKey:@(3)];
    CNNAucFilterItemModel *rankModel = [dic objectForKey:@(4)];
    NSMutableDictionary *paramster = [[NSMutableDictionary alloc]init];
    if (typeModel) {
        [paramster setObject:typeModel.upload forKey:@"XX"];
    }
    if (brandModel) {
        [paramster setObject:brandModel.name forKey:@"XXX"];
    }
    if (yearModel) {
        NSArray *array = [yearModel.upload componentsSeparatedByString:@"-"];
        [paramster setObject:[array objectAtIndex:0] forKey:@"XXXX"];
        [paramster setObject:[array objectAtIndex:1] forKey:@"XXXX"];
    }
    if (rankModel) {
        [paramster setObject:rankModel.upload forKey:@"XXXXX"];
    }
}
@end
