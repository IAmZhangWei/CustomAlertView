//
//  ZWAlertView.h
//  ant3IOS
//
//  Created by ant on 15/11/4.
//  Copyright © 2015年 sanzhimayi. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 此枚举表示按钮的排列方向
 */
typedef enum : NSUInteger {
    /**按钮水平排列*/
    CustomButtonDirectionHorizontal = 100,
    /**按钮竖直排列*/
    CustomButtonDirectionVertical,
} CustomButtonsDirection;


/**
 *  定义Block，用于实现alertView上button的点击事件
 *
 *  @param buttonClickedIndex 被点击按钮的索引
 */
@class ZWAlertView;
typedef void(^CustomAlertViewCallBack)(ZWAlertView *alertView, NSInteger buttonClickedIndex);


/**
 *  定义协议，用于实现alertView上button的点击事件
 */
@protocol CustomAlertViewDelegate <NSObject>
@optional
-(void)alertView:(ZWAlertView *)alertView ButtonClickedAtIndex:(NSInteger)index;
@end


@interface ZWAlertView : UIControl

/**
 *  创建自定义弹出控件
 *
 *  @param title     控件的标题
 *  @param message   控件的提示信息
 *  @param titles    各个按钮的标题组成的数组
 *  @param direction 按钮的排列方向
 *  @param delegate  回调代理
 *  @return 自定义弹出控件对象
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles directionForButtons:(CustomButtonsDirection)direction delegate:(id<CustomAlertViewDelegate>)delegate;




/**
 *  创建自定义弹出控件
 *
 *  @param title     控件的标题
 *  @param message   控件的提示信息,信息为空时，传入nil
 *  @param buttonTitles    各个按钮的标题组成的数组
 *  @param direction 按钮的排列方向
 *  @param callBackBlock 用于回调的Block
 *  @return 自定义弹出控件对象
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles directionForButtons:(CustomButtonsDirection)direction callBackBlock:(CustomAlertViewCallBack)callBackBlock;




/**
 *  显示ZWAlertView
 */
- (void)show;




/**
 *  释放ZWAlertView
 */
- (void)dismiss;


@end
