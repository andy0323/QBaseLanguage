#import "QBaseLanguage.h"

/** 语言环境变化 通知 */
#define QBASE_NOTIFICATION_LANGUAGE_CHANGED @"QBASE_NOTIFICATION_LANGUAGE_CHANGED"

/** 用户国际化（缓存KEY值） 缓存内容存放于 NSUserDefaults */
#define QBASE_KEY_DEFAULT_LANGUAGE  @"QBASE_KEY_DEFAULT_LANGUAGE"

/** 系统语言列表（系统KEY值） */
#define QBASE_KEY_SYSTEM_LANGUAGES @"AppleLanguages"


/** 语言资源包对象 */
static NSBundle *qbase_language_bundle;

/** 语言资源包包名 */
static NSString *qbase_language_table_name;

#pragma mark -
#pragma mark private @interface

NSString* get_language_str(QBaseLanguage language);


#pragma mark -
#pragma mark private @implementation

/**
 *  初始化语言环境（默认获取系统语言环境）
 */
void qbase_language_setup(NSString *local_table)
{
    qbase_language_table_name = local_table;
    
    // 获取用户默认语言
    NSString *lang = [[NSUserDefaults standardUserDefaults] valueForKey:QBASE_KEY_DEFAULT_LANGUAGE];
    
    // 首次启动，获取系统语言配置
    if(!lang.length) {
        lang = [[[NSUserDefaults standardUserDefaults] objectForKey:QBASE_KEY_SYSTEM_LANGUAGES] objectAtIndex:0];
        
        // 过滤地区名，统一加载字符串代码
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
            NSMutableArray *components = [lang componentsSeparatedByString:@"-"].mutableCopy;
            [components removeLastObject];
            
            lang = [components componentsJoinedByString:@"-"];
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:lang
                                                 forKey:QBASE_KEY_DEFAULT_LANGUAGE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // 语言资源设置
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj"];
    qbase_language_bundle = [NSBundle bundleWithPath:path];
}

/**
 *  设置用户语言环信
 */
void qbase_language_set_language(QBaseLanguage language)
{
    NSString *langStr = get_language_str(language);
    
    // 语言资源设置
    NSString *path = [[NSBundle mainBundle] pathForResource:langStr ofType:@"lproj" ];
    qbase_language_bundle = [NSBundle bundleWithPath:path];
    
    // 缓存用户设置
    [[NSUserDefaults standardUserDefaults] setValue:langStr
                                             forKey:QBASE_KEY_DEFAULT_LANGUAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];

    // 发出消息通知
    [[NSNotificationCenter defaultCenter] postNotificationName:QBASE_NOTIFICATION_LANGUAGE_CHANGED object:langStr];
}

/**
 *  获取语言资源包数据信息
 */
NSString *qbase_language_get_message(NSString *local_str, NSString *message)
{
    return [qbase_language_bundle localizedStringForKey:local_str
                                                  value:nil
                                                  table:qbase_language_table_name];
}

/**
 *  添加监听者，语言环境发生变化，进行回调
 */
void qbase_language_add_listener(id target, SEL callback)
{
    [[NSNotificationCenter defaultCenter] addObserver:target
                                             selector:callback
                                                 name:QBASE_NOTIFICATION_LANGUAGE_CHANGED
                                               object:nil];
}

/**
 *  移除监听者
 */
void qbase_language_remove_listener(id target)
{
    [[NSNotificationCenter defaultCenter] removeObserver:target name:QBASE_NOTIFICATION_LANGUAGE_CHANGED object:nil];
}

/**
 *  获取语言环境Key
 */
NSString* get_language_str(QBaseLanguage language)
{
    NSString *ret;
    switch (language) {
        case QBaseLanguage_en:
            ret = @"en";
            break;
            
        case QBaseLanguage_zh_Hans:
            ret = @"zh-Hans";
            break;
            
        default:
            ret = @"en";
            break;
    }
    return ret;
}