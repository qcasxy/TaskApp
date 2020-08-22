//
//  AppDelegate.h
//  taskApp
//
//  Created by per on 2019/11/7.
//  Copyright © 2019 per. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

