//
//  CNNAucFliterBarButton.h
//  cheniu
//
//  Created by 黄成 on 15/9/9.
//  Copyright (c) 2015年 huangcheng. All rights reserved.
//

/**
 * button有三种状态 1.选择状态，2正常非选择状态，3有选择的高亮状态
 * 点用setFilterState自动改变，btn里面不关心具体状态的具体变化过程
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CNNFilterBarState) {
    CNNFilterBarStateNormal,
    CNNFilterBarStateHighNormal,
    CNNFilterBarStateSelected
};

@interface CNNAucFliterBarButton : UIButton

@property (nonatomic,assign) CNNFilterBarState filterState;

- (void)setTextLight;
- (void)settextNormal;

- (void)setShowSelected;

@end
