//
//  DialogBoxView.m
//  Test
//
//  Created by pangshishan on 2018/3/11.
//  Copyright © 2018年 pangshishan. All rights reserved.
//

#import "DialogBoxView.h"

@interface DialogBoxView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation DialogBoxView

- (instancetype)initWithConfig:(DialogBoxConfig *)config
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.config = config ? config : [DialogBoxConfig new];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.config = [DialogBoxConfig new];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.config = [DialogBoxConfig new];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = self.config.labelFrame;
}
- (void)refreshStr:(NSString *)str
{
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: self.config.lineColor}];
    [self refreshWithAttrStr:attr];
}
- (void)refreshWithAttrStr:(NSAttributedString *)attrStr
{
    self.config.attrString = attrStr;
    [self refreshWithConfig:self.config];
}
- (void)refreshWithConfig:(DialogBoxConfig *)config
{
    self.config = config;
}
- (void)refreshUI
{
    [self setConfig:self.config];
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentContext, self.config.lineColor.CGColor);
    CGContextSetFillColorWithColor(currentContext, self.config.bgColor.CGColor);
    CGContextSetLineWidth(currentContext, 1);
    CGContextMoveToPoint(currentContext, 0, self.config.radius);
    CGContextAddArc(currentContext, self.config.radius, self.config.radius, self.config.radius, -M_PI, -M_PI_2, NO);
    CGContextAddLineToPoint(currentContext, self.config.width - self.config.radius, 0);
    CGContextAddArc(currentContext, self.config.width - self.config.radius, self.config.radius, self.config.radius, -M_PI_2, 0, NO);
    CGContextAddLineToPoint(currentContext, self.config.width, self.config.height - self.config.triangle_hei - self.config.radius);
    CGContextAddArc(currentContext, self.config.width - self.config.radius, self.config.height - self.config.triangle_hei - self.config.radius, self.config.radius, 0, M_PI_2, NO);
    
    CGPoint point_0 = CGPointMake(self.config.width - self.config.radius, self.config.height - self.config.triangle_hei);
    CGPoint point_1 = CGPointMake(self.config.triangle_wid, self.config.height - self.config.triangle_hei);
    CGPoint point_2 = CGPointMake(0, self.config.height);
    CGPoint point_3 = CGPointMake(0, self.config.radius);
    CGPoint point[4] = {point_0 , point_1, point_2, point_3};
    CGContextAddLines(currentContext, point, 4);
    if (!self.config.isSolid) {
        //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
        CGFloat arr[] = {3 ,3};
        //下面最后一个参数“2”代表排列的个数。
        CGContextSetLineDash(currentContext, 0, arr, 1);
    }
    CGContextDrawPath(currentContext, kCGPathFillStroke);//绘制路径path
}
- (void)setConfig:(DialogBoxConfig *)config
{
    _config = config;
    if (config) {
        [_config calculateProperty];
        self.label.attributedText = _config.attrString;
        _size = CGSizeMake(_config.width, _config.height);
        CGRect frame = self.frame;
        self.frame = frame;
    }
}
- (void)setFrame:(CGRect)frame
{
    if (self.config) {
        [super setFrame:CGRectMake(frame.origin.x, frame.origin.y, self.config.width, self.config.height)];
    } else {
        [super setFrame:frame];
    }
}
- (UILabel *)label
{
    if (_label == nil) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _label = label;
        _label.numberOfLines = 0;
    }
    return _label;
}
@end

@implementation DialogBoxConfig

+ (instancetype)defaultConfig
{
    return [[DialogBoxConfig alloc] init];;
}
- (void)calculateProperty
{
    CGSize labelSize = [self labelSizeWithAttrStr:self.attrString maxWid:self.maxWidth - self.margin_left - self.margin_right];
    _labelFrame = CGRectMake(self.margin_left, self.margin_top, labelSize.width, labelSize.height);
    _width = labelSize.width + self.margin_left + self.margin_right;
    _height = labelSize.height + self.margin_top + self.margin_bottom;
}
- (CGSize)labelSizeWithAttrStr:(NSAttributedString *)attrStr maxWid:(CGFloat)maxWid
{
    CGRect oneLineRect = [attrStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    if (oneLineRect.size.width <= maxWid) {
        return oneLineRect.size;
    } else {
        CGRect linesRect = [attrStr boundingRectWithSize:CGSizeMake(maxWid, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        return linesRect.size;
    }
}

- (CGFloat)margin_top
{
    if (_margin_top == 0) {
        _margin_top = 12.0;
    }
    return _margin_top;
}
- (CGFloat)margin_left
{
    if (_margin_left == 0) {
        _margin_left = 15;
    }
    return _margin_left;
}
- (CGFloat)margin_right
{
    if (_margin_right == 0) {
        _margin_right = 15;
    }
    return _margin_right;
}
- (CGFloat)margin_bottom
{
    if (_margin_bottom == 0) {
        _margin_bottom = 15;
    }
    return _margin_bottom;
}
- (CGFloat)triangle_wid
{
    if (_triangle_wid == 0) {
        _triangle_wid = 10;
    }
    return _triangle_wid;
}
- (CGFloat)triangle_hei
{
    if (_triangle_hei == 0) {
        _triangle_hei = 6;
    }
    return _triangle_hei;
}
- (CGFloat)radius
{
    if (_radius == 0) {
        _radius = 8;
    }
    return _radius;
}
- (CGFloat)maxWidth
{
    if (_maxWidth == 0) {
        _maxWidth = 280;
    }
    return _maxWidth;
}
- (UIColor *)lineColor
{
    if (_lineColor == nil) {
        _lineColor =  [UIColor colorWithRed:204/255.0 green:158/255.0 blue:61/255.0 alpha:1/1.0];
    }
    return _lineColor;
}
- (UIColor *)bgColor
{
    if (_bgColor == nil) {
        _bgColor = [UIColor colorWithRed:237/255.0 green:221/255.0 blue:189/255.0 alpha:0.2957710597826087/1.0];
    }
    return _bgColor;
}
- (NSAttributedString *)attrString
{
    if (_attrString == nil) {
        _attrString = [[NSAttributedString alloc] initWithString:@"    " attributes:@{
                                                                                    NSFontAttributeName: [UIFont systemFontOfSize:16],
                                                                                    NSForegroundColorAttributeName: self.lineColor
                                                                                    }];
    }
    return _attrString;
}

@end






