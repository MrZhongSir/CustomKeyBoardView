//
//  ViewController.m
//  CustomKeyBoardView
//
//  Created by 钟兴文 on 2017/11/3.
//  Copyright © 2017年 钟兴文. All rights reserved.
//

#import "ViewController.h"
#import "CustomKeyBoardView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CustomKeyBoardView *kView = [[CustomKeyBoardView alloc]initCustomKeyBoardViewWith:CustomKeyBoardInputNoPoint];
    kView.textField = self.myTextField;
    self.myTextField.inputView = kView;
    
    [kView inputCurrentKeyWith:^BOOL(NSString *cKey, UITextField *tField, NSRange location) {
        //修改后的字符串
        NSMutableString *modifiedString = [NSMutableString stringWithString:tField.text];
        [modifiedString replaceCharactersInRange:location withString:cKey];
        
        //手机号码输入限制11位
        return modifiedString.length <= 11;
    }];
}

- (IBAction)closeKeyBoardView:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
