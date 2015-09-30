#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, QBaseLanguage) {
    QBaseLanguage_en,
    QBaseLanguage_zh_Hans
};

/**
 *  初始化语言环境（默认获取系统语言环境）
 */
void qbase_language_setup(NSString *local_table);

/**
 *  设置用户语言环境
 *
 *  @param language 国际化语言字符串标示
 */
void qbase_language_set_language(QBaseLanguage language);

/**
 *  获取对应的语言
 *
 *  @param local_str 语言环境
 *  @param message   提示信息
 *
 *  @return 消息内容
 */
NSString *qbase_language_get_message(NSString *local_str, NSString *message);


/**
 *  添加监听者，语言环境发生变化，进行回调
 */
void qbase_language_add_listener(id target, SEL callback);

/**
 *  移除监听者
 */
void qbase_language_remove_listener(id target);
