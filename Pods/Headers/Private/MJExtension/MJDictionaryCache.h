// 
// MJDictionaryCache.h
//
// IDECodeSnippetIdentifier: 00A5ED1F-1C51-43B6-B88B-8EB5E1027C23
// IDECodeSnippetLanguage: Xcode.SourceCodeLanguage.Objective-C
// IDECodeSnippetUserSnippet: 1

#import <Foundation/Foundation.h>

@interface MJDictionaryCache : NSObject
/**
 *  缓存数据
 *
 *  @param dictId 字典标识
 *
 *  @return 缓存的字典
 */
+ (id)setObject:(id)object forKey:(id<NSCopying>)key forDictId:(const void *)dictId;

/**
 *  获得缓存的数据
 *
 *  @param dictId 字典标识
 */
+ (id)objectForKey:(id<NSCopying>)key forDictId:(const void *)dictId;

/**
 *  获得缓存的字典
 *
 *  @param dictId 字典标识
 */
+ (id)dictWithDictId:(const void *)dictId;
@end
