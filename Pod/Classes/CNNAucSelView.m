//
//  CNNAucSelView.m
//  cheniu
//
//  Created by 黄成 on 15/9/9.
//  Copyright (c) 2015年 souche. All rights reserved.
//

#import "CNNAucSelView.h"
#import "CNNAucHeader.h"
#import "CNNAucFliter.h"
#import "CNNAucSelViewCell.h"


static NSString * const CellIdentifier = @"CNNAucSelViewCell";

@interface CNNAucSelView()<UITableViewDataSource,UITableViewDelegate,CNNAucFliterDelegate>{
    NSInteger currentItemIndex;
}

@end

@implementation CNNAucSelView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubviews];
        [self addConstraints];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
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
        make.bottom.left.right.equalTo(weakSelf);
    }];
}

#pragma mark UITableView Delegate DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CNNAucSelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CNNAucSelViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *string = [self.dataArray objectAtIndex:indexPath.row];
    [self.selectedFilterBarDict setObject:string forKey:@(currentItemIndex)];
    self.fliterBar.selectedFilterBarDict = self.selectedFilterBarDict;
    if ([self.delegate respondsToSelector:@selector(selView:didSelectedItem:)]) {
        [self.delegate selView:self didSelectedItem:self.selectedFilterBarDict];
    }
    [self hide];
}

- (void)show{
    
    CGRect tbFrame = self.frame;
    tbFrame.size.height = (_dataArray.count+1) * 44;
    if (tbFrame.size.height >= _maxTableHeight) {
        tbFrame.size.height = _maxTableHeight;
        self.tableViewSel.bounces = YES;
    }else{
        self.tableViewSel.bounces = NO;
    }
    [UIView animateWithDuration:0.2 animations:^{
//        self.frame = tbFrame;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(tbFrame.size.height));
        }];
    } completion:^(BOOL finished) {
//        self.frame = tbFrame;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(tbFrame.size.height));
        }];
    }];
}
- (void)hide{
    
    CGRect tbFrame = self.frame;
    tbFrame.size.height = 44;
    [UIView animateWithDuration:0.2 animations:^{
//        self.frame = tbFrame;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(tbFrame.size.height));
        }];
    } completion:^(BOOL finished) {
//        self.frame = tbFrame;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(tbFrame.size.height));
        }];
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
    [self hide];
    if ([self.selectedFilterBarDict objectForKey:@(index)]) {
        [self.selectedFilterBarDict removeObjectForKey:@(index)];
        if ([self.delegate respondsToSelector:@selector(selView:didSelectedItem:)]) {
            [self.delegate selView:self didSelectedItem:self.selectedFilterBarDict];
        }
    }
}
#pragma mark Getter and Setter

- (void)setDataOfFliterBar:(NSMutableArray *)dataOfFliterBar{
    _dataOfFliterBar = [dataOfFliterBar mutableCopy];
    self.fliterBar.dataOfFliterBar = _dataOfFliterBar;
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    
    
    [self.tableViewSel reloadData];
}

- (NSMutableDictionary *)selectedFilterBarDict{
    if (_selectedFilterBarDict == nil) {
        _selectedFilterBarDict = [[NSMutableDictionary alloc]init];
    }
    return _selectedFilterBarDict;
}

- (UITableView *)tableViewSel{
    if (_tableViewSel == nil) {
        _tableViewSel = [[UITableView alloc]init];
        _tableViewSel.delegate = self;
        _tableViewSel.dataSource = self;
        _tableViewSel.bounces = NO;
        _tableViewSel.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableViewSel.backgroundColor = [UIColor whiteColor];
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
