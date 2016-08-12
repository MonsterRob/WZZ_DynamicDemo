//
//  WZZ_Snap.m
//  WZZ_DynamicDemo
//
//  Created by 王召洲 on 16/8/11.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Snap.h"

@interface WZZ_Snap ()
@property (strong,nonatomic) UIDynamicAnimator * animator;

@end

@implementation WZZ_Snap
-(UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *item = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    item.backgroundColor = [UIColor redColor];
    item.tag = 1;
    item.layer.anchorPoint = CGPointZero;
    item.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    [self.view addSubview:item];
    
    
    UIView *item1 = [[UIView alloc]initWithFrame:CGRectMake(200, 100, 100, 100)];
    item1.backgroundColor = [UIColor redColor];
    item1.tag = 2;
    item1.layer.anchorPoint = CGPointZero;
    item1.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    [self.view addSubview:item1];

    
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.animator removeAllBehaviors];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    UIView *item1 = [self.view viewWithTag:1];
    UIView *item2 = [self.view viewWithTag:2];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:item1 snapToPoint:touchPoint];
    
    snap.damping = 0.1;
    
    UISnapBehavior *snap1 = [[UISnapBehavior alloc]initWithItem:item2   snapToPoint:item1.center];
    
    snap1.damping = 0.1;
    
    snap.action = ^() {
        
       [self.view viewWithTag:1].transform = CGAffineTransformMakeRotation(M_PI_4);
    };
    UIDynamicBehavior *control = [[UIDynamicBehavior alloc]init];
    
    [control addChildBehavior:snap];
    [control addChildBehavior:snap1];
    
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
