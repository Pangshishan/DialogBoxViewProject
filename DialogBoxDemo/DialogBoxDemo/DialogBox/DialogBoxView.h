//
//  DialogBoxView.h
//  Test
//
//  Created by pangshishan on 2018/3/11.
//  Copyright © 2018年 pangshishan. All rights reserved.
//

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
