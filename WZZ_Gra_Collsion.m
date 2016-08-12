//
//  WZZ_Gra_Collsion.m
//  WZZ_DynamicDemo
//
//  Created by 王召洲 on 16/8/11.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Gra_Collsion.h"

@interface WZZ_Gra_Collsion ()
@property (strong,nonatomic) UIDynamicAnimator * animator;

@end

@implementation WZZ_Gra_Collsion
-(UIDynamicAnimator *)animator {
    if (!_animator ) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 6; i++) {
        UIView *item = [[UIView alloc]initWithFrame:CGRectMake(i*50, i*50, 50, 50)];
        item.tag = i+1;
        item.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0  blue:arc4random_uniform(256)/255.0  alpha:1];
        [self.view addSubview:item];
    }
    
    UIGravityBehavior *gra = [[UIGravityBehavior alloc]initWithItems:self.view.subviews];
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:self.view.subviews];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    collision.collisionMode = UICollisionBehaviorModeEverything;
    
    UIDynamicItemBehavior *itemBehavor = [[UIDynamicItemBehavior alloc]initWithItems:self.view.subviews];
    itemBehavor.allowsRotation = YES;
    [itemBehavor addAngularVelocity:M_PI_4 forItem:[self.view viewWithTag:6]];
    itemBehavor.density = 2;
    itemBehavor.elasticity = 1;
    
    UIDynamicBehavior *control = [[UIDynamicBehavior alloc]init];
    [control addChildBehavior:itemBehavor];
    [control addChildBehavior:gra];
    [control addChildBehavior:collision];
    
    
    
    
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
