//
//  ViewController.m
//  仿爱鲜蜂搜索控制器的实现
//
//  Created by JYD on 16/9/2.
//  Copyright © 2016年 周尊贤. All rights reserved.
//
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define BA_COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#import "ViewController.h"

//#import "LLSearchView.h"
//
#import "LLSeachScrollView.h"
//
@interface ViewController ()<UIScrollViewDelegate>
///**容器视图 */
//@property (nonatomic,strong)  UIScrollView * contentScrollView;
//
//@property (nonatomic,strong)  LLSearchView * hotSeachView;
///**历史搜索 */
//@property (nonatomic,strong)  LLSearchView * historySeachView;
///**删除历史 */
//@property (nonatomic,strong)  UIButton * delectHistoryBtn;

@property (nonatomic,strong)  LLSeachScrollView * searchView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.title = @"懒懒的搜索控制器";
//    
//    self.automaticallyAdjustsScrollViewInsets = false;
//    [self setupUI];
//    
//    NSString * path =[[NSBundle mainBundle]pathForResource:@"SearchProduct" ofType:nil];
//    
//        NSData * date =  [NSData dataWithContentsOfFile:path];
//    
//        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingAllowFragments error:nil];
//    
//        NSArray * array = [[dict objectForKey:@"data"] objectForKey:@"hotquery"];
//    
//    LLSeachScrollView * searView = [[LLSeachScrollView alloc]initWithFrame:self.view.bounds :array ];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self.view addSubview:self.searchView];
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.searchView loadHistorySearchButtonData];
   
    NSMutableArray * historySearch = [[NSUserDefaults standardUserDefaults]objectForKey:@"historySearchArray"];
    
    if (!(historySearch.count >0)) {
      
        [self.searchView delectHistory];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(LLSeachScrollView *)searchView {
    
    if (_searchView == nil) {
        NSString * path =[[NSBundle mainBundle]pathForResource:@"SearchProduct" ofType:nil];
        
        NSData * date =  [NSData dataWithContentsOfFile:path];
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingAllowFragments error:nil];
        
        NSArray * array = [[dict objectForKey:@"data"] objectForKey:@"hotquery"];
        _searchView = [[LLSeachScrollView alloc]initWithFrame:self.view.bounds :array :^(UIButton *button) {
            
            if (button.tag == 100) { //热门
                UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"热门搜索" message: button.titleLabel.text delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil, nil];
                [alter show];
                
            } else { //历史
                UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"历史搜索" message: button.titleLabel.text delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil, nil];
                [alter show];
            
            }
            
        }];
    }
    return _searchView;

}

/*
  /// MARK: ---- 添加子视图
  -(void)setupUI {

      [self.view addSubview:self.contentScrollView];
      
      [self loadHotSearchButtonData];
      
      [self.contentScrollView addSubview:self.delectHistoryBtn];
      
      


}
-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CGFloat height =  self.hotSeachView.searchHeight;
    
    self.hotSeachView.frame = CGRectMake(10, 70, SCREEN_WIDTH -10, height);
    
    self.historySeachView.frame =CGRectMake(10, CGRectGetMaxY(self.hotSeachView.frame) + 20, SCREEN_WIDTH -20, self.historySeachView.searchHeight);
    
     self.delectHistoryBtn.frame = CGRectMake(10, CGRectGetMaxY(self.historySeachView.frame) + 15, SCREEN_WIDTH - 20, 35);
;

}
  /// MARK: ---- 热门搜索
-(void)loadHotSearchButtonData {
    NSString * path =[[NSBundle mainBundle]pathForResource:@"SearchProduct" ofType:nil];
    
    NSData * date =  [NSData dataWithContentsOfFile:path];
    
    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingAllowFragments error:nil];
    
    NSArray * array = [[dict objectForKey:@"data"] objectForKey:@"hotquery"];
    
    
    if (array.count >0) {
        self.hotSeachView = [[LLSearchView alloc]initWithFrame:CGRectMake(10, 70, SCREEN_WIDTH - 10, 100) :@"热门搜索" : array :^(UIButton *button) {
            NSLog(@"%@",button.titleLabel.text);
            
            [self writeHistorySearchToUserDefault:button.titleLabel.text];
            
        }];
        
        [self.contentScrollView addSubview:self.hotSeachView];
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
    
    if (self.historySeachView !=nil) {
        [self.historySeachView removeFromSuperview];
        self.historySeachView = nil;
    }
    
    NSArray * array = [[NSUserDefaults standardUserDefaults] objectForKey:@"historySearchArray"];
    
    if (array.count >0) {
        
        self.historySeachView = [[LLSearchView alloc]initWithFrame:CGRectMake(10, 350, SCREEN_WIDTH -20, 100) :@"历史记录" :array :^(UIButton *button) {
            
        }];
        
        self.delectHistoryBtn.hidden = false;
        [self.contentScrollView addSubview:self.historySeachView];
        
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

  /// MARK: ---- 懒加载

-(UIScrollView *)contentScrollView {
    
    if (_contentScrollView == nil) {
        _contentScrollView = [[UIScrollView alloc]init];
        _contentScrollView.alwaysBounceVertical = true;
        _contentScrollView.delegate = self;
        _contentScrollView.frame = self.view.bounds;
    }
    
    return _contentScrollView;

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
*/
@end
