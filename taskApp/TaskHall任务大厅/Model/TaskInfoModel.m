//
//  TaskInfoModel.m
//  taskApp
//
//  Created by 秦程 on 2020/9/15.
//  Copyright © 2020 per. All rights reserved.
//

#import "TaskInfoModel.h"

@implementation TaskBaseModel

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([property.name isEqualToString:@"detail"]) {
        NSString *htmlStr = [oldValue stringByReplacingOccurrencesOfString:@"src=\"/ht" withString: [NSString stringWithFormat: @"src=\"%@/ht", API_URL]];
        return [NSString stringWithFormat:@"<html> \n"   //html跟标签
                "<head> \n"                         //html头部标签
                "<style type=\"text/css\"> \n"      //css内部样式的写法
                //css里面的标签选择器, 以及两条声明,一个控制到父标签的边距,一个控制字体的大小
                "body {font-size: %dpx;}\n"
                "</style> \n"
                "</head> \n"
                "<body>%@</body> \n"               //html里面的主体标签
                "</html>", 18, htmlStr];
    }

    return oldValue;
}

@end

@implementation TaskInfoModel

@end

@implementation TaskDetailModel

@end

