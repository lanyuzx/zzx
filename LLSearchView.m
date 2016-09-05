//
//  LLSearchView.m
//  仿爱鲜蜂搜索控制器的实现
//
//  Created by JYD on 16/9/2.
//  Copyright © 2016年 周尊贤. All rights reserved.
//
#define BA_COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//#define lastX 0
//#define lastY 35


#import "LLSearchView.h"
@interface LLSearchView()
/**搜索的标题 */
@property (nonatomic,strong)  UILabel * searchTitleLable;



@property (nonatomic,assign)  CGFloat  lastX;


@end

@implementation LLSearchView

-(instancetype)initWithFrame:(CGRect)frame :(NSString *)titile :(NSArray *)buttonCount :(searchButtonClickBlock) btnBlock {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.searchTitleLable];
        self.block = btnBlock;
        _searchTitleLable.text = titile;
        [self setupUI:buttonCount];
        
    }
    return self;
}

-(void)setupUI:(NSArray *)btnArr {
    
    CGFloat btnW = 0;
    CGFloat btnH = 30;
    CGFloat addW = 30;
    CGFloat marginX = 10;
    CGFloat marginY = 10;
    
    CGFloat lastY = 35;
    
    for (int i =0; i<btnArr.count; i++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btnArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn.titleLabel sizeToFit];
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.masksToBounds = true;
        btn.layer.cornerRadius = 15;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = BA_COLOR(200, 200, 200, 1.0).CGColor;
        btnW = btn.titleLabel.frame.size.width + addW;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (self.frame.size.width - self.lastX > btnW) {
            btn.frame = CGRectMake(self.lastX, lastY, btnW, btnH);
        }else {
            btn.frame = CGRectMake(0, lastY + marginY + btnH, btnW, btnH);
        }
        self.lastX = CGRectGetMaxX(btn.frame) + marginX;
        lastY = btn.frame.origin.y;
        self.searchHeight = CGRectGetMaxY(btn.frame);
        
        [self addSubview:btn];
        
    }

}

-(void)buttonClick:(UIButton *)btn {
    
    self.block(btn);

}


-(UILabel *)searchTitleLable {
    
    if (_searchTitleLable == nil) {
        _searchTitleLable = [[UILabel alloc]init];
        _searchTitleLable.frame = CGRectMake(0, 0, self.frame.size.width - 30, 35);
        _searchTitleLable.font = [UIFont systemFontOfSize:15];
        _searchTitleLable.textColor = BA_COLOR(140, 140, 140, 1.0);
        
    }
    
    return _searchTitleLable;

}

@end
