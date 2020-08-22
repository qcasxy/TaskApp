


//
//  TaskTanVC.m
//  taskApp
//
//  Created by per on 2019/11/15.
//  Copyright © 2019 per. All rights reserved.
//

#import "TaskTanVC.h"
#import "TaskCell.h"
#import "MineModel.h"
@interface TaskTanVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView * taskCollection;
@property(nonatomic,strong)NSMutableArray * dataArr;
@end

@implementation TaskTanVC

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor =[UIColor colorWithRed:135/255 green:135/255 blue:135/255 alpha:0.1];
    UIView * backView =[[UIView alloc]init];
    backView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(height(328));
        make.top.mas_equalTo(self.view);
    }];
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(width(15), height(53), width(300), height(45))];
    //设置searchBar的背景颜色
    searchBar.backgroundImage = [self createImageWithColor:BassColor(248, 248, 248)];
    UITextField *searchField=[searchBar valueForKey:@"searchField"];
    searchField.backgroundColor = BassColor(248, 248, 248);//以此来设置搜索框中的颜色
    searchBar.placeholder = @"请输入关键词搜索";
    [self.view addSubview:searchBar];
    UIButton * closeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
   // [closeBtn setBackgroundImage:[UIImage imageNamed:@"cuo"] forState:0]; make.width.height.mas_equalTo(16);
    [closeBtn setTitleColor:BassColor(0, 138, 255) forState:0];
    [closeBtn setTitle:@"确定" forState:0];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(searchBar.mas_right).offset(width(15));
        make.centerY.mas_equalTo(searchBar.mas_centerY);
        make.height.mas_equalTo(16);
         make.width.mas_equalTo(40);
    }];
    [[closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
//        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(chuanZhiTaskTanName:)]) {
            [self.delegate chuanZhiTaskTanName:searchBar.text];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UILabel * fenLable=[[UILabel alloc]init];
    fenLable.textColor = BassColor(0, 0, 0);
    fenLable.text = @"检索分类";
    fenLable.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:fenLable];
    [fenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(width(15));
        make.height.mas_equalTo(height(20));
        make.width.mas_equalTo(width(100));
        make.top.mas_equalTo(searchBar.mas_bottom).offset(height(30));
    }];
    [self.view addSubview:self.taskCollection];
    [self.taskCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view );
        make.top.mas_equalTo(fenLable.mas_bottom).offset(height(15));
        make.height.mas_equalTo(height(170));
    }];
    [self load_labelList];
    // Do any additional setup after loading the view.
}
-(void)load_labelList{
    [HttpTool get:API_POST_labelList dic:@{} success:^(id  _Nonnull responce) {
        if ([responce[@"code"] intValue]==200) {
            self.dataArr =[MineModel mj_objectArrayWithKeyValuesArray:responce[@"data"]];
        }
        [self.taskCollection reloadData];
    } faile:^(NSError * _Nonnull erroe) {
        
    }];
}
-(UICollectionView*)taskCollection{
    if (!_taskCollection) {
        UICollectionViewFlowLayout * flow =[[UICollectionViewFlowLayout alloc]init];
        
        _taskCollection =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-NavHeight) collectionViewLayout:flow];
        _taskCollection.delegate =self;
        _taskCollection.dataSource=self;
        [_taskCollection registerClass:[TaskCell class] forCellWithReuseIdentifier:@"TaskCell"];
        _taskCollection.backgroundColor =UIColor.whiteColor;
    }
    return _taskCollection;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return self.dataArr.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TaskCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"TaskCell" forIndexPath:indexPath];
    MineModel * model =self.dataArr[indexPath.row];
    cell.lab.text = model.name;
        return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        return CGSizeMake(kScreenWidth/4-5, height(50));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

    return 0.0001;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0001;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   MineModel * model =self.dataArr[indexPath.row];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(chuanZhiTaskTanID:)]) {
        [self.delegate chuanZhiTaskTanID:model.mineID];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UIColor 转UIImage
- (UIImage*)createImageWithColor: (UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
