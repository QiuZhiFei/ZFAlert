//
//  ZFAlert.h
//  alertTest
//
//  Created by 仇志飞 on 14/12/21.
//  Copyright (c) 2014年 ZhiFei(qiuzhifei521@gmail.com). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZFAlert;

typedef enum {
    
    ZFAlertStyleAlert = 0,
    ZFAlertStyleSheet = 1
} ZFAlertStyle;

@protocol ZFAlertDelegate <NSObject>

@optional

- (void)alert:(ZFAlert *)alert clickedButtonAtIndex:(NSInteger)buttonIndex isCancel:(BOOL)flag;

@end

@interface ZFAlert : NSObject

#pragma mark - init

// action sheet

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle fromVC:(UIViewController *)vc;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle fromVC:(UIViewController *)vc;


// alert view

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle fromVC:(UIViewController *)vc;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle fromVC:(UIViewController *)vc;


#pragma mark - property

@property (nonatomic, weak) id<ZFAlertDelegate>delegate;

@property (nonatomic, strong) UITextField * textField;

@property (nonatomic, assign, readonly) ZFAlertStyle alertStyle;

#pragma mark - add

- (void)addButtonWithTitle:(NSString *)title;
- (void)addButtonWithTitles:(NSArray *)titles;

- (UITextField *)addTextField;

#pragma mark - action

- (void)show;

@end
