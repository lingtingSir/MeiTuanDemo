// 
// MJRefreshAutoStateFooter.h
//
// IDECodeSnippetCompletionScopes: [All]
// IDECodeSnippetIdentifier: C05F6FC6-311A-420E-BD7F-2AEC883C9C16
// IDECodeSnippetLanguage: Xcode.SourceCodeLanguage.Objective-C
// IDECodeSnippetUserSnippet: 1
// IDECodeSnippetVersion: 2

#import "MJRefreshAutoFooter.h"

@interface MJRefreshAutoStateFooter : MJRefreshAutoFooter
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;

/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;

/** 隐藏刷新状态的文字 */
@property (assign, nonatomic, getter=isRefreshingTitleHidden) BOOL refreshingTitleHidden;
@end
