//
//  HeardUrl.h
//  Currency
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef HeardUrl_h
#define HeardUrl_h

#define API_URL @"http://service.tt-xz.cn"//132.232.132.127
//#define API_URL @"http://service.ruizhixue.cn"
#define API_POST(api) [API_URL stringByAppendingString:api]
//  2020-08-26 新增 By qcasxy
#define API_POST_passwordLogin API_POST(@"/ht/faburenwu/index.php/api/accountlogin")//手机号密码登录
#define API_POST_forgetPassword API_POST(@"/ht/faburenwu/index.php/api/forget")//忘记密码
#define API_POST_resetPassword API_POST(@"/ht/faburenwu/index.php/api/setpassword")//设置密码
#define API_POST_codeLogin API_POST(@"/ht/faburenwu/index.php/api/phonelogin")//手机号验证码登录
#define API_POST_sendSMS API_POST(@"/ht/faburenwu/index.php/api/sendsms")//发送验证码
#define API_POST_getDesc API_POST(@"/ht/faburenwu/index.php/api/getdesc")//获取登录页说明文字

#define API_POST_login API_POST(@"/ht/faburenwu/index.php/api/login")//微信是否授权过
#define API_POST_register API_POST(@"/ht/faburenwu/index.php/api/register")//微信授权注册
#define API_POST_userIndex API_POST(@"/ht/faburenwu/index.php/api/userIndex")//用户信息
#define API_POST_Home_index API_POST(@"/ht/faburenwu/index.php/api/index")//首页信息
#define API_POST_myRecommend API_POST(@"/ht/faburenwu/index.php/api/myRecommend")//我的推荐
#define API_POST_notice API_POST(@"/ht/faburenwu/index.php/api/notice")//系统消息
#define API_POST_taskRecord API_POST(@"/ht/faburenwu/index.php/api/taskRecord")//我的领取任务
#define API_POST_walletDetails API_POST(@"/ht/faburenwu/index.php/api/walletDetails")//我的钱包
#define API_POST_myBrokerage API_POST(@"/ht/faburenwu/index.php/api/myBrokerage")//我的佣金
#define API_POST_feedback API_POST(@"/ht/faburenwu/index.php/api/feedback")//问题反馈
#define API_POST_taskIndex API_POST(@"/ht/faburenwu/index.php/api/taskIndex")//任务大厅（附搜索）
#define API_POST_taskInfo API_POST(@"/ht/faburenwu/index.php/api/taskInfo")//任务详情
#define API_POST_taskDetails API_POST(@"/ht/faburenwu/index.php/api/taskDetails")//领取任务详情
#define API_POST_drawTask API_POST(@"/ht/faburenwu/index.php/api/drawTask")//领取任务

#define API_POST_screenshot API_POST(@"/ht/faburenwu/index.php/api/screenshot")//提交任务
#define API_POST_vipList API_POST(@"/ht/faburenwu/index.php/api/vipList")//会员类型
#define API_POST_checkVip API_POST(@"/ht/faburenwu/index.php/api/checkVip")//验证会员信息
#define API_POST_userIndex API_POST(@"/ht/faburenwu/index.php/api/userIndex")//用户信息
#define API_POST_userUpdate API_POST(@"/ht/faburenwu/index.php/api/userUpdate")//编辑用户信息
#define API_POST_superiorMember API_POST(@"/ht/faburenwu/index.php/api/superiorMember")//用户列表
#define API_POST_authentic API_POST(@"/ht/faburenwu/index.php/api/authentic")//认证信息
#define API_POST_clockRecord API_POST(@"/ht/faburenwu/index.php/api/clockRecord")//签到页面

#define API_POST_videoTask API_POST(@"/ht/faburenwu/index.php/api/videoTask")//看视频完成任务
#define API_POST_taskOver API_POST(@"/ht/faburenwu/index.php/api/taskOver")//是否完成过该视频任务
#define API_POST_echargeVip API_POST(@"/ht/faburenwu/index.php/api/rechargeVip")//开通会员

#define API_POST_withdraw API_POST(@"/ht/faburenwu/index.php/api/withdraw")//申请提现
#define API_POST_brokeragePrice API_POST(@"/ht/faburenwu/index.php/api/brokeragePrice")//佣金转余额
#define API_POST_checkBb API_POST(@"/ht/faburenwu/index.php/api/checkBb")//验证版本号
#define API_POST_question API_POST(@"/ht/faburenwu/index.php/api/question")//常见问题
#define API_POST_labelList API_POST(@"/ht/faburenwu/index.php/api/labelList")//标签列表
#define API_POST_website API_POST(@"/ht/faburenwu/index.php/api/website")//签到
#define API_POST_clockIn API_POST(@"/ht/faburenwu/index.php/api/clockIn")//签到
#define API_POST_service API_POST(@"/ht/faburenwu/index.php/api/service")//客服
#define API_POST_vipCard API_POST(@"/ht/faburenwu/index.php/api/vipCard")//会员卡页面
#define API_POST_checkUpgrade API_POST(@"/ht/faburenwu/index.php/api/checkUpgrade")//验证是否可升级会员
#define API_POST_upgradePage API_POST(@"/ht/faburenwu/index.php/api/upgradePage")//可升级会员
#define API_POST_checkVip API_POST(@"/ht/faburenwu/index.php/api/checkVip")//判断会员状态
#define API_POST_upgrade API_POST(@"/ht/faburenwu/index.php/api/upgrade")//升级会员
#define API_POST_bindAlipay API_POST(@"/ht/faburenwu/index.php/api/bindAccount")//绑定支付宝账号

/**
 * 微信APP ID，用于微信支付及分享
 * 如不启用微信支付和分享,则此项不用配置
 */
#define WECHAT_APP_ID @"wxb85942babf97eda2"
/**
 * 微信的App Secret，用于微信分享
 */
#define WECHAT_APP_SECRET @"4092505db5405747093aa90eea5fd5ef"

#endif /* HeardUrl_h */
