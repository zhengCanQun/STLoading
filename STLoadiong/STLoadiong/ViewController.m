//
//  ViewController.m
//  STLoadiong
//
//  Created by shine-team1 on 16/10/31.
//  Copyright © 2016年 st. All rights reserved.
//

#import "ViewController.h"
#import "LoadingTool.h"
#import "UIView+Extension.h"

@interface ViewController ()

@property (nonatomic, weak)LoadingTool *loadinTool;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"开启" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtionItem)];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtionItem)];
    

}

- (void)leftButtionItem
{
    [[LoadingTool sharedInstance] Show];
}

- (void)rightButtionItem
{
    [[LoadingTool sharedInstance] disappear];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
