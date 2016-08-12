//
//  WZZ_Push.m
//  WZZ_DynamicDemo
//
//  Created by 王召洲 on 16/8/11.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Push.h"

@interface WZZ_Push ()
@property (strong,nonatomic) UIDynamicAnimator * animator;
@property (weak,nonatomic) NSArray  * items;
@end

@implementation WZZ_Push

-(UIDynamicAnimator *)animator {
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return  _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *item = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    item.backgroundColor = [UIColor redColor];
    [self.view addSubview:item];
    self.items = self.view.subviews;
    
    
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.animator removeAllBehaviors];
    
    UITouch *touch = [touches anyObject];
    CGPoint prepoint = [touch previousLocationInView:self.view];
    CGPoint nowPoint = [touch locationInView:self.view];
    
    CGVector  vg= CGVectorMake(nowPoint.x-prepoint.x, nowPoint.y-prepoint.y);
    UIPushBehavior *push = [[UIPushBehavior alloc]initWithItems:self.items mode:(UIPushBehaviorModeInstantaneous)];
    push.pushDirection = vg;
    push.magnitude = 0.5;
    
    UIDynamicItemBehavior *itemB = [[UIDynamicItemBehavior alloc]initWithItems:self.items];
    itemB.friction = 0.3;
    UIDynamicBehavior *control = [[UIDynamicBehavior alloc]init];
    [control addChildBehavior:itemB];
    [control addChildBehavior:push];
    [self.animator addBehavior:control];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
