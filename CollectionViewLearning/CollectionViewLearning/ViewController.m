//
//  ViewController.m
//  CollectionViewLearning
//
//  Created by demoker on 16/3/24.
//  Copyright © 2016年 demoker. All rights reserved.
//

#import "ViewController.h"
#import "MYCollectionViewCell.h"
#import "MyFlowLaout.h"
#import "CollectionHeadView.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MyFlowLaoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *mcollectionView;
@property (retain, nonatomic) NSMutableArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    for(int i = 0;i<50;i++){
        NSString * str = [NSString stringWithFormat:@"第%d个",i];
        [self.dataArray addObject:str];
    }
    
    MyFlowLaout * laout = [[MyFlowLaout alloc]init];
    laout.flowDelegate = self;
    laout.columns = 4;
    self.mcollectionView.collectionViewLayout = laout;
    [self.mcollectionView registerNib:[UINib nibWithNibName:@"MYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MYCollectionViewCell"];
    
//    [self.mcollectionView registerClass:[CollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeadView"];
    [self.mcollectionView registerNib:[UINib nibWithNibName:@"CollectionHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeadView"];
    
    [self.mcollectionView registerNib:[UINib nibWithNibName:@"CollectionHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionHeadView"];
    
    [self.mcollectionView reloadData];
    
    self.mcollectionView.backgroundColor = [UIColor greenColor];
}

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSArray *)caculateCellItemHeight{
    NSMutableArray * heights = [NSMutableArray array];
    for(int i = 0;i<self.dataArray.count;i++){
        NSNumber * number;
        if(i%10==0){
            number = [NSNumber numberWithInt:50+arc4random()%30];
        }else{
            number = [NSNumber numberWithInt:100+arc4random()%30];
        }
        [heights addObject:number];
    }
    return heights;
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MYCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MYCollectionViewCell" forIndexPath:indexPath];
    cell.label.text = self.dataArray[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        CollectionHeadView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeadView" forIndexPath:indexPath];
        header.backgroundColor = [UIColor blueColor];
        header.label.text = @"demoker头部";
        return header;
    }else{
        CollectionHeadView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionHeadView" forIndexPath:indexPath];
        header.backgroundColor = [UIColor blueColor];
        header.label.text = @"demoker尾部";
        return header;
    }
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(MB_APP_SIZE.width/2, 100);
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
