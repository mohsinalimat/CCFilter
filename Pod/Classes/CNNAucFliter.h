//
//  CNNAucFliter.h
//  cheniu
//
//  Created by 黄成 on 15/9/9.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNNAucFliterBarButton.h"

@protocol CNNAucFliterDelegate <NSObject>

@optional

- (void)filterBarSelectedAt:(NSInteger)index;
- (void)filterBarCanSelectedAt:(NSInteger)index;

@end

@interface CNNAucFliter : UIView

@property (nonatomic,strong) id<CNNAucFliterDelegate>delegate;

@property (nonatomic,strong) NSMutableArray *dataOfFliterBar;
@property (nonatomic,strong) NSMutableDictionary *selectedFilterBarDict;

- (void)reloadBtnState;

@end
