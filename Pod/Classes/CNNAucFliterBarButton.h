//
//  CNNAucFliterBarButton.h
//  cheniu
//
//  Created by 黄成 on 15/9/9.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CNNFilterBarState) {
    CNNFilterBarStateNormal,
    CNNFilterBarStateHighNormal,
    CNNFilterBarStateSelected
};

@interface CNNAucFliterBarButton : UIButton

@property (nonatomic,assign) CNNFilterBarState filterState;

- (void)setTextLight;
- (void)setTextNormal;
- (void)setShowSelected;

@end
