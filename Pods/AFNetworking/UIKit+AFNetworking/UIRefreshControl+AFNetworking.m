// UIRefreshControl+AFNetworking.m
// 
//
// IDECodeSnippetIdentifier: 210B12ED-372A-442E-8497-95F9F6802B2D
// IDECodeSnippetLanguage: Xcode.SourceCodeLanguage.Objective-C
// IDECodeSnippetUserSnippet: 1

#import "UIRefreshControl+AFNetworking.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import "AFHTTPRequestOperation.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#import "AFURLSessionManager.h"
#endif

@implementation UIRefreshControl (AFNetworking)

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
- (void)setRefreshingWithStateOfTask:(NSURLSessionTask *)task {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter removeObserver:self name:AFNetworkingTaskDidResumeNotification object:nil];
    [notificationCenter removeObserver:self name:AFNetworkingTaskDidSuspendNotification object:nil];
    [notificationCenter removeObserver:self name:AFNetworkingTaskDidCompleteNotification object:nil];

    if (task) {
        if (task.state == NSURLSessionTaskStateRunning) {
            [self beginRefreshing];

            [notificationCenter addObserver:self selector:@selector(af_beginRefreshing) name:AFNetworkingTaskDidResumeNotification object:task];
            [notificationCenter addObserver:self selector:@selector(af_endRefreshing) name:AFNetworkingTaskDidCompleteNotification object:task];
            [notificationCenter addObserver:self selector:@selector(af_endRefreshing) name:AFNetworkingTaskDidSuspendNotification object:task];
        } else {
            [self endRefreshing];
        }
    }
}
#endif

- (void)setRefreshingWithStateOfOperation:(AFURLConnectionOperation *)operation {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];

    [notificationCenter removeObserver:self name:AFNetworkingOperationDidStartNotification object:nil];
    [notificationCenter removeObserver:self name:AFNetworkingOperationDidFinishNotification object:nil];

    if (operation) {
        if (![operation isFinished]) {
            if ([operation isExecuting]) {
                [self beginRefreshing];
            } else {
                [self endRefreshing];
            }

            [notificationCenter addObserver:self selector:@selector(af_beginRefreshing) name:AFNetworkingOperationDidStartNotification object:operation];
            [notificationCenter addObserver:self selector:@selector(af_endRefreshing) name:AFNetworkingOperationDidFinishNotification object:operation];
        }
    }
}

#pragma mark -

- (void)af_beginRefreshing {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self beginRefreshing];
    });
}

- (void)af_endRefreshing {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self endRefreshing];
    });
}

@end

#endif
