//
//  HomeWebViC.h
//  taskApp
//
//  Created by per on 2020/1/4.
//  Copyright © 2020 per. All rights reserved.
//

#import "BassMianViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeWebViC : BassMianViewController

@property(nonatomic, copy)NSString * context;
@property(nonatomic, copy)NSString * name;
@property(nonatomic, copy)NSURL * url;

-(instancetype)initWithURL:(NSURL *) url;
-(instancetype)initWithContent:(NSString *) htmlString;

@end

NS_ASSUME_NONNULL_END
