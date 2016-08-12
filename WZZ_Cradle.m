//
//  WZZ_Cradle.m
//  WZZ_DynamicDemo
//
//  Created by 王召洲 on 16/8/11.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZ_Cradle.h"
#import "WZZ_CradleView.h"
@interface WZZ_Cradle ()

@property (strong,nonatomic) NSArray * items;
@end

@implementation WZZ_Cradle


-(void)loadView  {
    self.view = [[WZZ_CradleView alloc]initWithFrame:[UIScreen mainScreen].bounds];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
