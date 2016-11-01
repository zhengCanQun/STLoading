//
//  LoadingTool.h
//  STLoadiong
//
//  Created by shine-team1 on 16/10/31.
//  Copyright © 2016年 st. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoadingTool : NSObject

//创建实例
+ (LoadingTool *)sharedInstance;

//显示动画
- (void)Show;

//隐藏动画
- (void)disappear;



@end
