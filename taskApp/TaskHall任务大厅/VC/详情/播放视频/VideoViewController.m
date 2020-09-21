//
//  VideoViewController.m
//  taskApp
//
//  Created by per on 2019/11/14.
//  Copyright © 2019 per. All rights reserved.
//
#import "VideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SJVideoPlayer/SJVideoPlayer.h>
@interface VideoViewController ()<SJVideoPlayerControlLayerDelegate>
@property(nonatomic,strong)AVPlayerItem*playerItem;
@property(nonatomic,strong)SJVideoPlayer*player;//AVPlayer*player;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;
@property(nonatomic,assign)BOOL isYes;
@end

@implementation VideoViewController
-(void)clickBtn{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"观看完视频请点击右上角提交按钮才能获得奖励,退出无法获得奖励！" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
    }]];
//    [alertController addAction:[UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
      [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =UIColor.whiteColor;
    self.isYes = NO;
    [self setNavTitle:@"视频播放"];
    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
    NSURL *playUrl = [NSURL URLWithString:self.dataDic[@"video"]];
    _player = [SJVideoPlayer player];
    
    _player.view.frame = CGRectMake(0, 0, kScreenWidth,kScreenHeight);
    [self.view addSubview:_player.view];
    _player.defaultEdgeControlLayer.hiddenBottomProgressIndicator =NO;
    //    _player.supportedOrientations = SJOrientationMaskPortrait;
    
    _player.fitOnScreen = YES;
    
    [_player setFitOnScreen:NO animated:NO];
    //    _player.defaultEdgeControlLayer.showResidentBackButton = NO;
    //   _player.rotationManager.disabledAutorotation = YES;//禁止自动旋转
    //   _player.rotationManager.autorotationSupportedOrientations = SJOrientationMaskPortrait;
    // 设置资源进行播放
    SJVideoPlayerURLAsset *asset = [[SJVideoPlayerURLAsset alloc] initWithURL:playUrl];
    _player.URLAsset = asset;
    _player.defaultEdgeControlLayer.hiddenBottomProgressIndicator = YES;
    
    UIButton * tiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    tiBtn.backgroundColor = BassColor(17, 151, 255);
    [tiBtn setTitle:@"提 交" forState:0];
    tiBtn.titleLabel.font = VPFont(@"PingFang-SC-Medium", height(17));
    [tiBtn setTitleColor:UIColor.whiteColor forState:0];
    [self.view addSubview:tiBtn];
    [tiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(width(302));
        make.height.mas_equalTo(height(34));
        make.top.mas_equalTo(self.player.view.mas_bottom).offset(height(60));
    }];
    
    tiBtn.layer.masksToBounds = YES;
    tiBtn.layer.cornerRadius = height(17);
    [tiBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    __weak typeof(self) weakSelf=self;
    self.player.playbackObserver.didPlayToEndTimeExeBlock = ^(__kindof SJBaseVideoPlayer * _Nonnull player) {
        weakSelf.isYes=YES;
    };
    UILabel * tilable =[HttpTool createLable:UIColor.redColor font:VPFont(@"PingFang-SC-Medium", 11) textAlignmen:NSTextAlignmentLeft text:@"*观看完视频请点击提交按钮,否则无法获取奖励,请用户按照要求提交按钮*"];
    tilable.numberOfLines=2;
    [self.view addSubview:tilable];
    [tilable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(width(302));
        make.height.mas_equalTo(height(45));
        make.top.mas_equalTo(tiBtn.mas_bottom).offset(height(15));
    }];
}

-(void)clickLoginBtn{
    if (self.isYes==NO) {
        [self showToastInView:self.view message:@"请观看完再点击,谢谢！" duration:0.8];
    }else{
        [HttpTool get:API_POST_taskOver dic:@{@"id":self.dataDic[@"id"]} success:^(id  _Nonnull responce) {
            if ([responce[@"code"] intValue]==200) {
                [self showToastInView:self.view message:@"任务完成" duration:0.8];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showToastInView:self.view message:responce[@"message"] duration:0.8];
                self.isYes=YES;
            }
        } faile:^(NSError * _Nonnull erroe) {
            
        }];
    }
}
- (void)dealloc {
    // 在控制器释放的时候，一定要设置placeholder为nil，要不会有placeholder缓存
    SJVideoPlayer.update(^(SJVideoPlayerSettings * _Nonnull common) {
        common.placeholder = nil;
    });
    
}
@end
//#import "VideoViewController.h"
//#import <AVFoundation/AVFoundation.h>
//#import <SJVideoPlayer/SJVideoPlayer.h>
//@interface VideoViewController ()<SJVideoPlayerControlLayerDelegate>
//@property(nonatomic,strong)AVPlayerItem*playerItem;
//@property(nonatomic,strong)SJVideoPlayer*player;//AVPlayer*player;
//@property(nonatomic,strong)AVPlayerLayer *playerLayer;
//@property(nonatomic,assign)BOOL isYes;
//@end
//
//@implementation VideoViewController
//-(void)clickBtn{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.backgroundColor =UIColor.whiteColor;
//    self.isYes = NO;
//    [self setNavTitle:@"视频播放"];
//    [self setLeftButton:@"" imgStr:@"2fanhui" selector:@selector(clickBtn)];
//    NSURL *playUrl = [NSURL URLWithString:self.dataDic[@"video"]];
//    _player = [SJVideoPlayer player];
//
//    _player.view.frame = CGRectMake(0, 0, kScreenWidth,height(350));
//    [self.view addSubview:_player.view];
//    _player.defaultEdgeControlLayer.showResidentBackButton = NO;
//   _player.rotationManager.disabledAutorotation = YES;
//   _player.rotationManager.autorotationSupportedOrientations = SJOrientationMaskPortrait;
//    // 设置资源进行播放
//    SJVideoPlayerURLAsset *asset = [[SJVideoPlayerURLAsset alloc] initWithURL:playUrl];
//    _player.URLAsset = asset;
//    _player.defaultEdgeControlLayer.hiddenBottomProgressIndicator = YES;
//
//    UIButton * tiBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    tiBtn.backgroundColor = BassColor(17, 151, 255);
//    [tiBtn setTitle:@"提 交" forState:0];
//    tiBtn.titleLabel.font = VPFont(@"PingFang-SC-Medium", height(17));
//    [tiBtn setTitleColor:UIColor.whiteColor forState:0];
//    [self.view addSubview:tiBtn];
//    [tiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.width.mas_equalTo(width(302));
//        make.height.mas_equalTo(height(34));
//        make.top.mas_equalTo(self.player.view.mas_bottom).offset(height(60));
//    }];
//
//    tiBtn.layer.masksToBounds = YES;
//    tiBtn.layer.cornerRadius = height(17);
//    [tiBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
//    __weak typeof(self) weakSelf=self;
//    self.player.playbackObserver.didPlayToEndTimeExeBlock = ^(__kindof SJBaseVideoPlayer * _Nonnull player) {
//        weakSelf.isYes=YES;
//    };
//    UILabel * tilable =[HttpTool createLable:UIColor.redColor font:VPFont(@"PingFang-SC-Medium", 11) textAlignmen:NSTextAlignmentLeft text:@"*观看完视频请点击提交按钮,否则无法获取奖励,请用户按照要求提交按钮*"];
//    tilable.numberOfLines=2;
//    [self.view addSubview:tilable];
//    [tilable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view.mas_centerX);
//        make.width.mas_equalTo(width(302));
//        make.height.mas_equalTo(height(45));
//        make.top.mas_equalTo(tiBtn.mas_bottom).offset(height(15));
//    }];
////    UIView * backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, height(300))];
////    backView.backgroundColor = UIColor.redColor;
////    [self.view addSubview:backView];
////    // 初始化播放器item
////    self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://service.ruizhixue.cn/ht/faburenwu/upload/video/20191025/121a127c96fc1e245355d57bd2486433.mp4"]];
////    self.player = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
////    // 初始化播放器的Layer
////    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
////    // layer的frame
////    self.playerLayer.frame = backView.bounds;
////    // layer的填充屬性 和UIImageView的填充屬性類似
////    // AVLayerVideoGravityResizeAspect 等比例拉伸，會留白
////    // AVLayerVideoGravityResizeAspectFill // 等比例拉伸，會裁剪
////    // AVLayerVideoGravityResize // 保持原有大小拉伸
////    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
////    // 把Layer加到底部View上
//////    [backView.layer insertSublayer:self.playerLayer atIndex:0];
//////
//////    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:nil usingBlock:^(CMTime time) {
//////
//////        AVPlayerItem *item = WeakSelf.playerItem;
//////        NSInteger currentTime = item.currentTime.value/item.currentTime.timescale;
//////        NSLog(@"当前播放时间:%ld",currentTime);
//////    }];
////
////    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//}
//
//-(void)clickLoginBtn{
//    if (self.isYes==NO) {
//        [self showToastInView:self.view message:@"请观看完再点击,谢谢！" duration:0.8];
//    }else{
//        [HttpTool get:API_POST_taskOver dic:@{@"id":self.dataDic[@"id"]} success:^(id  _Nonnull responce) {
//            if ([responce[@"code"] intValue]==200) {
//                [self showToastInView:self.view message:@"任务完成" duration:0.8];
//                [self.navigationController popViewControllerAnimated:YES];
//            }else{
//              [self showToastInView:self.view message:responce[@"message"] duration:0.8];
//                self.isYes=YES;
//            }
//        } faile:^(NSError * _Nonnull erroe) {
//        [self showToastInView:self.view message: @"连接超时，请检查您的网络！" duration:0.8];
//        }];
//    }
//}
////-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
////    if ([object isKindOfClass:[AVPlayerItem class]]) {
////        if ([keyPath isEqualToString:@"status"]) {
////            switch (_playerItem.status) {
////                case AVPlayerItemStatusReadyToPlay:
////                    //推荐将视频播放放在这里
////                     [self.player play];
////                    break;
////                case AVPlayerItemStatusUnknown:
////                    NSLog(@"AVPlayerItemStatusUnknown");
////                    break;
////
////                case AVPlayerItemStatusFailed:
////                    NSLog(@"AVPlayerItemStatusFailed");
////                    break;
////
////                default:
////                    break;
////            }
////
////        }
////    }
////}
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
