//
//  MyFlowLaout.h
//  CollectionViewLearning
//
//  Created by demoker on 16/3/24.
//  Copyright © 2016年 demoker. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyFlowLaoutDelegate <NSObject>
- (NSArray *)caculateCellItemHeight;

@end

@interface MyModel : NSObject
@property (assign, nonatomic) CGFloat imageW;
@property (assign, nonatomic) CGFloat imageH;
@property (assign, nonatomic) CGFloat labelW;
@property (assign, nonatomic) CGFloat labelH;
@end

@interface MyFlowLaout : UICollectionViewFlowLayout
@property (retain, nonatomic) MyModel * myModel;
@property (assign, nonatomic) id<MyFlowLaoutDelegate>flowDelegate;
@property (assign, nonatomic) NSInteger columns;
@end
