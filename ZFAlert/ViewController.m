//
//  ViewController.m
//  ZFAlert
//
//  Created by mac on 12/23/14.
//  Copyright (c) 2014 (zhifei - qiuzhifei521@gmail.com). All rights reserved.
//

#import "ViewController.h"
#import "ZFAlert.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, ZFAlertDelegate>

@property (nonatomic, strong) NSArray * models;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.models = @[@[@"sheet 范例1", @"一次添加多个 title"],
                    @[@"alert 范例1", @"一次添加多个 title", @"添加textfield"]];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.models count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.models objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer = @"identifer";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifer];
    }
    
    cell.textLabel.text = [[self.models objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * title = nil;
    
    switch (section) {
        case 0:
        {
            title = @"action sheet";
        }
            break;
            
        case 1:
        {
            title = @"alert";
        }
            break;
            
        default:
            break;
    }
    
    return title;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    switch (section) {
        case 0:
        {
            switch (row) {
                case 0:
                {
                    ZFAlert * alert = [ZFAlert alertWithTitle:@"title"
                                                      message:@"message"
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                                       fromVC:self];
                    alert.delegate = self;
                    [alert addButtonWithTitle:@"确定"];
                    [alert show];
                }
                    break;
                    
                case 1:
                {
                    ZFAlert * alert = [ZFAlert alertWithTitle:@"title"
                                                      message:@"message"
                                            cancelButtonTitle:@"取消"
                                       destructiveButtonTitle:nil
                                                       fromVC:self];
                    alert.delegate = self;
                    
                    NSArray * titles = @[@"男", @"女", @"保密"];
                    
                    [alert addButtonWithTitles:titles];
                    [alert show];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:
        {
            switch (row) {
                case 0:
                {
                    ZFAlert * alert = [ZFAlert alertWithTitle:@"title"
                                                      message:@"message"
                                            cancelButtonTitle:@"取消"
                                                       fromVC:self];
                    alert.delegate = self;
                    [alert addButtonWithTitle:@"确定"];
                    [alert show];
                }
                    break;
                    
                case 1:
                {
                    ZFAlert * alert = [ZFAlert alertWithTitle:@"title"
                                                      message:@"message"
                                            cancelButtonTitle:@"取消"
                                                       fromVC:self];
                    alert.delegate = self;
                    
                    NSArray * titles = @[@"男", @"女", @"保密"];
                    
                    [alert addButtonWithTitles:titles];
                    [alert show];
                }
                    break;
                    
                case 2:
                {
                    ZFAlert * alert = [ZFAlert alertWithTitle:@"title"
                                                      message:@"message"
                                            cancelButtonTitle:@"取消"
                                                       fromVC:self];
                    alert.delegate = self;
                    [alert addButtonWithTitle:@"确定"];
                    
                    [alert addTextField];
                    [alert show];
                }
                    break;

                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - ZFAlert delegate

- (void)alert:(ZFAlert *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"type == %d", alert.alertStyle);
    NSLog(@"index == %ld",(long)buttonIndex);
    
    if (alert.textField) {
        
        NSLog(@"text == %@", alert.textField.text);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
