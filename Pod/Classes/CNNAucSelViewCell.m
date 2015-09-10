//
//  CNNAucSelViewCell.m
//  cheniu
//
//  Created by 黄成 on 15/9/10.
//  Copyright (c) 2015年 souche. All rights reserved.
//

#import "CNNAucSelViewCell.h"
#import "CNNAucUtils.h"
#import <CNNCore.h>
#import <Masonry/Masonry.h>
#import "CNNAucConstant.h"

static CGFloat const kCellHeight = 44.0f;

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
//        self.backgroundColor = [UIColor cnn_colorWithHexString:@"#F7F7F7"];
        
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
        _sepLine.backgroundColor = [UIColor cnn_colorWithHexString:kAucSepLineBackColor];
    }
    return _sepLine;
}
@end
