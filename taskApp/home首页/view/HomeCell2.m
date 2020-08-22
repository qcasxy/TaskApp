//
//  HomeCell2.m
//  taskApp
//
//  Created by per on 2019/11/8.
//  Copyright © 2019 per. All rights reserved.
//

#import "HomeCell2.h"

@implementation HomeCell2
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.img1 = [[UIImageView alloc]init];
        self.img1.backgroundColor =[UIColor whiteColor];
        self.img1.image =[UIImage imageNamed:@"shouye-1"];
        [self addSubview:self.img1];
        [self.img1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(width(10));
            make.right.mas_equalTo(self.mas_right).offset(-width(10));///2-width(23)
            make.top.mas_equalTo(self).offset(height(0));
            make.bottom.mas_equalTo(self.mas_bottom).offset(-height(5));
        }];
//        self.img2 = [[UIImageView alloc]init];
//        self.img2.backgroundColor =[UIColor whiteColor];
//        self.img2.image =[UIImage imageNamed:@"shop"];
//        [self addSubview:self.img2];
//        [self.img2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(self.mas_right).offset(-width(10));
//            make.left.mas_equalTo(self.img1.mas_right).offset(width(15));
//            make.top.mas_equalTo(self).offset(height(0));
//            make.bottom.mas_equalTo(self.mas_bottom).offset(-height(5));
//        }];
    }
    return self;
}
@end
