//
//  CNNAucFliter.m
//  cheniu
//
//  Created by 黄成 on 15/9/9.
//  Copyright (c) 2015年 souche. All rights reserved.
//

#import "CNNAucFliter.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define BUTTON_MARGIN   8.0f
#define btnWidth        (SCREEN_WIDTH - (_dataOfFliterBar.count+1)*BUTTON_MARGIN)/_dataOfFliterBar.count
#define btnHeight       44-2*BUTTON_MARGIN

@interface CNNAucFliter(){
    NSInteger selectedAt;
}

@property (nonatomic,strong) NSMutableArray *btnArray;

@end

@implementation CNNAucFliter

- (instancetype)init{
    self = [super init];
    if (self) {
        selectedAt = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)reloadBar{
    for (int i =0 ; i < _dataOfFliterBar.count; i ++) {
        NSString *str = [_dataOfFliterBar objectAtIndex:i];
        CNNAucFliterBarButton *btn = [[CNNAucFliterBarButton alloc]init];
        [btn setTitle:str forState:UIControlStateNormal];
        [btn setHidden:NO];
        btn.tag = i+1;
        [btn setFrame:CGRectMake((btnWidth+BUTTON_MARGIN)*i+BUTTON_MARGIN, BUTTON_MARGIN, btnWidth, btnHeight)];
        [btn addTarget:self action:@selector(clickOnBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:btn];
        [self addSubview:btn];
    }
}
- (void)reloadBtnState{
    [self drawLineWithIndex:0];
    for (NSNumber *number in [self.selectedFilterBarDict allKeys]) {
        for (CNNAucFliterBarButton *btn in self.btnArray) {
            if (btn.tag == [number integerValue] && [self.selectedFilterBarDict objectForKey:number]) {
                [btn setTitle:[self.selectedFilterBarDict objectForKey:number] forState:UIControlStateNormal];
                btn.filterState = CNNFilterBarStateHighNormal;
            }
        }
    }
}
- (void)clickOnBtn:(id)sender{
    CNNAucFliterBarButton *btn = (id)sender;
    NSNumber *number = @(btn.tag);
    if (btn.filterState == CNNFilterBarStateHighNormal) {
        NSString *str = [_dataOfFliterBar objectAtIndex:btn.tag-1];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.filterState = CNNFilterBarStateNormal;
        
        if ([self.delegate respondsToSelector:@selector(filterBarCanSelectedAt:)]) {
            [self.delegate filterBarCanSelectedAt:btn.tag];
        }
    }else if(btn.filterState == CNNFilterBarStateSelected){
        btn.filterState = CNNFilterBarStateNormal;
        [self drawLineWithIndex:0];
        
        if ([self.delegate respondsToSelector:@selector(filterBarCanSelectedAt:)]) {
            [self.delegate filterBarCanSelectedAt:btn.tag];
        }
    }
    else{
        btn.filterState = CNNFilterBarStateSelected;
        [self drawLineWithIndex:[number integerValue]];
        if ([self.delegate respondsToSelector:@selector(filterBarSelectedAt:)]) {
            [self.delegate filterBarSelectedAt:btn.tag];
        }
    }
    [self loadBtnState];
}

- (void)loadBtnState{
    for (CNNAucFliterBarButton *btn in self.btnArray ) {
        if (btn.tag != selectedAt && btn.filterState != CNNFilterBarStateHighNormal) {
            btn.filterState = CNNFilterBarStateNormal;
        }
    }
}
- (void)drawLineWithIndex:(NSInteger)index{
    selectedAt = index;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    if (selectedAt == 0 || selectedAt > self.dataOfFliterBar.count) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定直线样式
    
    CGContextSetLineCap(context,
                        kCGLineCapSquare);
    CGContextSetRGBStrokeColor(context, 208/255.0, 208/255.0, 208/255.0, 1.0);
    CGContextSetLineWidth(context, 0.5);
    CGContextMoveToPoint(context, 0, 44);
    CGContextAddLineToPoint(context, (btnWidth+BUTTON_MARGIN)*(selectedAt-1)+BUTTON_MARGIN, 44);
    CGContextAddLineToPoint(context, (btnWidth+BUTTON_MARGIN)*(selectedAt-1)+BUTTON_MARGIN, 2*BUTTON_MARGIN);
    
    CGContextAddQuadCurveToPoint(context, (btnWidth+BUTTON_MARGIN)*(selectedAt-1)+BUTTON_MARGIN, BUTTON_MARGIN, (btnWidth+BUTTON_MARGIN)*(selectedAt-1)+2*BUTTON_MARGIN,BUTTON_MARGIN);
    
    CGContextAddLineToPoint(context, (btnWidth+BUTTON_MARGIN)*selectedAt-BUTTON_MARGIN, BUTTON_MARGIN);
    
    CGContextAddQuadCurveToPoint(context, (btnWidth+BUTTON_MARGIN)*selectedAt, BUTTON_MARGIN, (btnWidth+BUTTON_MARGIN)*selectedAt,2*BUTTON_MARGIN);
    
    CGContextAddLineToPoint(context, (btnWidth+BUTTON_MARGIN)*selectedAt, 44);
    CGContextAddLineToPoint(context, [UIScreen mainScreen].bounds.size.width, 44);
    CGContextStrokePath(context);
}

#pragma mark Getter and Setter

- (void)setDataOfFliterBar:(NSMutableArray *)dataOfFliterBar{
    _dataOfFliterBar = dataOfFliterBar;
    [self reloadBar];
}

- (void)setSelectedFilterBarDict:(NSMutableDictionary *)selectedFilterBarDict{
    _selectedFilterBarDict = selectedFilterBarDict;
    [self reloadBtnState];
}

//- (NSMutableDictionary *)selectedFilterBarDict{
//    if (_selectedFilterBarDict == nil) {
//        _selectedFilterBarDict = [[NSMutableDictionary alloc]init];
//    }
//    return _selectedFilterBarDict;
//}
- (NSMutableArray *)btnArray{
    if (_btnArray == nil) {
        _btnArray = [[NSMutableArray alloc]init];
    }
    return _btnArray;
}
@end
