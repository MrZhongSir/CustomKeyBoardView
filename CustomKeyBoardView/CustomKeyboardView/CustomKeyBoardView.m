//
//  CustomKeyBoardView.m
//  CustomKeyBoardView
//
//  Created by 钟兴文 on 2017/10/9.
//  Copyright © 2017年 钟兴文. All rights reserved.
//

#import "CustomKeyBoardView.h"

/*************************UI相关（kUI）*************************/
#define kUI_WIDTH        [UIScreen mainScreen].bounds.size.width
#define kUI_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define kHeight   216.0

//PingFangSC-Regular(系统默认字体)
#define kFONT_PingFang(m) [UIFont systemFontOfSize:m]
//16进制颜色
#define kCOLOR_RGBValue(RGBValue)   [UIColor colorWithRed:((float)((RGBValue & 0xFF0000) >> 16))/255.0 \
green:((float)((RGBValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((RGBValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface CustomKeyBoardView()

@property (nonatomic,copy) BOOL(^saveBlock)(NSString* cKey,UITextField* tField,NSRange location);

@end

@implementation CustomKeyBoardView

-(instancetype)initCustomKeyBoardViewWith:(CustomKeyBoardType)cType
{
    self = [super initWithFrame:CGRectMake(0, 0, kUI_WIDTH, 216.0)];
    
    if (self)
    {
        [self initViewWithType:cType];
    }
    
    return self;
}

-(void)initViewWithType:(CustomKeyBoardType)type
{
    //布局视图
    for (int i=0; i<12; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i%3*kUI_WIDTH/3.0, i/3*kHeight/4.0, kUI_WIDTH/3.0, kHeight/4.0);
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.font = kFONT_PingFang(28.0);
        [button setTitleColor:kCOLOR_RGBValue(0x030303) forState:UIControlStateNormal];
        button.backgroundColor = kCOLOR_RGBValue(0xffffff);
        [button addTarget:self action:@selector(showSelectedKey:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (i==9)
        {
            NSString *string = type==CustomKeyBoardInputX?@"X":type==CustomKeyBoardInputPoint?@".":@"";
            [button setTitle:string forState:UIControlStateNormal];
            button.backgroundColor = kCOLOR_RGBValue(0xcbd0d6);
            if ([string isEqualToString:@""])
                button.userInteractionEnabled = NO;
            else
                button.userInteractionEnabled = YES;
        }
        else if (i==10)
        {
            [button setTitle:@"0" forState:UIControlStateNormal];
        }
        else if (i==11)
        {
            [button setImage:[UIImage imageNamed:@"keyBack.png"] forState:UIControlStateNormal];
            [button setTitle:@"" forState:UIControlStateNormal];
            button.backgroundColor = kCOLOR_RGBValue(0xcbd0d6);
        }
    }
    
    //添加纵向分割线
    for (int i_1=0; i_1<2; i_1++)
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((i_1+1)*kUI_WIDTH/3.0, 0.0, 1.0, kHeight)];
        lineView.backgroundColor = kCOLOR_RGBValue(0xcbd0d6);
        [self addSubview:lineView];
    }
    
    //添加横向分割线
    for (int i_2=0; i_2<3; i_2++)
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0.0, (i_2+1)*kHeight/4.0, kUI_WIDTH, 1.0)];
        lineView.backgroundColor = kCOLOR_RGBValue(0xcbd0d6);
        [self addSubview:lineView];
    }
}

-(void)showSelectedKey:(UIButton*)sender
{
    NSLog(@"___________%@",sender.titleLabel.text);
    
    if (sender.tag<=10)
    {
        if (!self.saveBlock(sender.titleLabel.text,self.textField,[self.textField selectedRange])) return;
        
        NSRange range = [self.textField selectedRange];
        
        if (range.location==self.textField.text.length)//末尾输入
        {
            self.textField.text = [NSString stringWithFormat:@"%@%@",self.textField.text,sender.titleLabel.text];
        }
        else//中间插入
        {
            if(range.length>0)//选中替换
            {
                self.textField.text = [self.textField.text stringByReplacingCharactersInRange:range withString:sender.titleLabel.text];
            }
            else//中间插入
            {
                self.textField.text = [self.textField.text stringByReplacingCharactersInRange:range withString:sender.titleLabel.text];
            }
            
            [self.textField setSelectedRange:NSMakeRange(range.location+1, 0)];
        }
    }
    else
    {
        if (self.textField!=nil)//textfield不为空
        {
            
            NSRange range = [self.textField selectedRange];
            
            if (self.textField.text.length>0)
            {
                if (range.location==0&&range.length==0) return;//光标位置为0
                
                if (range.length==0)//删除上一位字符
                {
                    NSRange selectRange = NSMakeRange(range.location-1, 1);
                    
                    if (!self.saveBlock(@"",self.textField,selectRange)) return;
                    
                    self.textField.text = [self.textField.text stringByReplacingCharactersInRange:selectRange withString:@""];
                    [self.textField setSelectedRange:NSMakeRange(selectRange.location, 0)];
                }
                else//删除选中的字符
                {
                    if (!self.saveBlock(@"",self.textField,range)) return;
                    
                    self.textField.text = [self.textField.text stringByReplacingCharactersInRange:range withString:@""];
                    [self.textField setSelectedRange:NSMakeRange(range.location, 0)];
                }
            }
        }
    }
}

-(void)inputCurrentKeyWith:(BOOL (^)(NSString *, UITextField *, NSRange))currentKey
{
    self.saveBlock = currentKey;
}

@end
