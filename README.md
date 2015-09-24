#CNNAucFilter

## Installation

CCFilter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CCFilter"
```

## Author

huangcheng, 632300630@qq.com

### 更新：

添加了对象模型和动画效果

### 功能：

模仿手机淘宝的筛选，效果如下：

![效果图{100*100}](https://raw.githubusercontent.com/Mikora/CCFilter/master/Screen.png)


####使用

初始化控件：

```
_selFilterView = [[CNNAucSelView alloc]init];
_selFilterView.maxTableHeight = [UIScreen mainScreen].bounds.size.height - 64*2;
_selFilterView.delegate = self;
```

添加约束

```
[self.selFilterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@(44));
    }];
```

设置回调：

```

#pragma mark CNNAucSelViewDelegate

- (void)selView:(CNNAucSelView*)selView didSelectedFilterBar:(id)selectedItem{
    //加载筛选的不同数据
    NSNumber *number = (NSNumber*)selectedItem;
    if ([number integerValue] != 2) {
        [selView loadWithData:[self getFilterBarDataArrayAt:[number integerValue]]withStyle:[self getFilterBarDataStyle:[number integerValue]]];
    }else{
        
        [selView loadWithData:[self getFilterBarDataArrayAt:[number integerValue]]withStyle:[self getFilterBarDataStyle:[number integerValue]]];
    }
}

//返回选择的筛选条件，处理界面刷新工作
- (void)selView:(CNNAucSelView*)selView didSelectedItem:(id)selected{
    NSDictionary *dic = (NSDictionary*)selected;
}
```
