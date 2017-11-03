//
//  CustomKeyBoardView.h
//  CustomKeyBoardView
//
//  Created by 钟兴文 on 2017/10/9.
//  Copyright © 2017年 钟兴文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+Method.m"

typedef enum : NSUInteger {
    CustomKeyBoardInputX,//身份证键盘
    CustomKeyBoardInputPoint,//带小数点数字键盘
    CustomKeyBoardInputNoPoint,//纯数字键盘
} CustomKeyBoardType;

@interface CustomKeyBoardView : UIView

@property (nonatomic,weak) UITextField *textField;//输入框

-(instancetype)initCustomKeyBoardViewWith:(CustomKeyBoardType)cType;//初始化视图
-(void)inputCurrentKeyWith:(BOOL(^)(NSString *cKey ,UITextField *tField ,NSRange location))currentKey;//获取输入信息

@end
