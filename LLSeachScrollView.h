//
//  LLSeachScrollView.h
//  仿爱鲜蜂搜索控制器的实现
//
//  Created by JYD on 16/9/5.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^searchScrollBlock)(UIButton *  button);

@interface LLSeachScrollView : UIScrollView
/**
 *  便利构造函数
 *
 *  @param frame       大小 一般为控制器 view 的大小
 *  @param hotSeachArr 热门搜索的数组 一般从服务器接口获取 这里是从本地加载的
 *  @param scrollBlock 回调给控制器 根据 tag 值去区分是热门和历史  热门 tag 值为100 历史为200
 *  @return self
 */
-(instancetype)initWithFrame:(CGRect)frame :(NSArray *)hotSeachArr :(searchScrollBlock)scrollBlock ;
/**
 *  调用历史搜索  一般在控制器的viewWillAppear中调用 每次进来都调用本地是否有数据
 */
-(void)loadHistorySearchButtonData;
/**
 *  删除按钮
 */
-(void)delectHistory;
/**
 *  回调给控制器 根据 tag 值去区分是热门和历史  热门 tag 值为100 历史为200
 */
@property (nonatomic,copy)  searchScrollBlock  block;
@end
