//
//  UIView+Extern.h
//  STLoadiong
//
//  Created by shine-team1 on 16/10/31.
//  Copyright © 2016年 st. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;

@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;   

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint origin;

@property (nonatomic) CGFloat bottom;
@end
