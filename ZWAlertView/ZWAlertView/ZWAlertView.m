//
//  ZWAlertView.m
//  ant3IOS
//
//  Created by ant on 15/11/4.
//  Copyright © 2015年 sanzhimayi. All rights reserved.
//

#import "ZWAlertView.h"
#import "AppDelegate.h"

@implementation ZWAlertView {
    UIView *_alertView;
    UIWindow *_rootWindow;
    
    NSString *_title;
    NSString *_message;
    NSArray *_buttonTitles;
    CustomButtonsDirection _direction;
    __weak id<CustomAlertViewDelegate> _delegate;
    __weak CustomAlertViewCallBack _callBackBlock;
}


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles directionForButtons:(CustomButtonsDirection)direction delegate:(id<CustomAlertViewDelegate>)delegate {
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        _buttonTitles = buttonTitles;
        _direction = direction;
        _delegate = delegate;
        [self configUI];
    }
    return self;
}



- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles directionForButtons:(CustomButtonsDirection)direction callBackBlock:(CustomAlertViewCallBack)callBackBlock {
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        _buttonTitles = buttonTitles;
        _direction = direction;
        _callBackBlock = callBackBlock;
        [self configUI];
    }
    return self;
}


- (void)configUI {
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithWhite:0.569 alpha:0.800];
    
    //给self 添加事件
    [self addTarget:self action:@selector(tapGRAction) forControlEvents:UIControlEventTouchUpInside];
    
    //初始化 AlertView
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    _rootWindow = appDelegate.window;
    _alertView = [[UIView alloc] init];
    CGFloat alertViewW = CGRectGetWidth(_rootWindow.frame)-20*2;
    _alertView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_alertView];
    
    //设置 Title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertViewW, 40)];
    if (_title == nil) {
        titleLabel.text = @"提示";
    } else {
        titleLabel.text = _title;
    }
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.651 green:0.000 blue:0.090 alpha:1.000];
    [_alertView addSubview:titleLabel];
    
    //添加线条
    UIView *redLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), alertViewW, 1)];
    redLine.backgroundColor = [UIColor colorWithRed:0.651 green:0.000 blue:0.090 alpha:1.000];
    [_alertView addSubview:redLine];
    
    //设置 Message
    UILabel *messageLabel = [[UILabel alloc] init];
    CGFloat messageGap = 10;
    CGFloat messageW = alertViewW - 2*messageGap;
    if (_message == nil) {
        messageLabel.frame = CGRectMake(messageGap, CGRectGetMaxY(redLine.frame), messageW, 0);
    } else {
        messageLabel.text = _message;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont systemFontOfSize:16];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize messageSize = [messageLabel sizeThatFits:CGSizeMake(messageW, 0)];
        messageLabel.frame = CGRectMake(messageGap, CGRectGetMaxY(redLine.frame), messageW, messageSize.height+20);
        [_alertView addSubview:messageLabel];
    }
    
    //设置line
    UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(messageLabel.frame), alertViewW, 1)];
    grayLine.backgroundColor = [UIColor colorWithWhite:0.835 alpha:1.000];
    if (_message == nil) {
        grayLine.frame = CGRectMake(0, CGRectGetMaxY(messageLabel.frame), alertViewW, 0);
    }
    [_alertView addSubview:grayLine];
    
    //设置 Button
    CGFloat buttonMaxY = 0;
    if (_direction == CustomButtonDirectionHorizontal) {
        CGFloat btnW = alertViewW/_buttonTitles.count;
        CGFloat btnH = 40;
        for (NSInteger index = 0; index < _buttonTitles.count; index++) {
            UIButton *btn = [self createButtonWithIndex:index];
            btn.frame = CGRectMake(index*btnW, CGRectGetMaxY(grayLine.frame), btnW, btnH);
            [_alertView addSubview:btn];
            if (index != 0) {
                UIView *gapLine = [[UIView alloc] initWithFrame:CGRectMake(index*btnW-1, CGRectGetMaxY(grayLine.frame), 1, btnH)];
                gapLine.backgroundColor = [UIColor colorWithWhite:0.796 alpha:1.000];
                [_alertView addSubview:gapLine];
            }
        }
        buttonMaxY = CGRectGetMaxY(grayLine.frame)+btnH;
        
    } else {
        
        CGFloat lineMinY = CGRectGetMaxY(messageLabel.frame);
        CGFloat btnH = 40;
        for (NSInteger index = 0; index < _buttonTitles.count; index++) {
            //添加线条
            UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(0, lineMinY, alertViewW, 1)];
            grayLine.backgroundColor = [UIColor colorWithWhite:0.780 alpha:1.000];
            [_alertView addSubview:grayLine];
            
            UIButton *btn = [self createButtonWithIndex:index];
            btn.frame = CGRectMake(0, CGRectGetMaxY(grayLine.frame), alertViewW, btnH);
            [_alertView addSubview:btn];
            lineMinY = CGRectGetMaxY(btn.frame);
        }
        buttonMaxY = lineMinY;
    }
    
    //设置 AlertView的大小及位置
    _alertView.frame = CGRectMake(0, 0, alertViewW, buttonMaxY);
    _alertView.center = _rootWindow.center;
}

- (UIButton *)createButtonWithIndex:(NSInteger)index {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor colorWithWhite:0.224 alpha:1.000] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [btn setTitle:_buttonTitles[index] forState:UIControlStateNormal];
    btn.tag = index;
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

#pragma mark - btnClicked
- (void)btnClicked:(UIButton *)sender {
    if (_delegate != nil) {
        if ([_delegate respondsToSelector:@selector(alertView:ButtonClickedAtIndex:)]) {
            [_delegate alertView:self ButtonClickedAtIndex:sender.tag];
        }
    } else {
        if (_callBackBlock != nil) {
            _callBackBlock(self, sender.tag);
        }
    }
}

- (void)drawRect:(CGRect)rect {
    self.frame = [UIScreen mainScreen].bounds;
}

- (void)show {
    [_rootWindow addSubview:self];
}


- (void)dismiss {
    [self removeFromSuperview];
}

#pragma masrk - tapGRAction
- (void)tapGRAction {
    [self removeFromSuperview];
}



@end
