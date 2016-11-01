//
//  LoadingTool.m
//  STLoadiong
//
//  Created by shine-team1 on 16/10/31.
//  Copyright © 2016年 st. All rights reserved.
//

#import "LoadingTool.h"
#import "UIView+Extension.h"

@interface LoadingView : UIView

//隐藏动画
- (void)hideLoadingView;

@end

@interface LoadingView ()<CAAnimationDelegate>

@property (nonatomic, weak)UIView *roundOne;
@property (nonatomic, weak)UIView *roundTwo;
@property (nonatomic, weak)UIView *roundTree;
@property (nonatomic, weak)UIColor *colorOne;
@property (nonatomic, weak)UIColor *colorTwo;
@property (nonatomic, weak)UIColor *colorTree;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self setLoadinView];
        
    }
    return self;
}

- (void)setLoadinView
{
    UIColor *color1 = [UIColor colorWithRed:10/255.0 green:100/255.0 blue:8/255.0 alpha:1];
    UIColor *color2 = [UIColor colorWithRed:10/255.0 green:100/255.0 blue:8/255.0 alpha:0.6];
    UIColor *color3 = [UIColor colorWithRed:10/255.0 green:100/255.0 blue:8/255.0 alpha:0.3];
    
    self.colorOne = color1;
    self.colorTwo = color2;
    self.colorTree = color3;
    
    UIView *roundOne = [[UIView alloc]init];
    roundOne.width = 10;
    roundOne.height = 10;
    roundOne.layer.cornerRadius = roundOne.height/2;
    roundOne.backgroundColor = color1;
    self.roundOne = roundOne;
    
    UIView *roundTwo = [[UIView alloc]init];
    roundTwo.width = 10;
    roundTwo.height = 10;
    roundTwo.layer.cornerRadius = roundOne.height/2;
    roundTwo.backgroundColor = color2;
    self.roundTwo = roundTwo;
    
    UIView *roundTree = [[UIView alloc]init];
    roundTree.width = 10;
    roundTree.height = 10;
    roundTree.layer.cornerRadius = roundOne.height/2;
    roundTree.backgroundColor = color3;
    self.roundTree = roundTree;
    
    [self addSubview:roundOne];
    [self addSubview:roundTwo];
    [self addSubview:roundTree];
    
    //设置3个圆的X和Y
    self.roundTwo.centerX = self.centerX;
    self.roundTwo.centerY = self.centerY - self.width/10;
    
    self.roundOne.centerX = self.roundTwo.centerX - 20;
    self.roundOne.centerY = self.roundTwo.centerY;
    
    self.roundTree.centerX = self.roundTwo.centerX + 20;
    self.roundTree.centerY = self.roundTwo.centerY;
    
    
    [self startAnim];
}

- (void)startAnim
{
    
    CGPoint otherRoundCenterOne = CGPointMake(self.roundOne.centerX + 10, self.roundTwo.centerY);
    CGPoint otherRoundCenterTwo = CGPointMake(self.roundTwo.centerX + 10, self.roundTwo.centerY);
    
    CGFloat startAngle = -(M_PI);
    
    //圆1的路径
    UIBezierPath *pathOne = [[UIBezierPath alloc]init];
    [pathOne addArcWithCenter:otherRoundCenterOne radius:10 startAngle:startAngle endAngle:0 clockwise:true];
    UIBezierPath *pathOne_1 = [[UIBezierPath alloc]init];
    [pathOne_1 addArcWithCenter:otherRoundCenterTwo radius:10 startAngle:startAngle endAngle:0 clockwise:false];
    [pathOne appendPath:pathOne_1];
    
    [self viewMovePathAnim:self.roundOne withPath:pathOne andTime:1.5];
    [self viewColorAnimWithView:self.roundOne formColor:self.colorOne toColor:self.colorTree time:1.5];
    
    //圆2的路径
    UIBezierPath *pathTow = [[UIBezierPath alloc]init];
    [pathTow addArcWithCenter:otherRoundCenterOne radius:10 startAngle:0 endAngle:startAngle clockwise:true];
    
    [self viewMovePathAnim:self.roundTwo withPath:pathTow andTime:1.5];
    [self viewColorAnimWithView:self.roundTwo formColor:self.colorTwo toColor:self.colorOne time:1.5];
    
    //圆3的路径
    UIBezierPath *pathThree = [[UIBezierPath alloc]init];
    [pathThree addArcWithCenter:otherRoundCenterTwo radius:10 startAngle:0 endAngle:startAngle clockwise:false];
    
    [self viewMovePathAnim:self.roundTree withPath:pathThree andTime:1.5];
    [self viewColorAnimWithView:self.roundTree formColor:self.colorTree toColor:self.colorTwo time:1.5];
    
}

//设置view的移动路线
- (void)viewMovePathAnim:(UIView *)view withPath:(UIBezierPath *)path andTime:(double)time
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anim.path = path.CGPath;
    anim.fillMode =  kCAFillModeForwards;
    anim.calculationMode = kCAAnimationCubic;
    anim.repeatCount = 50;
    anim.duration = time;
    anim.delegate = self;
    anim.autoreverses = false;
    anim.removedOnCompletion = false;
    
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.timingFunction = function;
    
    [view.layer addAnimation:anim forKey:@"animation"];
    
}

//添加round1的颜色路径效果
- (void)viewColorAnimWithView:(UIView *)view formColor:(UIColor* )formColor toColor:(UIColor* )toColor time:(double)time
{
    CABasicAnimation *colorAnim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    
    colorAnim.toValue = (__bridge id _Nullable)(toColor.CGColor);
    colorAnim.fromValue = (__bridge id _Nullable)(formColor.CGColor);
    colorAnim.duration = time;
    colorAnim.fillMode = kCAFillModeForwards;
    colorAnim.repeatCount = 50; //重复的次数
    colorAnim.autoreverses = false;
    colorAnim.removedOnCompletion = false; //我的理解就是当repeatcount设置的次数执行完后就删除此次轨迹
    
    [view.layer addAnimation:colorAnim forKey:@"backgroundColor"];
}

//动画轨迹停止的代理
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self hideLoadingView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.roundTwo.centerX = self.centerX;
    self.roundTwo.centerY = self.centerY;
    
    self.roundOne.centerX = self.roundTwo.centerX - 20;
    self.roundOne.centerY = self.centerY;
    
    self.roundTree.centerX = self.roundTwo.centerX + 20;
    self.roundTree.centerY = self.centerY;
}

//隐藏动画
- (void)hideLoadingView
{
    [self removeFromSuperview];
    [self.roundOne.layer removeAllAnimations];
    [self.roundTwo.layer removeAllAnimations];
    [self.roundTree.layer removeAllAnimations];
 
}

- (void)dealloc
{
    NSLog(@"销毁了");
}

@end


@interface loadingVc : UIViewController

//定义block
@property (nonatomic,copy) void (^loadViewControllerBlock)();

@end

@interface loadingVc()

@property (weak, nonatomic)LoadingView *load;

@end

@implementation loadingVc

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor clearColor];
}

@end




@interface LoadingTool()

@property (nonatomic, strong)UIWindow *window;
@property (weak ,nonatomic)LoadingView *loading;
@property (weak ,nonatomic)loadingVc *loadVc;

@end

@implementation LoadingTool

+(LoadingTool *)sharedInstance
{
    static LoadingTool *shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareClient = [[LoadingTool alloc]init];
    });
    return shareClient;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (void)Show
{
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.window.backgroundColor = [UIColor clearColor];
    self.window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.window.opaque = NO;
    loadingVc *viewController = [[loadingVc alloc] init];
    self.loadVc = viewController;
    self.window.rootViewController = viewController;
    self.loadVc = viewController;
    
    LoadingView *load = [[LoadingView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.loading = load;
    [viewController.view addSubview:load];
    
    [self.window makeKeyAndVisible];
}

- (void)disappear
{
    
    [self cleanup];
}

- (void)cleanup
{
    [self.loading hideLoadingView];
    [self.window removeFromSuperview];
    self.loadVc = nil;
    self.window = nil;
}

@end

