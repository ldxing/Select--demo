//
//  ViewController.m
//  SelectDemo
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 zhengShengJiaoYu. All rights reserved.
//

#import "ViewController.h"
#import "SelectViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)selectAction:(id)sender
{
    SelectViewController * selectVC = [SelectViewController new];
    UINavigationController * naVC = [[UINavigationController alloc] initWithRootViewController:selectVC];
    [self showViewController:naVC sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
