//
//  ViewController.m
//  DialogBoxDemo
//
//  Created by pangshishan on 2018/3/11.
//  Copyright © 2018年 pangshishan. All rights reserved.
//

#import "ViewController.h"
#import "DialogBoxView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1. 正常创建, 也可以改变UI, frame只需要给定 x y, 宽高不需要指定
    DialogBoxView *dialogView = [[DialogBoxView alloc] initWithFrame:CGRectMake(30, 30, 0, 0)];
    [self.view addSubview:dialogView];
    [dialogView refreshStr:@"ajsdfja;lksdjf;alkjsd;多费劲啊两居室空间kljfakjsfja"]; // 刷新之后, 控件宽高就会更新的
    NSLog(@"wid = %lf, hei = %lf", dialogView.size.width, dialogView.size.height);
    
    /* 可以改变UI, config里的属性有默认的UI, 声明的属性都可以修改的
    dialogView.config.bgColor = [UIColor whiteColor];
    [dialogView refreshUI];
     */
    
    // 2. 第二种初始化方法
    // config 有默认的UI, 可以根据.h里的属性修改, 有详细的注释的
    DialogBoxConfig *config = [DialogBoxConfig defaultConfig];
    config.lineColor = [UIColor redColor];
    config.isSolid = YES; // 默认是虚线
    config.maxWidth = 150;
    config.margin_top = 5;
    config.margin_bottom = 25;
    config.triangle_hei = 20;
    DialogBoxView *dialogView_2 = [[DialogBoxView alloc] initWithConfig:config];
    dialogView_2.frame = CGRectMake(30, 150, 0, 0);
    [self.view addSubview:dialogView_2];
    
    NSString *str = @"哈哈哈哈嗯哈哈哈哈嗯哈哈哈哈嗯哈哈哈哈嗯哈哈哈哈嗯哈哈哈哈嗯哈哈哈哈嗯哈哈";
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize:18]}];
    [dialogView_2 refreshWithAttrStr:attr];
    NSLog(@"dialogBox_2: wid = %lf, hei = %lf", dialogView.size.width, dialogView.size.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
