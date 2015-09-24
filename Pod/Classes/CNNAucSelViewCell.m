//
//  CNNAucSelViewCell.m
//  cheniu
//
//  Created by 黄成 on 15/9/10.
//  Copyright (c) 2015年 souche. All rights reserved.
//

#import "CNNAucSelViewCell.h"
#import <Masonry/Masonry.h>

#define kAucSepLineBackColor [UIColor colorWithRed:209.0/255.0 green:209/255.0 blue:209/255.0 alpha:1.0]
static CGFloat const kCellHeight = 44.0f;
static CGFloat const kAucSepLineHeight = 0.5f;
@interface CNNAucSelViewCell()

@property (nonatomic,strong) UIView *sepLine;
@end

@implementation CNNAucSelViewCell

+ (CGFloat)cellHeight{
    return kCellHeight;
}
- (CGFloat)cellHeightWithDict:(NSDictionary*)dic{
    return kCellHeight;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.sepLine];
        [self addConstraints];
        [self.textLabel setFont:[UIFont systemFontOfSize:14.0f]];
    }
    return self;
}

- (void)addConstraints{
    __weak typeof(self) weakSelf = self;
    [self.sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(weakSelf);
        make.height.equalTo(@(kAucSepLineHeight));
    }];
}

- (UIView *)sepLine{
    if (_sepLine == nil) {
        _sepLine = [[UIView alloc]init];
        _sepLine.backgroundColor = kAucSepLineBackColor;
    }
    return _sepLine;
}
@end
