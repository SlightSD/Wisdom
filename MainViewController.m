//
//  MainViewController.m
//  Wisdom
//
//  Created by 杨锦辉 on 15/12/6.
//  Copyright © 2015年 杨锦辉. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置点击后变成绿色
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:106/255.0 green:186/255.0 blue:45/255.0 alpha:1.0]];
   
    
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
