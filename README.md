# QBaseLanguage

客户端国际化组件

## Usage

### 注册语言资源包（如果不注册、会一直加载英文版本资源文件）

```
    qbase_language_setup(@"QBaseLocalizable");
```

### 获取对应的语言内容

```
    NSString *message = qbase_language_get_message(@"hello", @"你好");
```

### 修改客户端默认语言（每次启动、展现的语言）

```
qbase_language_set_language();
```

### 注册/注销监听（语言设置变化）
```
	// 注册监听者
	qbase_language_add_listener(self, @selector(languageChanged:));

	// 注销监听者
    qbase_language_remove_listener(self);
```

## Contact

**author:** Andy Jin  
**Email:** andy_ios@163.com

##Licenses

All source code is licensed under the [MIT License](https://github.com/andy0323/QBaseLanguage/blob/master/LICENSE).
