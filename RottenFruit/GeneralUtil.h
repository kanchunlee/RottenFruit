//
//  GeneralUtil.h
//  RottenFruit
//
//  Created by Kent Lee on 2015/6/17.
//  Copyright (c) 2015年 Kent Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface GeneralUtil: NSObject

+ (void)asynchronousRequestOnJsonAPI:(NSString *)url
                            callback:(void (^)(NSData *))callback;

@end