//
//  ZFAlert.m
//  alertTest
//
//  Created by 仇志飞 on 14/12/21.
//  Copyright (c) 2014年 ZhiFei(qiuzhifei521@gmail.com). All rights reserved.
//

#import "ZFAlert.h"

BOOL ZFAlertiOS8 ()
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0;
}

@interface ZFAlert ()<UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIAlertController * alertVC;
@property (nonatomic, strong) UIAlertView * alertView;
@property (nonatomic, strong) UIActionSheet * actionSheet;

@property (nonatomic, weak) UIViewController * fromVC;

@end

@implementation ZFAlert

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle fromVC:(UIViewController *)vc
{
    ZFAlert * alert = [[ZFAlert alloc] initWithTitle:title
                                             message:message
                                   cancelButtonTitle:cancelButtonTitle
                                              fromVC:vc];
    
    return alert;
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle fromVC:(UIViewController *)vc
{
    ZFAlert * alert = [[ZFAlert alloc] initWithTitle:title
                                             message:message
                                   cancelButtonTitle:cancelButtonTitle
                              destructiveButtonTitle:destructiveButtonTitle
                                              fromVC:vc];
    
    return alert;
}


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle fromVC:(UIViewController *)vc
{
    self = [super init];
    if (self) {
        
        if (ZFAlertiOS8()) {
            
            self.alertVC = [UIAlertController alertControllerWithTitle:title
                                                               message:message
                                                        preferredStyle:UIAlertControllerStyleAlert];
            
            if (cancelButtonTitle) {
                
                [self addCancelWithTitle:cancelButtonTitle];
            }
        } else {
            
            self.alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:nil, nil];
        }
        
        _alertStyle = ZFAlertStyleAlert;
        
        self.fromVC = vc;
    }
    
    return self;
}


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle fromVC:(UIViewController *)vc
{
    self = [super init];
    if (self) {
        
        if (ZFAlertiOS8()) {
            
            self.alertVC = [UIAlertController alertControllerWithTitle:title
                                                               message:message
                                                        preferredStyle:UIAlertControllerStyleActionSheet];
            
            if (cancelButtonTitle) {
                
                [self addCancelWithTitle:cancelButtonTitle];
            }
        } else {
            
            self.actionSheet = [[UIActionSheet alloc]
                              initWithTitle:title
                              delegate:self
                              cancelButtonTitle:cancelButtonTitle
                              destructiveButtonTitle:destructiveButtonTitle
                              otherButtonTitles:nil, nil];
        }
        
        _alertStyle = ZFAlertStyleSheet;
        
        self.fromVC = vc;
    }
    
    return self;
}


#pragma mark - add

- (void)addCancelWithTitle:(NSString *)title
{
    if (ZFAlertiOS8()) {
        
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:title
                                                                style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction *action) {
                                                                  
                                                                  NSInteger index = [self.alertVC.actions indexOfObject:action];
                                                                  
                                                                  [self clickedButtonAtIndex:index];
                                                              }];
        
        [self.alertVC addAction:cancelAction];
    } else {
        
        [self.alertView addButtonWithTitle:title];
    }
}

- (void)addButtonWithTitle:(NSString *)title
{
    if (ZFAlertiOS8()) {
        
        UIAlertAction * action = [UIAlertAction actionWithTitle:title
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                             
                                                            NSInteger index = [self.alertVC.actions indexOfObject:action];
                                                            
                                                            [self clickedButtonAtIndex:index];
                                                         }];
        [self.alertVC addAction:action];
    } else {
        
        [self.alertView addButtonWithTitle:title];
    }
}

- (void)addButtonWithTitles:(NSArray *)titles
{
    for (NSString * title in titles) {
        
        [self addButtonWithTitle:title];
    }
}

- (UITextField *)addTextField
{
    UITextField * textField = nil;
    
    if (self.alertStyle == ZFAlertStyleAlert) {
        
        if (ZFAlertiOS8()) {
            
            [self.alertVC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                
            }];
            textField = [self.alertVC.textFields firstObject];
        } else {
            
            self.alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            textField = [self.alertView textFieldAtIndex:0];
        }
        
        self.textField = textField;
    }
    
    return textField;
}

#pragma mark - action

- (void)show
{
    if (ZFAlertiOS8()) {
        
        [self.fromVC presentViewController:self.alertVC
                                  animated:YES
                                completion:nil];
    } else {
        
        [self.alertView show];
    }
}

- (void)clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_delegate &&
        [_delegate respondsToSelector:@selector(alert:clickedButtonAtIndex:)]) {
        
        [_delegate alert:self clickedButtonAtIndex:buttonIndex];
        
    }
}
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self clickedButtonAtIndex:buttonIndex];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self clickedButtonAtIndex:buttonIndex];
}

@end
