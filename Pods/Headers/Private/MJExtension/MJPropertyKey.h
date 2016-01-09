// 
// MJPropertyKey.h
//
// IDECodeSnippetIdentifier: 55BB616D-81C7-44B6-8B0A-B78EFC4C36D1
// IDECodeSnippetLanguage: Xcode.SourceCodeLanguage.Objective-C
// IDECodeSnippetUserSnippet: 1

#import <Foundation/Foundation.h>

typedef enum {
    MJPropertyKeyTypeDictionary = 0, // 字典的key
    MJPropertyKeyTypeArray // 数组的key
} MJPropertyKeyType;

/**
 *  属性的key
 */
@interface MJPropertyKey : NSObject
/** key的名字 */
@property (copy,   nonatomic) NSString *name;
/** key的种类，可能是@"10"，可能是@"age" */
@property (assign, nonatomic) MJPropertyKeyType type;

/**
 *  根据当前的key，也就是name，从object（字典或者数组）中取值
 */
- (id)valueInObject:(id)object;

@end
