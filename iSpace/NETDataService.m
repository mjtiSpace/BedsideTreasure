//
//  SGDataService.m
//  ASIService
//
//  Created by Width on 14-2-28.
//  Copyright (c) 2014年 mojingtao. All rights reserved.
//

#import "NetDataService.h"
#import "NSString+URLEncoding.h"
#import "NSNumber+Message.h"
#import "SBJsonWriter.h"

@implementation NetDataService

+(ASIHTTPRequest*)requestWithUrl:(NSString *)urlString dictParams:(NSMutableDictionary *)dictparams httpMethod:(NSString *)httpMethod completeBlock:(requestFinishBlock)block
{
    NSURL *url = [NSURL URLWithString:[urlString URLEncodedString]];
    __weak ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setTimeOutSeconds:60];
    [request setRequestMethod:httpMethod];
    //比较看是post还是get请求
    NSComparisonResult comparRet = [httpMethod caseInsensitiveCompare:@"POST"];
    if (comparRet == NSOrderedSame) {
        //把字典转化为json
        SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
        NSString *jsonStr = [jsonWriter stringWithObject:dictparams];
        
        //添加请求头还有请求体
        [request addRequestHeader:@"content-type" value:@"application/json"];
        [request appendPostData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding ]];
        
    }
    //请求完成的block
    [request setCompletionBlock:^{
        __weak NSString *getStr = [request responseString] ;
        //json解析（ios5以后NSJSONSerialization）
        id result = [NSJSONSerialization JSONObjectWithData:[getStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"request=====%@",request);
        if (block != nil) {
            block(result);
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        block([error localizedDescription]);
    }];
    [request startAsynchronous];
    return nil ;
}


@end
