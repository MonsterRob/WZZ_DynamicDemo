//
//  WZZ_CradleView.m
//  WZZ_DynamicDemo
//
//  Created by 王召洲 on 16/8/11.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_CradleView.h"


@interface WZZ_CradleView ()
@property (strong,nonatomic) NSMutableArray * balls;
@property (strong,nonatomic) NSMutableArray * anchors;
@property (strong,nonatomic) UIPushBehavior * push;
@end
@implementation WZZ_CradleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configAnchors];
        self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self];
        [self creatBehaviorsForBalls];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}
// 懒加载配置小球
-(NSMutableArray *)balls
{
    if (_balls == nil)
    {
        _balls = [NSMutableArray array];
        
        
        for (int i = 0; i < 5; i ++)
        {
            UIView * item = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            [_balls addObject:item];
            
            item.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
            item.layer.cornerRadius = 25;
            
            item.center = CGPointMake(80 + i* 50, self.center.y);
            
            
            UIPanGestureRecognizer *pan= [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
            [item addGestureRecognizer:pan];
            
            
            [item addObserver:self forKeyPath:@"center" options:(NSKeyValueObservingOptionNew) context:nil];
            
            [self addSubview:item];
        }
    }
    return _balls;
}
// 配置锚点
-(void)configAnchors {
    _anchors = [NSMutableArray array];
    
    for (UIView *item in self.balls) {
        CGPoint p = CGPointMake(item.center.x, 100);
        NSValue *v  = [NSValue valueWithCGPoint:p];
        [_anchors addObject:v];
        UIView *anchorV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        anchorV.center = p;
        anchorV.backgroundColor = [UIColor redColor];
        anchorV.layer.cornerRadius = 5;
        [self addSubview:anchorV];
    }
}
// 配置动画
-(void)creatBehaviorsForBalls {
    UIDynamicBehavior *control = [[UIDynamicBehavior alloc]init];
    [self setAttachForBalls:control];
    [control addChildBehavior:[self creatItemB]];
    [control addChildBehavior:[self creatCollision]];
    [control addChildBehavior:[self creatGraForBalls]];
    [self.animator addBehavior:control];
    
}
-(void)setAttachForBalls:(UIDynamicBehavior *)behavior {
    for (int i = 0; i < self.balls.count; i++) {
        [behavior addChildBehavior:[self attachFor:self.balls[i] forPoint:self.anchors[i]]];
    }
    
}
-(UIDynamicBehavior *)creatGraForBalls {
    UIGravityBehavior *gra = [[UIGravityBehavior alloc]initWithItems:self.balls];
    return gra;
}
-(UIDynamicBehavior *)creatCollision {
    UICollisionBehavior *col = [[UICollisionBehavior alloc]initWithItems:self.balls];
    return col;
}
-(UIDynamicBehavior *)creatItemB {
    UIDynamicItemBehavior *itemB = [[UIDynamicItemBehavior alloc]initWithItems:self.balls];
    itemB.density = 1;
    itemB.elasticity = 1;
    itemB.resistance = 0.1;
    itemB.allowsRotation = NO;
    return itemB;
}
-(UIDynamicBehavior *)attachFor:(id<UIDynamicItem>)ball forPoint:(NSValue*)pointValue {
    UIAttachmentBehavior *att = [[UIAttachmentBehavior alloc]initWithItem:ball attachedToAnchor:pointValue.CGPointValue];
    return att;
}

// 手势处理
-(void)pan:(UIPanGestureRecognizer *)sender {
    
    // 初始状态去除原来的动作
    if (sender.state == UIGestureRecognizerStateBegan) {
            _push = [[UIPushBehavior alloc]initWithItems:@[sender.view] mode:(UIPushBehaviorModeContinuous)];
            [self.animator addBehavior:_push];
    }
    // 推力的方向和大小
    _push.pushDirection = CGVectorMake([sender translationInView:self].x/20, 0);
    
    if (sender.state ==UIGestureRecognizerStateEnded) {
        [self.animator removeBehavior:_push];
        _push = nil;
    }
    
}
- (void)drawRect:(CGRect)rect {
    for (int i = 0; i < 5; i++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        NSValue *v = self.anchors[i];
        CGPoint p = [v CGPointValue];
        [path moveToPoint:p];
        UIView *item = self.balls[i];
        [path addLineToPoint:item.center];
        path.lineWidth = 2;
        [[UIColor redColor] setStroke];
        [path stroke];
    }
}
// 使用KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self setNeedsDisplay];
}
// 使用了KVO 注意注意！！！
-(void)dealloc {
    for (UIView *ball in self.balls) {
        [ball removeObserver:self forKeyPath:@"center"];
    }
}
@end
