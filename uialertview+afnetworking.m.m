// UIAlertView+AFNetworking.m
// Copyright (c) 2011–2015 Alamofire Software Foundation (http://alamofire.org/)
//
// IDECodeSnippetCompletionScopes: [All]
// IDECodeSnippetIdentifier: BFBE3AF9-C0B2-4480-A8DF-898D7CEDEB91
// IDECodeSnippetLanguage: Xcode.SourceCodeLanguage.Objective-C
// IDECodeSnippetUserSnippet: 1
// IDECodeSnippetVersion: 2

#import "UIAlertView+AFNetworking.h"

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && !defined(AF_APP_EXTENSIONS)

#import "AFURLConnectionOperation.h"

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#import "AFURLSessionManager.h"
#endif

static void AFGetAlertViewTitleAndMessageFromError(NSError *error, NSString * __autoreleasing *title, NSString * __autoreleasing *message) {
    if (error.localizedDescription && (error.localizedRecoverySuggestion || error.localizedFailureReason)) {
        *title = error.localizedDescription;

        if (error.localizedRecoverySuggestion) {
            *message = error.localizedRecoverySuggestion;
        } else {
            *message = error.localizedFailureReason;
        }
    } else if (error.localizedDescription) {
        *title = NSLocalizedStringFromTable(@"Error", @"AFNetworking", @"Fallback Error Description");
        *message = error.localizedDescription;
    } else {
        *title = NSLocalizedStringFromTable(@"Error", @"AFNetworking", @"Fallback Error Description");
        *message = [NSString stringWithFormat:NSLocalizedStringFromTable(@"%@ Error: %ld", @"AFNetworking", @"Fallback Error Failure Reason Format"), error.domain, (long)error.code];
    }
}

@implementation UIAlertView (AFNetworking)

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
+ (void)showAlertViewForTaskWithErrorOnCompletion:(NSURLSessionTask *)task
                                         delegate:(id)delegate
{
    [self showAlertViewForTaskWithErrorOnCompletion:task delegate:delegate cancelButtonTitle:NSLocalizedStringFromTable(@"Dismiss", @"AFNetworking", @"UIAlertView Cancel Button Title") otherButtonTitles:nil, nil];
}

+ (void)showAlertViewForTaskWithErrorOnCompletion:(NSURLSessionTask *)task
                                         delegate:(id)delegate
                                cancelButtonTitle:(NSString *)cancelButtonTitle
                                otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray *mutableOtherTitles = [NSMutableArray array];
    va_list otherButtonTitleList;
    va_start(otherButtonTitleList, otherButtonTitles);
    {
        for (NSString *otherButtonTitle = otherButtonTitles; otherButtonTitle != nil; otherButtonTitle = va_arg(otherButtonTitleList, NSString *)) {
            [mutableOtherTitles addObject:otherButtonTitle];
        }
    }
    va_end(otherButtonTitleList);

    __block __weak id<NSObject> observer = [[NSNotificationCenter defaultCenter] addObserverForName:AFNetworkingTaskDidCompleteNotification object:task queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
        NSError *error = notification.userInfo[AFNetworkingTaskDidCompleteErrorKey];
        if (error) {
            NSString *title, *message;
            AFGetAlertViewTitleAndMessageFromError(error, &title, &message);

            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
            for (NSString *otherButtonTitle in mutableOtherTitles) {
                [alertView addButtonWithTitle:otherButtonTitle];
            }
            [alertView setTitle:title];
            [alertView setMessage:message];
            [alertView show];
        }

        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}
#endif

#pragma mark -

+ (void)showAlertViewForRequestOperationWithErrorOnCompletion:(AFURLConnectionOperation *)operation
                                                     delegate:(id)delegate
{
    [self showAlertViewForRequestOperationWithErrorOnCompletion:operation delegate:delegate cancelButtonTitle:NSLocalizedStringFromTable(@"Dismiss", @"AFNetworking", @"UIAlertView Cancel Button Title") otherButtonTitles:nil, nil];
}

+ (void)showAlertViewForRequestOperationWithErrorOnCompletion:(AFURLConnectionOperation *)operation
                                                     delegate:(id)delegate
                                            cancelButtonTitle:(NSString *)cancelButtonTitle
                                            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    NSMutableArray *mutableOtherTitles = [NSMutableArray array];
    va_list otherButtonTitleList;
    va_start(otherButtonTitleList, otherButtonTitles);
    {
        for (NSString *otherButtonTitle = otherButtonTitles; otherButtonTitle != nil; otherButtonTitle = va_arg(otherButtonTitleList, NSString *)) {
            [mutableOtherTitles addObject:otherButtonTitle];
        }
    }
    va_end(otherButtonTitleList);

    __block __weak id<NSObject> observer = [[NSNotificationCenter defaultCenter] addObserverForName:AFNetworkingOperationDidFinishNotification object:operation queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {

        if (notification.object && [notification.object isKindOfClass:[AFURLConnectionOperation class]]) {
            NSError *error = [(AFURLConnectionOperation *)notification.object error];
            if (error) {
                NSString *title, *message;
                AFGetAlertViewTitleAndMessageFromError(error, &title, &message);

                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
                for (NSString *otherButtonTitle in mutableOtherTitles) {
                    [alertView addButtonWithTitle:otherButtonTitle];
                }
                [alertView setTitle:title];
                [alertView setMessage:message];
                [alertView show];
            }
        }

        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}

@end

#endif
