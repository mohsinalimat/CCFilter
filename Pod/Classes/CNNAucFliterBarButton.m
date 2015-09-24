//
//  CNNAucFliterBarButton.m
//  cheniu
//
//  Created by 黄成 on 15/9/9.
//  Copyright (c) 2015年 souche. All rights reserved.
//


/**
 * button有三种状态 1.选择状态，2正常非选择状态，3有选择的高亮状态
 * 点用setFilterState自动改变，btn里面不关心具体状态的具体变化过程
 */

#import "CNNAucFliterBarButton.h"

#define UILightGrayColor [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0]

@implementation CNNAucFliterBarButton

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self setHidden:YES];
        self.layer.masksToBounds = YES;
        [self setFilterState:CNNFilterBarStateNormal];
    }
    return self;
}

- (void)setFilterState:(CNNFilterBarState)filterState{
    _filterState = filterState;
    switch (filterState) {
        case CNNFilterBarStateNormal:{
        [self setTextNormal];}
            break;
        case CNNFilterBarStateSelected:{
            [self setShowSelected];
        }break;
        case CNNFilterBarStateHighNormal:{
            [self setTextLight];
        }break;
        default:
            break;
    }
}

- (void)setTextLight{
    [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor clearColor]];
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 8;
}
- (void)setTextNormal{
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setBackgroundColor:UILightGrayColor];
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 8;
}

- (void)setShowSelected{
    
    [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor clearColor]];
    self.layer.borderColor = [UIColor clearColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 8;
}
@end
