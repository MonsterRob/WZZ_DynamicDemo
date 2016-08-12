//
//  WZZ_Gravity.m
//  WZZ_DynamicDemo
//
//  Created by 王召洲 on 16/8/11.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Gravity.h"

@interface WZZ_Gravity ()
@property (strong,nonatomic) NSMutableArray * items;
@property (strong,nonatomic) UIDynamicAnimator * animator;
@end

@implementation WZZ_Gravity
-(NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *item1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    item1.center = CGPointMake(self.view.center.x, 84);
    item1.transform = CGAffineTransformMakeRotation(M_PI_4);
    item1.backgroundColor = [UIColor redColor];
    [self.view addSubview:item1]; // Must be added to ReferenceView
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(200, 200, 100, 40);
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];// Must be added to ReferenceView

    [self.items addObject:item1];
    [self.items addObject:btn];
    
    UIGravityBehavior *gra = [[UIGravityBehavior alloc]initWithItems:self.items];
    
   // 1000p/s^2 the dafault gravity
    
    // Direction Control
    gra.angle = M_PI_2; // the default direction
    //gra.gravityDirection = CGVectorMake(0, 0.5);
    
    // Gravity Control
    gra.magnitude = 0.2;
    
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    [self.animator addBehavior:gra];
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
