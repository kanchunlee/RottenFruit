//
//  GeneralUtil.m
//  RottenFruit
//
//  Created by Kent Lee on 2015/6/17.
//  Copyright (c) 2015年 Kent Lee. All rights reserved.
//

#import "GeneralUtil.h"

@implementation GeneralUtil

+ (void)asynchronousRequestOnJsonAPI:(NSString *)url
callback:(void (^)(NSData *))callback {
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:theRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            callback(data);
        }
    }];
}

@end