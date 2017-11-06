# CustomKeyBoardView
自定义键盘(包含纯数字键盘、身份证输入键盘、带小数点纯数字键盘)

typedef enum : NSUInteger {
    CustomKeyBoardInputX, //身份证键盘
    CustomKeyBoardInputPoint, //全数字键盘
    CustomKeyBoardInputNoPoint, //带小数点全数字键盘
} CustomKeyBoardType;

-(void)inputCurrentKeyWith:(BOOL (^)(NSString *, UITextField *, NSRange))currentKey; 相当于 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; 需要返回值。
