//
//  LLSearchView.h
//  仿爱鲜蜂搜索控制器的实现
//
//  Created by JYD on 16/9/2.
//  Copyright © 2016年 周尊贤. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^searchButtonClickBlock)(UIButton *  button);
@interface LLSearchView : UIView

@property (nonatomic,copy)  searchButtonClickBlock  block;
/**
 *  获取整个 view 高的的属性
 */
@property (nonatomic,assign)  CGFloat  searchHeight;
/**
 *  便利构造函数
 *
 *  @param frame       大小
 *  @param titile      分类的标题
 *  @param buttonCount 回调
 *  @param btnBlock    
 *
 *  @return  self
 */
-(instancetype)initWithFrame:(CGRect)frame :(NSString *)titile :(NSArray *)buttonCount :(searchButtonClickBlock) btnBlock ;
@end
