//
//  LLSeachScrollView.m
//  仿爱鲜蜂搜索控制器的实现
//
//  Created by JYD on 16/9/5.
//  Copyright © 2016年 周尊贤. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define BA_COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#import "LLSeachScrollView.h"
#import "LLSearchView.h"

@interface LLSeachScrollView()
@property (nonatomic,strong)  LLSearchView * hotSeachView;
/**历史搜索 */
@property (nonatomic,strong)  LLSearchView * historySeachView;
/**删除历史 */
@property (nonatomic,strong)  UIButton * delectHistoryBtn;
@end

@implementation LLSeachScrollView


-(instancetype)initWithFrame:(CGRect)frame :(NSArray *)hotSeachArr :(searchScrollBlock)scrollBlock {
    if (self = [super initWithFrame:frame]) {
        self.block = scrollBlock;

        self.alwaysBounceVertical = true;
        [self loadHotSearchButtonData:hotSeachArr];
        
        [self addSubview:self.delectHistoryBtn];
    }
    return self;
}

  /// MARK: ---- 重新布局
-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height =  self.hotSeachView.searchHeight;
    
    self.hotSeachView.frame = CGRectMake(10, 70, SCREEN_WIDTH -10, height);
    
    self.historySeachView.frame =CGRectMake(10, CGRectGetMaxY(self.hotSeachView.frame) + 20, SCREEN_WIDTH -20, self.historySeachView.searchHeight);
    
    self.delectHistoryBtn.frame = CGRectMake(10, CGRectGetMaxY(self.historySeachView.frame) + 15, SCREEN_WIDTH - 20, 35);
    ;



}
/// MARK: ---- 热门搜索
-(void)loadHotSearchButtonData :(NSArray *) arr {

    if (arr.count >0) {
        self.hotSeachView = [[LLSearchView alloc]initWithFrame:CGRectMake(10, 70, SCREEN_WIDTH - 10, 100) :@"热门搜索" : arr :^(UIButton *button) {
            NSLog(@"%@",button.titleLabel.text);
            button.tag = 100;
            [self writeHistorySearchToUserDefault:button.titleLabel.text];
            
            self.block(button);
            
        }];
        
        [self addSubview:self.hotSeachView];
    }
    
    
}


/// MARK: ---- 把搜索过的产品存储到本地
-(void)writeHistorySearchToUserDefault:(NSString *)title {
    
    
    NSMutableArray * historySearch = [[NSUserDefaults standardUserDefaults]objectForKey:@"historySearchArray"];
    NSMutableArray * tempArr = [NSMutableArray arrayWithArray:historySearch];
    for (NSString * text in tempArr) {
        if ([title isEqualToString:text]) {
            return;
        }
    }
    [tempArr addObject:title];
    
    [[NSUserDefaults standardUserDefaults]setObject:tempArr forKey:@"historySearchArray"];
    
    [self loadHistorySearchButtonData];
    
}

/// MARK: ---- 历史搜索
-(void)loadHistorySearchButtonData {
    //防止视图重复添加和创建
    if (self.historySeachView !=nil) {
        [self.historySeachView removeFromSuperview];
        self.historySeachView = nil;
    }
    
    NSArray * array = [[NSUserDefaults standardUserDefaults] objectForKey:@"historySearchArray"];
    
    if (array.count >0) {
        
        self.historySeachView = [[LLSearchView alloc]initWithFrame:CGRectMake(10, 350, SCREEN_WIDTH -20, 100) :@"历史记录" :array :^(UIButton *button) {
            
            button.tag = 200;
            
            self.block(button);
            
        }];
        
        self.delectHistoryBtn.hidden = false;
        [self addSubview:self.historySeachView];
        
        [self updateCleanHistoryButton];
    }
    
}
/// MARK: ---- 删除历史按钮
-(void)delectHistory {
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"historySearchArray"];
    [self loadHistorySearchButtonData];
    self.delectHistoryBtn.hidden = true;
    
    
    
}

-(void)updateCleanHistoryButton {
    
    if (self.historySeachView != nil) {
        
        self.delectHistoryBtn.frame = CGRectMake(10, CGRectGetMaxY(self.historySeachView.frame) + 15, SCREEN_WIDTH - 20, 35);
    }
    
}

-(UIButton *)delectHistoryBtn {
    
    if (_delectHistoryBtn == nil) {
        _delectHistoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delectHistoryBtn setTitle:@"清  空  历  史" forState:UIControlStateNormal];
        _delectHistoryBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _delectHistoryBtn.backgroundColor = BA_COLOR(240, 240, 240, 1.0);
        [_delectHistoryBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _delectHistoryBtn.layer .masksToBounds = true;
        _delectHistoryBtn.layer.cornerRadius = 7;
        [_delectHistoryBtn addTarget:self action:@selector(delectHistory) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _delectHistoryBtn;
    
}


@end
