//
//  CNNAucSelView.m
//  cheniu
//
//  Created by 黄成 on 15/9/9.
//  Copyright (c) 2015年 souche. All rights reserved.
//

/*
 *负责弹出视图的内容
 *负责回调业务层的参数字典
 *负责获取筛选title的内容
 */

#import "CNNAucSelView.h"
#import "CNNAucFliter.h"
#import "CNNAucSelViewCell.h"
#import "CNNAucFilterItemModel.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString * const CellIdentifier = @"CNNAucSelViewCell";

@interface CNNAucSelView()<UITableViewDataSource,UITableViewDelegate,CNNAucFliterDelegate,UIGestureRecognizerDelegate>{
    NSInteger currentItemIndex;
}

@end

@implementation CNNAucSelView

- (instancetype)init{
    self = [super init];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        tap.delegate = self;
        tap.cancelsTouchesInView = NO;
        [self addGestureRecognizer:tap];
        [self addSubviews];
        [self addConstraints];
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isKindOfClass:[self class]]) {
        return YES;
    }return NO;
}

- (void)addSubviews{
    [self addSubview:self.fliterBar];
    [self addSubview:self.tableViewSel];
}

- (void)addConstraints{
    __weak typeof(self) weakSelf = self;
    [self.fliterBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(44));
        make.left.right.top.equalTo(weakSelf);
    }];
    [self.tableViewSel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(44.0);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(0));
    }];
}

- (void)loadWithData:(NSMutableArray *)array withStyle:(TableViewStyle)style{
    self.style = style;
    switch (style) {
        case TableViewStyleNone:{
            self.titleArray = array;
            [self.tableViewSel reloadData];
        }
            break;
        case TableViewStyleGroup:{
            [self loadGroupWithData:array];
        }
            
            break;
        default:
            break;
    }
}
- (void)loadGroupWithData:(NSMutableArray *)array{
    self.titleArray = [[NSMutableArray alloc]init];
    self.dataDictionary = [[NSMutableDictionary alloc]init];
    NSMutableSet *firstSet = [[NSMutableSet alloc]init];
    for (CNNAucFilterItemModel *model in array ) {
        if ([model.pinyin characterAtIndex:0]) {
            NSString *first = [NSString stringWithFormat:@"%c",[model.pinyin characterAtIndex:0]];
            [firstSet addObject:first];
        }else{
            NSString *first = @"#";
            [firstSet addObject:first];
        }
    }
    
    for (NSString *firstModel in firstSet ) {
        NSMutableArray *tmpArray = [self.dataDictionary objectForKey:firstModel];
        if (tmpArray == nil) {
            tmpArray = [[NSMutableArray alloc]init];
        }
        for (CNNAucFilterItemModel *model in array ) {NSString *first;
            if ([model.pinyin characterAtIndex:0]) {
                first = [NSString stringWithFormat:@"%c",[model.pinyin characterAtIndex:0]];
            }else{
                first = @"#";
            }
            if ([firstModel isEqualToString:first]) {
                [tmpArray addObject:model];
            }
        }
        [tmpArray sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:NO]]];
        [self.dataDictionary setObject:tmpArray forKey:firstModel];
    }
    
    NSArray *sortedArray = [firstSet sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
    self.titleArray = [NSMutableArray arrayWithArray:sortedArray];
    [self.tableViewSel reloadData];
}

#pragma mark UITableView Delegate DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    switch (self.style) {
        case TableViewStyleGroup:
            return [self.titleArray count];
            break;
        case TableViewStyleNone:
            return 1;
            break;
        default:
            return 1;
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (self.style) {
        case TableViewStyleGroup:{
            NSString *title = [self.titleArray objectAtIndex:section];
            NSArray *array = [self.dataDictionary objectForKey:title];
            return [array count];
        }break;
        case TableViewStyleNone:{
            return [self.titleArray count];
        }break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CNNAucSelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CNNAucSelViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    CNNAucFilterItemModel *model;
    switch (self.style) {
        case TableViewStyleGroup:{
            NSString *title = [self.titleArray objectAtIndex:indexPath.section];
            NSArray *array = [self.dataDictionary objectForKey:title];
            model = [array objectAtIndex:indexPath.row];
        }break;
        case TableViewStyleNone:
            model = [self.titleArray objectAtIndex:indexPath.row];
            break;
        default:
            model = nil;
            break;
    }
    
    if (model.image) {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    }else{
        cell.imageView.image = nil;
    }
    if (model.name) {
        [cell.textLabel setText:model.name];
    }else{
        [cell.textLabel setText:@""];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CNNAucFilterItemModel *model;
    switch (self.style) {
        case TableViewStyleGroup:{
            NSString *title = [self.titleArray objectAtIndex:indexPath.section];
            NSArray *array = [self.dataDictionary objectForKey:title];
            model = [array objectAtIndex:indexPath.row];
        }break;
        case TableViewStyleNone:
            model = [self.titleArray objectAtIndex:indexPath.row];
            break;
        default:
            model = nil;
            break;
    }
    [self.selectedFilterBarDict setObject:model forKey:@(currentItemIndex)];
    self.fliterBar.selectedFilterBarDict = self.selectedFilterBarDict;
    if ([self.delegate respondsToSelector:@selector(selView:didSelectedItem:)]) {
        [self.delegate selView:self didSelectedItem:self.selectedFilterBarDict];
    }
    [self hide];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (self.style) {
        case TableViewStyleGroup:{
            NSString *title = [self.titleArray objectAtIndex:section];
            return title;
        }break;
        case TableViewStyleNone:
            return nil;
            break;
        default:
            return @"";
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (self.style) {
        case TableViewStyleGroup:{
            return 30.0;
        }break;
        case TableViewStyleNone:
            return 0.0;
            break;
        default:
            return 0.0;
            break;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    switch (self.style) {
        case TableViewStyleGroup:{
            return self.titleArray;
        }break;
        case TableViewStyleNone:
            return nil;
            break;
        default:
            return nil;
            break;
    }
}

- (void)show{
    
    CGFloat height = 0;
    switch (self.style) {
        case TableViewStyleGroup:{
            for (NSString *tmpStr in self.titleArray) {
                height = [[self.dataDictionary objectForKey:tmpStr] count]*44+height;
                height = height + 30;
            }
        }break;
        case TableViewStyleNone:
            height = self.titleArray.count * 44;
        default:
            break;
    }
    if (height >= _maxTableHeight) {
        height = _maxTableHeight;
        self.tableViewSel.bounces = YES;
    }else{
        self.tableViewSel.bounces = NO;
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(SCREEN_HEIGHT));
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.tableViewSel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
        [self.tableViewSel layoutIfNeeded];
    }];
}
- (void)hide{
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(44));
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.tableViewSel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(0));
        }];
        [self.tableViewSel layoutIfNeeded];
    }];
    [self.fliterBar reloadBtnState];
}

#pragma mark delegate

- (void)filterBarSelectedAt:(NSInteger)index{
    currentItemIndex = index;
    if (index == 0) {
        [self hide];
    }else{
        if ([self.delegate respondsToSelector:@selector(selView:didSelectedFilterBar:)]) {
            [self.delegate selView:self didSelectedFilterBar:@(index)];
        }
        [self show];
    }
}

- (void)filterBarCanSelectedAt:(NSInteger)index{
    if ([self.selectedFilterBarDict objectForKey:@(index)]) {
        [self.selectedFilterBarDict removeObjectForKey:@(index)];
        self.fliterBar.selectedFilterBarDict = self.selectedFilterBarDict;
        if ([self.delegate respondsToSelector:@selector(selView:didSelectedItem:)]) {
            [self.delegate selView:self didSelectedItem:self.selectedFilterBarDict];
        }
    }
    [self hide];
}
#pragma mark Getter and Setter

- (void)setDataOfFliterBar:(NSMutableArray *)dataOfFliterBar{
    _dataOfFliterBar = [dataOfFliterBar mutableCopy];
    self.fliterBar.dataOfFliterBar = _dataOfFliterBar;
}

- (NSMutableDictionary *)dataDictionary{
    if (_dataDictionary == nil) {
        _dataDictionary = [[NSMutableDictionary alloc]init];
    }
    return _dataDictionary;
}

- (NSMutableDictionary *)selectedFilterBarDict{
    if (_selectedFilterBarDict == nil) {
        _selectedFilterBarDict = [[NSMutableDictionary alloc]init];
    }
    return _selectedFilterBarDict;
}

- (UITableView *)tableViewSel{
    if (_tableViewSel == nil) {
        _tableViewSel = [[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
        _tableViewSel.delegate = self;
        _tableViewSel.dataSource = self;
        _tableViewSel.bounces = NO;
        _tableViewSel.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableViewSel.backgroundColor = [UIColor whiteColor];
        _tableViewSel.tintColor = [UIColor blackColor];
    }
    return _tableViewSel;
}

- (CNNAucFliter *)fliterBar{
    if (_fliterBar == nil) {
        _fliterBar = [[CNNAucFliter alloc]init];
        _fliterBar.delegate = self;
    }
    return _fliterBar;
}

@end
