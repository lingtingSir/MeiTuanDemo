// 
// MJRefreshBackGifFooter.h
//
// IDECodeSnippetIdentifier: A889203F-C40F-4EBB-8CE1-4ADC4406A0F6
// IDECodeSnippetLanguage: Xcode.SourceCodeLanguage.Objective-C
// IDECodeSnippetUserSnippet: 1

#import "MJRefreshBackStateFooter.h"

@interface MJRefreshBackGifFooter : MJRefreshBackStateFooter
/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state;
@end
