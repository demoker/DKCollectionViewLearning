//
//  MyFlowLaout.m
//  CollectionViewLearning
//
//  Created by demoker on 16/3/24.
//  Copyright © 2016年 demoker. All rights reserved.
//

#import "MyFlowLaout.h"

@implementation MyModel

@end

@interface MyFlowLaout (){
    CGFloat height;
}
@property (retain, nonatomic) NSMutableDictionary * allAttributeInfo;
@property (retain, nonatomic) NSMutableArray * allAttributes;
@end

@implementation MyFlowLaout
- (void)prepareLayout{
    [super prepareLayout];
    [self caculateForInsert];
}

- (void)caculateForInsert{
    height = 0;
    CGFloat cellHeight = 0.0;
    CGFloat cellWidth = (MB_APP_SIZE.width - (1 + self.columns)*10)/self.columns;
    CGFloat spaceX = 10;
    CGFloat spaceY = 10;
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    
    
    [self.collectionView numberOfSections];
    
    NSInteger cellNumbers = [self.collectionView numberOfItemsInSection:0];
    
    UICollectionViewLayoutAttributes * headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    headerAttributes.frame = CGRectMake(0, 0, MB_APP_SIZE.width, 44);
    [self.allAttributes addObject:headerAttributes];
    
    
    NSMutableArray * columsOriginYArray = [NSMutableArray array];
    for(int i = 0;i<self.columns;i++){
        [columsOriginYArray addObject:[NSNumber numberWithFloat:54]];
    }
    
    //    NSMutableArray * columsLastHeightArray = [NSMutableArray array];
    //    for(int i = 0;i<self.columns;i++){
    //        [columsLastHeightArray addObject:[NSNumber numberWithFloat:0]];
    //    }
    
    NSArray * heights = [self.flowDelegate caculateCellItemHeight];
    
    for(int i = 0;i<cellNumbers;i++){
        cellHeight  = [heights[i] floatValue];
        height += cellHeight;
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes * cellLayoutAttrebutes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];;
        
//        CGFloat y = [[columsOriginYArray valueForKeyPath:@"@min.floatValue"] floatValue];
        NSNumber * number = [columsOriginYArray valueForKeyPath:@"@min.floatValue"];
        
        int index = 0;
        for(NSNumber * num in columsOriginYArray){
            if([number isEqualToNumber:num]){
                break;
            }
            index++;
        }
        
        //设置X 方向上的位置
        if(index%self.columns == 0){
            itemX = spaceX;
        }else{
            itemX = index * (cellWidth + spaceX)+10;
        }
        
        //设置Y 方向的位置
        if(i<self.columns){
            itemY = [columsOriginYArray[index] floatValue];
            cellLayoutAttrebutes.frame = CGRectMake(itemX, itemY, cellWidth, cellHeight);
            itemY += cellHeight;
            //            [columsOriginYArray replaceObjectAtIndex:i%self.columns withObject:[NSNumber numberWithFloat:itemY]];
            columsOriginYArray[index] = [NSNumber numberWithFloat:itemY];
        }else{
            
            itemY = [columsOriginYArray[index] floatValue];
            itemY += spaceY;
            cellLayoutAttrebutes.frame = CGRectMake(itemX, itemY, cellWidth, cellHeight);
            
            //            if(i < cellNumbers - self.columns){
            itemY += cellHeight;
            //            }else{
            //                itemY += 10;
            //            }
            //记录存起来 某一列的y
            columsOriginYArray[index] = [NSNumber numberWithFloat:itemY];
            //            [columsOriginYArray replaceObjectAtIndex:i%self.columns withObject:[NSNumber numberWithFloat:itemY]];
            //某列 上一个的height
            //            columsLastHeightArray[i%self.columns] = [NSNumber numberWithFloat:cellHeight];
        }
        
        [self.allAttributeInfo setObject:cellLayoutAttrebutes forKey:indexpath];
        [self.allAttributes addObject:cellLayoutAttrebutes];
    }
    
    //获取几列中最大的一列
    CGFloat y = [[columsOriginYArray valueForKeyPath:@"@max.floatValue"] floatValue];
    
    
    CGFloat footerHeight = 44;
    UICollectionViewLayoutAttributes * footerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    footerAttributes.frame = CGRectMake(0, y, MB_APP_SIZE.width, footerHeight);
    [self.allAttributes addObject:footerAttributes];
    
    
    if(y > MB_APP_SIZE.height){
        height = y;
    }else{
        height = MB_APP_SIZE.height;
    }
    
    height += footerHeight;

}

//按列计算
- (void)caculateForColums{
    height = 0;
    CGFloat cellHeight = 0.0;
    CGFloat cellWidth = (MB_APP_SIZE.width - (1 + self.columns)*10)/self.columns;
    CGFloat spaceX = 10;
    CGFloat spaceY = 10;
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    
    
    [self.collectionView numberOfSections];
    
    NSInteger cellNumbers = [self.collectionView numberOfItemsInSection:0];
    
    UICollectionViewLayoutAttributes * headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    headerAttributes.frame = CGRectMake(0, 0, MB_APP_SIZE.width, 44);
    [self.allAttributes addObject:headerAttributes];
    
    
    NSMutableArray * columsOriginYArray = [NSMutableArray array];
    for(int i = 0;i<self.columns;i++){
        [columsOriginYArray addObject:[NSNumber numberWithFloat:54]];
    }
    
    //    NSMutableArray * columsLastHeightArray = [NSMutableArray array];
    //    for(int i = 0;i<self.columns;i++){
    //        [columsLastHeightArray addObject:[NSNumber numberWithFloat:0]];
    //    }
    
    NSArray * heights = [self.flowDelegate caculateCellItemHeight];
    
    for(int i = 0;i<cellNumbers;i++){
        cellHeight  = [heights[i] floatValue];
        height += cellHeight;
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes * cellLayoutAttrebutes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];;
        
        //设置X 方向上的位置
        if(i%self.columns == 0){
            itemX = spaceX;
        }else{
            itemX = (i%self.columns) * (cellWidth + spaceX)+10;
        }
        
        //设置Y 方向的位置
        if(i<self.columns){
            itemY = [columsOriginYArray[i%self.columns] floatValue];
            cellLayoutAttrebutes.frame = CGRectMake(itemX, itemY, cellWidth, cellHeight);
            itemY += cellHeight;
            //            [columsOriginYArray replaceObjectAtIndex:i%self.columns withObject:[NSNumber numberWithFloat:itemY]];
            columsOriginYArray[i%self.columns] = [NSNumber numberWithFloat:itemY];
        }else{
            
            itemY = [columsOriginYArray[i%self.columns] floatValue];
            itemY += spaceY;
            cellLayoutAttrebutes.frame = CGRectMake(itemX, itemY, cellWidth, cellHeight);
            
            //            if(i < cellNumbers - self.columns){
            itemY += cellHeight;
            //            }else{
            //                itemY += 10;
            //            }
            //记录存起来 某一列的y
            columsOriginYArray[i%self.columns] = [NSNumber numberWithFloat:itemY];
            //            [columsOriginYArray replaceObjectAtIndex:i%self.columns withObject:[NSNumber numberWithFloat:itemY]];
            //某列 上一个的height
            //            columsLastHeightArray[i%self.columns] = [NSNumber numberWithFloat:cellHeight];
        }
        
        [self.allAttributeInfo setObject:cellLayoutAttrebutes forKey:indexpath];
        [self.allAttributes addObject:cellLayoutAttrebutes];
    }
    
    //获取几列中最大的一列
    CGFloat y = [[columsOriginYArray valueForKeyPath:@"@max.floatValue"] floatValue];
    
    
    CGFloat footerHeight = 44;
    UICollectionViewLayoutAttributes * footerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    footerAttributes.frame = CGRectMake(0, y, MB_APP_SIZE.width, footerHeight);
    [self.allAttributes addObject:footerAttributes];
    
    
    if(y > MB_APP_SIZE.height){
        height = y;
    }else{
        height = MB_APP_SIZE.height;
    }
    
    height += footerHeight;

}

- (NSMutableArray *)allAttributes{
    if(!_allAttributes){
        _allAttributes = [[NSMutableArray alloc]init];
    }
    return _allAttributes;
}

- (NSMutableDictionary *)allAttributeInfo{
    if(!_allAttributeInfo){
        _allAttributeInfo = [[NSMutableDictionary alloc]init];
    }
    return _allAttributeInfo;
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(MB_APP_SIZE.width, height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:0];
    for (UICollectionViewLayoutAttributes *attri in _allAttributes) {
        
        if (CGRectIntersectsRect(rect, attri.frame)) {
            [attributes addObject:attri];
        }
    }
    return  attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _allAttributeInfo[indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return NO;
}

@end
