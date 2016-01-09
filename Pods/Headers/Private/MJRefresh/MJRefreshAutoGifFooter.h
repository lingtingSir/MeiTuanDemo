// 
// MJRefreshAutoGifFooter.h
//
// IDECodeSnippetIdentifier: BF30A41E-8B4F-4F47-B3AF-4A3B1928AC9E
// IDECodeSnippetLanguage: Xcode.SourceCodeLanguage.Objective-C
// IDECodeSnippetUserSnippet: 1

#import "MJRefreshAutoStateFooter.h"

@interface MJRefreshAutoGifFooter : MJRefreshAutoStateFooter
/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state;
@end
