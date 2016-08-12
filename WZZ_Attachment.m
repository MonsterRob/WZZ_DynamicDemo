//
//  WZZ_Attachment.m
//  WZZ_DynamicDemo
//
//  Created by 王召洲 on 16/8/11.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Attachment.h"

@interface WZZ_Attachment ()
@property (weak,nonatomic) NSArray *items;
@property (strong,nonatomic) UIDynamicAnimator * animator;
@end

@implementation WZZ_Attachment

-(UIDynamicAnimator *)animator {
    if (_animator == nil) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return  _animator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 5; i++) {
        
        UIView *item = [[UIView alloc]initWithFrame:CGRectMake(30+i*80,self.view.bounds.size.height-100, 50, 50)];
        if (i == 0) {
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
            [item addGestureRecognizer:pan];
        }
        item.layer.cornerRadius = 25;
        item.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        [self.view addSubview:item];
    }
    self.items = self.view.subviews;
}
-(void)pan:(UIPanGestureRecognizer *)sender {
    
    
    [self.animator removeAllBehaviors];
    
    CGPoint point = [sender locationInView:self.view];

    
    
    UIDynamicBehavior *control = [[UIDynamicBehavior alloc]init];
    
    for (int i = 0; i < 5; i++) {
        UIAttachmentBehavior *att;
        if (i == 0) {
            att = [[UIAttachmentBehavior alloc]initWithItem:self.items[i] attachedToAnchor:point];
            att.length = 80;
            
        }
        else {
            att = [[UIAttachmentBehavior alloc]initWithItem:self.items[i] attachedToItem:self.items[i-1]];
            att.length = 60;
            
        }
        att.damping = 0.4;
        att.frequency = 3;
        [control addChildBehavior:att];
        
    }
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:self.items];
    collision.collisionMode = UICollisionBehaviorModeEverything;
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
    [self.animator addBehavior:control];
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        UIGravityBehavior *gra = [[UIGravityBehavior alloc]initWithItems:self.items];
        [control addChildBehavior:gra];
        [self.animator addBehavior:control];
        
    }
    
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
