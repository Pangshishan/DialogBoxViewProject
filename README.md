# DialogBoxViewProject
对话框绘制, 传String或者富文本, 给定最大宽度之后, 宽高自适应; 用法及效果, 看详情

#### 效果图如下:
![image.png](https://upload-images.jianshu.io/upload_images/5379614-798b250714490774.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 用法如下:
```Objective-C
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
```

### .h 文件提供外部使用接口如下

```Objective-C
#import <UIKit/UIKit.h>

@class DialogBoxConfig;
@interface DialogBoxView : UIView

@property (nonatomic, strong) DialogBoxConfig *config;
- (instancetype)initWithConfig:(DialogBoxConfig *)config;

@property (nonatomic, assign, readonly) CGSize size;

- (void)refreshStr:(NSString *)str;
- (void)refreshWithAttrStr:(NSAttributedString *)attrStr;
- (void)refreshWithConfig:(DialogBoxConfig *)config;
- (void)refreshUI;

@end

@interface DialogBoxConfig: NSObject

+ (instancetype)defaultConfig;

- (void)calculateProperty;

@property (nonatomic, strong) NSAttributedString *attrString;

@property (nonatomic, assign) CGFloat margin_left;
@property (nonatomic, assign) CGFloat margin_right;
@property (nonatomic, assign) CGFloat margin_top;
@property (nonatomic, assign) CGFloat margin_bottom;
/// 左下角三角宽
@property (nonatomic, assign) CGFloat triangle_wid;
/// 左下角三角高
@property (nonatomic, assign) CGFloat triangle_hei;
@property (nonatomic, assign) CGFloat radius;
/// 控件最大宽度
@property (nonatomic, assign) CGFloat maxWidth;
/// 是否是实线, 默认NO
@property (nonatomic, assign) BOOL isSolid;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *bgColor;

@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) CGRect labelFrame;

@end
```

### 详细代码, 请下载demo, 辛辛苦苦写的, 点个star呗 ^_^

