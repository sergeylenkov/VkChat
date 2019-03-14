//
//  VKMarkAsReadRequest.m
//  VKMessages
//
//  Created by Sergey Lenkov on 22.05.12.
//  Copyright (c) 2012 Sergey Lenkov. All rights reserved.
//

#import "VKMarkAsReadRequest.h"

@implementation VKMarkAsReadRequest

@synthesize messageID;

- (void)dealloc {
    [_resultBlock release];
    [super dealloc];
}

- (void)startWithResultBlock:(VKMarkAsReadRequestResultBlock)aResultBlock failureBlock:(VKRequestFailureBlock)aFailureBlock {
    _resultBlock = [aResultBlock copy];
    _failureBlock = [aFailureBlock copy];
    
    _method = @"messages.markAsRead";
    
    [self addParamWithKey:@"mids" value:[NSString stringWithFormat:@"%ld", messageID]];
    
    [self start];
}

- (void)parseResponse {
    [super parseResponse];
    
    if (!_error) {
        if ([[_response objectForKey:@"response"] intValue] == 1) {
            if (_resultBlock) {
                _resultBlock(messageID);
            }
        } else {
            NSMutableDictionary *errorDetails = [NSMutableDictionary dictionary];
            [errorDetails setValue:@"" forKey:NSLocalizedDescriptionKey];
            
            _error = [[NSError errorWithDomain:VK_ERROR_DOMAIN code:1000 userInfo:errorDetails] retain];
            
            if (_failureBlock) {
                _failureBlock(_error);
            }
        }        
    }
}

@end
