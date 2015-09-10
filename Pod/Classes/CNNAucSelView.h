//
//  CNNAucSelView.h
//  cheniu
//
//  Created by 黄成 on 15/9/9.
//  Copyright (c) 2015年 huangcheng. All rights reserved.
//

/*
 *负责弹出视图的内容
 *负责回调业务层的参数字典
 *负责获取筛选title的内容
 */

#import <UIKit/UIKit.h>
@class CNNAucFliter;
@class CNNAucSelView;

@protocol CNNAucSelViewDelegate <NSObject>

@optional

- (NSMutableArray*)selViewDataOfFilterBar:(CNNAucSelView*)selView;

- (void)selView:(CNNAucSelView*)selView didSelectedFilterBar:(id)selectedItem;

- (void)selView:(CNNAucSelView*)selView didSelectedItem:(id)selected;

@end

@interface CNNAucSelView : UIView

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *dataOfFliterBar;

@property (nonatomic,assign) CGFloat maxTableHeight;

@property (nonatomic,weak) id<CNNAucSelViewDelegate>delegate;

@property (nonatomic,strong) NSMutableDictionary *selectedFilterBarDict;

@property (nonatomic,strong) UITableView *tableViewSel;
@property (nonatomic,strong) CNNAucFliter *fliterBar;

- (void)show;
- (void)hide;

@end
