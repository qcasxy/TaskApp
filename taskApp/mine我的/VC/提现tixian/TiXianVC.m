//
//  TiXianVC.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "TiXianVC.h"

@interface TiXianVC ()

@end

@implementation TiXianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
       [self setNavTitle:@"提现"];
       [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    // Do any additional setup after loading the view.
}
-(void)clickBtn{
    [self.navigationController popViewControllerAnimated:YES];
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
